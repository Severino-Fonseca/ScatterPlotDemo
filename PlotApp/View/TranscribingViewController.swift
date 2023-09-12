//
//  TranscribingViewController.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 9/4/23.
//

import Foundation
import UIKit

class TrancribingViewController: UIViewController, TranscribingViewModelDelegate {
    let viewModel = TranscribingViewModel()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var recognitionButton: SpeechRecognitionButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.delegate = self
        viewModel.initialize()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        viewModel.end()
    }

    @IBAction func recognitionButtonTapped(_ sender: Any) {
        viewModel.startStopRecognition()
    }

    func recognitionStateChanged(_ state: RecognitionState) {
        recognitionButton.recognitionState = state
    }

    func updateRecognitionText(_ text: String, isFinal: Bool) {
        textView.text = text
    }
}
