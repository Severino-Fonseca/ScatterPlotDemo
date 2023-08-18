//
//  AAChartView.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/16/23.
//

import Foundation

struct DataPoint: Codable {
    let imageID: String
    let syndromeName: String
    let y: String
    let x: String
    let field1: Int
    let syndromeID: String

    enum CodingKeys: String, CodingKey {
        case imageID = "Image_ID"
        case syndromeName = "Syndrome_Name"
        case y = "Y"
        case x = "X"
        case field1 = "FIELD1"
        case syndromeID = "Syndrome_ID"
    }
}



