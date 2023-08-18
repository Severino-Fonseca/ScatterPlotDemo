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

    @IBOutlet weak var chartView: ScatterChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = viewModel.loadChartView() {
            chartView.data = data
            viewModel.format(chartView)
        }
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
