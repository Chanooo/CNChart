//
//  VerticalViewController.swift
//  CNChart_Example
//
//  Created by CNOO on 2021/07/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import CNChart

class VerticalViewController:
    UIViewController,
    CNChartDelegate
{
    
    @IBOutlet weak var chartView: CNChart!
    
    private var data: [ChartData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        chartView.reloadChart(data: data, isEnd: false)
    }
    
    
    // MARK: - CNChartDelegate
    private var count = 1
    func onLoadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.count += 1
            for i in 0...10 {
                let chart = ChartData(id: "\(i)_\(self.count)",
                                      value: CGFloat(i),
                                      label: "12/23")
                self.data.append(chart)
            }
            self.chartView.reloadChart(data: self.data, isEnd: self.data.count > 50)
        })
    }
}


