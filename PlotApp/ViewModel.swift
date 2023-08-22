//
//  ViewModel.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/18/23.
//

import Foundation
import DGCharts

class ViewModel {

    func loadChartView() -> ChartData? {
        guard let datasets = jsonParser() else {
            return nil
        }
        let data = ScatterChartData(dataSets: datasets)



        return data
    }

    func format(_ chartView: ScatterChartView) {
        formatLegend(legend: chartView.legend)
        formatLeftAxis(leftAxis: chartView.leftAxis)
        formatRightAxis(rightAxis: chartView.rightAxis)
    }

    private func jsonParser() -> [ScatterChartDataSet]? {

        guard let path = Bundle.main.path(forResource: "sample-tsne", ofType: "json") else {
            return nil
        }
        let url = URL(filePath: path)

        var datasets: [String: [ChartDataEntry]] = [:]
        var scatterChartDatasets: [ScatterChartDataSet] = []

        do {
            let jsonData = try Data(contentsOf: url)
            let dataPoints = try JSONDecoder().decode([DataPoint].self, from: jsonData)
            let colors: [NSUIColor] = [.red, .blue, .green, .purple, .orange, .yellow, .darkGray, .white, .darkGray, .black, .brown, .cyan] // Add more colors as needed
            var colorIndex = 0

            // Now you can work with the parsed dataPoints array
            for dataPoint in dataPoints {
                let chartDataEntry = ChartDataEntry(x: Double(dataPoint.x)!, y: Double(dataPoint.y)!)
                if datasets[dataPoint.syndromeName] == nil {
                    datasets[dataPoint.syndromeName] = []
                }
                datasets[dataPoint.syndromeName]?.append(chartDataEntry)
            }

            for (syndromeName, chartDataEntry) in datasets {
                let scatterChartDataset = ScatterChartDataSet(entries: chartDataEntry, label: syndromeName)
                if syndromeName == "Patient" {
                    scatterChartDataset.setScatterShape(.triangle)
                } else {
                    scatterChartDataset.setScatterShape(.circle)
                }
                scatterChartDataset.colors = [colors[colorIndex].withAlphaComponent(0.40)]
                scatterChartDatasets.append(scatterChartDataset)
                colorIndex += 1

            }
        } catch {
            print("Error parsing JSON: \(error)")
        }

        return scatterChartDatasets
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
