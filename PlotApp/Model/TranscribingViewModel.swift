//
//  TranscribingViewModel.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 9/4/23.
//

import Foundation

protocol TranscribingViewModelDelegate: AnyObject {
    func recognitionStateChanged(_ state: RecognitionState)
    func updateRecognitionText(_ text: String, isFinal: Bool)
}

class TranscribingViewModel {

    weak var delegate: TranscribingViewModelDelegate?
    private var speechRecognitionHelper = SpeechRecognitionHelper()
    var recognitionText: String = ""
    var recognitionButton = SpeechRecognitionButton()

    func initialize() {
        speechRecognitionHelper.delegate = self
        speechRecognitionHelper.initialize()
    }

    func startStopRecognition() {
        speechRecognitionHelper.startStopRecognition()
    }
    
    func end() {
        speechRecognitionHelper.end()
    }



}

extension TranscribingViewModel: SpeechRecognitionProtocol {
    func recognitionLoading() {
        delegate?.recognitionStateChanged(.loading)
    }

    func recognitionUnavailableForLocale() {
        delegate?.recognitionStateChanged(.notAvailable)
    }

    func recognitionTemporarilyUnavailable() {
        delegate?.recognitionStateChanged(.disabled)
    }

    func recognition(isAuthorized: Bool) {
        delegate?.recognitionStateChanged(isAuthorized ? .stopped : .disabled)
    }

    func recognition(isReady: Bool) {
        delegate?.recognitionStateChanged(isReady ? .stopped : .disabled)
    }

    func recognitionStarted() {
        delegate?.recognitionStateChanged(.recognizing)
    }

    func recognitionFinished() {
        delegate?.recognitionStateChanged(.stopped)
    }

    func recognitionTextUpdate(text: String, isFinal: Bool) {
        delegate?.updateRecognitionText(text, isFinal: isFinal)
    }
}

