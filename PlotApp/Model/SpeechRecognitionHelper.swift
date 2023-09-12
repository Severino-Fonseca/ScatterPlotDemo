//
//  SpeechRecognizerHelper.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 9/4/23.
//

import Foundation
import Speech
import UIKit

public protocol SpeechRecognitionProtocol {
    func recognitionUnavailableForLocale()  // Speech recognition not available for the locale
    func recognitionTemporarilyUnavailable()  // Speech recognition not available temporarily
    func recognition(isAuthorized: Bool)  // The user has authorized speech recognition
    func recognition(isReady: Bool)  // Ready to start doing speech recognition
    func recognitionStarted()  // Speech-to-text process started
    func recognitionFinished()  // Speech-to-text process stopped
    func recognitionLoading()
    func recognitionTextUpdate(text: String, isFinal: Bool)  // Speech-to-text update available
}

open class SpeechRecognitionHelper: NSObject {
    fileprivate let audioEngine = AVAudioEngine()
    fileprivate var speechRecognizer: SFSpeechRecognizer?
    fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recognitionTask: SFSpeechRecognitionTask?

    public var delegate: SpeechRecognitionProtocol?

    public func initialize() {
        guard delegate != nil else {
            fatalError()
        }

        delegate?.recognitionLoading()
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

        guard speechRecognizer != nil else {
            delegate?.recognitionUnavailableForLocale()
            return
        }

        guard speechRecognizer!.isAvailable else {
            delegate?.recognitionTemporarilyUnavailable()
            return
        }

        speechRecognizer!.delegate = self

        SFSpeechRecognizer.requestAuthorization { authStatus in

            DispatchQueue.main.async {
                self.delegate?.recognition(isAuthorized: authStatus == .authorized)
                self.delegate?.recognition(isReady: authStatus == .authorized)
            }
        }
    }

    /// Starts and new speech recognition session, or stops the current one
    public func startStopRecognition() {
        if audioEngine.isRunning {
            delegate?.recognitionLoading()
            stopRecognition()
        } else {
            try! startDictation()
        }
    }

    /// Cancels the current recognition session
    public func end() {
        stopRecognition(finish: false)
    }

    fileprivate func startDictation() throws {
        guard speechRecognizer != nil else { return }

        // Stop the previous task if it's running.
        stopRecognition()
        delegate?.recognitionLoading()

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard recognitionRequest != nil else { return }

        recognitionRequest!.shouldReportPartialResults = true  // Results are returned before audio recording is finished

        // New for iOS 13. Keep speech recognition data on device if possible (if it's supported)
        if #available(iOS 13, *) {
            recognitionRequest!.requiresOnDeviceRecognition = speechRecognizer!.supportsOnDeviceRecognition
        }

        // Configure the microphone input
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [unowned self] buffer, when in
            self.recognitionRequest?.append(buffer)
        }

        recognitionTask = speechRecognizer!.recognitionTask(with: recognitionRequest!) { [unowned self] result, error in

            if error != nil {
                self.stopRecognition()
                delegate?.recognitionFinished()
            }
            if let r = result {
                self.delegate?.recognitionTextUpdate(text: r.bestTranscription.formattedString, isFinal: r.isFinal)
                delegate?.recognitionFinished()
            }
        }

        audioEngine.prepare()
        try audioEngine.start()

        delegate?.recognitionStarted()
    }

    fileprivate func stopRecognition(finish: Bool = true) {
        if audioEngine.isRunning {
            audioEngine.stop()
        }

        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()

        if finish {
            recognitionTask?.finish()
        } else {
            recognitionTask?.cancel()
        }

        recognitionRequest = nil
        recognitionTask = nil
    }
}

// MARK: SFSpeechRecognizerDelegate

extension SpeechRecognitionHelper: SFSpeechRecognizerDelegate {

    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        delegate?.recognition(isReady: available)
    }
}

