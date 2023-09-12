//
//  CustomMarker.swift
//  PlotApp
//
//  Created by Lucas Ferreira on 9/1/23.
//

import DGCharts
import UIKit

class CustomMarkerView: MarkerView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }

    private func initUI() {
        Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)
        addSubview(contentView)

        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 5

        self.frame = CGRect(x: 0, y: 0, width: 79, height: 73)
        self.offset = CGPoint(x: -(self.frame.width/2), y: -self.frame.height)
    }


}
