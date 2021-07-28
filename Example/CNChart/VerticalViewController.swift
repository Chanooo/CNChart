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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        chartView.addData(data: [], isEnd: false)
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        chartView.setClear()
        onLoadMore()
    }
    
    
    // MARK: - CNChartDelegate
    private var count = 1
    func onLoadMore() {
        var data: [ChartData] = []
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.count += 1
            for i in 0...10 {
                let chart = ChartData(id: "\(i)_\(self.count)",
                                      value: Float(i*11*self.count + data.count*10),
                                      label: "12/23")
                data.append(chart)
            }
            self.chartView.addData(data: data, isEnd: data.count > 50)
        })
    }
}


