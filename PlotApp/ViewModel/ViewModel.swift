//
//  ViewModel.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/18/23.
//

import Foundation
import DGCharts

class ViewModel {

    var datasets: DataSets? {
        guard let sets = jsonParser() else {
            return nil
        }
        return sets
    }

    func getChartData() -> ChartData? {
        guard let scatterDataset = datasets?.datasetsToScatterDataSet() else { return nil }
        return ScatterChartData(dataSets: scatterDataset)
    }

    func format(_ chartView: ScatterChartView) {
        formatLegend(legend: chartView.legend)
        formatLeftAxis(leftAxis: chartView.leftAxis)
        formatRightAxis(rightAxis: chartView.rightAxis)
    }

    private func jsonParser() -> DataSets? {

        guard let path = Bundle.main.path(forResource: "sample-tsne", ofType: "json") else {
            return nil
        }
        let url = URL(filePath: path)
        var dataSets = DataSets()

        do {
            let jsonData = try Data(contentsOf: url)
            let dataPoints = try JSONDecoder().decode([DataPoint].self, from: jsonData)

            // Now you can work with the parsed dataPoints array
            for dataPoint in dataPoints {
                dataSets.addDataPoint(dataPoint)
            }

        } catch {
            print("Error parsing JSON: \(error)")
        }

        return dataSets
    }

    private func formatLegend(legend: Legend) {
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = false
        legend.xOffset = 5
    }

    private func formatLeftAxis(leftAxis: YAxis) {
//        leftAxis.axisMinimum = 0
    }

    private func formatRightAxis(rightAxis: YAxis) {
        rightAxis.enabled = false
    }

}
