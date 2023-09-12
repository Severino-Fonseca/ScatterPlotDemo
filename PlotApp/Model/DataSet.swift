//
//  DataSet.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/22/23.
//

import Foundation
import DGCharts
import UIKit

struct DataSet {
    var syndromeName: String
    var chartDataEntries: [ChartDataEntry]
    var color: UIColor {
        SyndromeColor(rawValue: syndromeName)?.color ?? UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
    }
}

struct DataSets {
    var dataSets: [DataSet] = []

    mutating func addDataPoint(_ dataPoint: DataPoint) {
        let chartDataEntry = dataPoint.toChartDataEntry()
        let syndromeName = dataPoint.syndromeName

        if let existingDataSetIndex = dataSets.firstIndex(where: {$0.syndromeName == syndromeName}) {
            dataSets[existingDataSetIndex].chartDataEntries.append(chartDataEntry)
        } else {
            let newDataSet = DataSet(syndromeName: syndromeName, chartDataEntries: [chartDataEntry])
            dataSets.append(newDataSet)
        }
    }

    func datasetsToScatterDataSet() -> [ScatterChartDataSet] {
        var scatterDataSets: [ScatterChartDataSet] = []

        for dataSet in dataSets {
            let scatterDataSet = ScatterChartDataSet(entries: dataSet.chartDataEntries, label: dataSet.syndromeName)
            scatterDataSet.setScatterShape(dataSet.syndromeName == "Patient" ? .triangle : .circle)
            scatterDataSet.colors = [dataSet.color]
            scatterDataSets.append(scatterDataSet)
        }

        return scatterDataSets
    }
}
