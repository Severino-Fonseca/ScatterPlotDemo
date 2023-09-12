//
//  AAChartView.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/16/23.
//

import Foundation
import UIKit
import DGCharts

struct DataPoint: Codable {
    let imageID: String
    let syndromeName: String
    let y: String
    let x: String
    let field1: Int
    let syndromeID: String

    func toChartDataEntry() -> ChartDataEntry {
        ChartDataEntry(x: Double(x) ?? 0.0, y: Double(y) ?? 0.0)
    }

    enum CodingKeys: String, CodingKey {
        case imageID = "Image_ID"
        case syndromeName = "Syndrome_Name"
        case y = "Y"
        case x = "X"
        case field1 = "FIELD1"
        case syndromeID = "Syndrome_ID"
    }
}
