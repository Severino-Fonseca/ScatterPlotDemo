//
//  AppUtility.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/18/23.
//

import Foundation
import UIKit

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}

enum SyndromeColor: String {
    case fragileXSyndromeFXS = "Fragile X Syndrome; FXS"
    case cherubism = "Cherubism"
    case osteosclerosis = "Osteosclerosis"
    case chudleyMcculloughSyndromeCMCS = "Chudley-Mccullough Syndrome; CMCS"
    case fetalAlcoholSyndromeFAS = "Fetal Alcohol Syndrome; FAS"
    case leighSyndromeLS = "Leigh Syndrome; LS"
    case chromosome16q22Deletion = "Chromosome 16q22 Deletion Syndrome"
    case chromosome15g133Deletion = "Chromosome 15q13.3 Deletion Syndrome"
    case Microdeletion6q2233Syndrome = "6q22.33 Microdeletion Syndrome"
    case roifmanSyndromeRFMN = "Roifman Syndrome; RFMN"
    case ichthyosisVulgaris = "Ichthyosis Vulgaris"
    // Add more cases for other syndromes...

    var color: UIColor {
        switch self {
        case .fragileXSyndromeFXS:
            return UIColor(red: 40/255, green: 120/255, blue: 180/255, alpha: 0.5)
        case .cherubism:
            return UIColor(red: 250/255, green: 130/255, blue: 40/255, alpha: 0.5)
        // Set colors for other syndromes...
        case .osteosclerosis:
            return UIColor(red: 50/255, green: 160/255, blue: 50/255, alpha: 0.5)
        case .chudleyMcculloughSyndromeCMCS:
            return UIColor(red: 210/255, green: 55/255, blue: 60/255, alpha: 0.5)
        case .fetalAlcoholSyndromeFAS:
            return UIColor(red: 150/255, green: 100/255, blue: 190/255, alpha: 0.5)
        case .leighSyndromeLS:
            return UIColor(red: 140/255, green: 90/255, blue: 80/255, alpha: 0.5)
        case .chromosome16q22Deletion:
            return UIColor(red: 225/255, green: 120/255, blue: 190/255, alpha: 0.5)
        case .chromosome15g133Deletion:
            return UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 0.5)
        case .Microdeletion6q2233Syndrome:
            return UIColor(red: 188/255, green: 188/255, blue: 52/255, alpha: 0.5)
        case .roifmanSyndromeRFMN:
            return UIColor(red: 40/255, green: 190/255, blue: 205/255, alpha: 0.5)
        case .ichthyosisVulgaris:
            return UIColor(red: 30/255, green: 100/255, blue: 170/255, alpha: 0.5)
        }
    }
}

extension Collection {

    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
