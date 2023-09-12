//
//  ViewController.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 8/16/23.
//

import UIKit
import DGCharts

class ViewController: UIViewController {

    let viewModel: ViewModel = ViewModel()
    let customMarkerView = CustomMarkerView()

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var chartView: ScatterChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChart()
        setupMarker()
    }

    func setupChart() {
        iconImage.image = UIImage(systemName: "tree")
        if let data = viewModel.getChartData() {
            chartView.data = data
            viewModel.format(chartView)
        }
        chartView.delegate = self
    }

    func setupMarker() {
        customMarkerView.chartView = chartView
        chartView.marker = customMarkerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        AppUtility.lockOrientation(.landscape)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        AppUtility.lockOrientation(.all)
    }
}

extension ViewController: ChartViewDelegate {

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let dataset = chartView.data?.dataSets[highlight.dataSetIndex] else { return }

        customMarkerView.label.text = dataset.label
    }
}
