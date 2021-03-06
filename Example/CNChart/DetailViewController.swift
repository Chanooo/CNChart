//
//  VerticalViewController.swift
//  CNChart_Example
//
//  Created by CNOO on 2021/07/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import CNChart

class DetailViewController:
    UIViewController,
    CNChartDelegate
{
    @IBOutlet weak var chartView: CNChart!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var cellHeightStepper: UIStepper!
    @IBOutlet var valueLabels: [UILabel]!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        controlView.layer.cornerRadius = 16
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellHeightStepper.value = 10
        chartView.delegate = self
        onLoadMore()
        
        let chart = CNChart(axis: .horizontal)
        self.view.addSubview(chart)
    }
    
    @IBAction func onRefresh(_ sender: UIBarButtonItem) {
        chartView.setClear()
        count = 1
        onLoadMore()
    }
    
    // MARK: - Control properties
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        switch sender.tag {
        case 0:  chartView.cellThickness = CGFloat(sender.value)
        case 1:  chartView.chartDuration = sender.value
        case 2:  chartView.showDuration = sender.value
        default: chartView.spacing = CGFloat(sender.value)
        }
        valueLabels[sender.tag].text = String(format: "%.2f", sender.value)
    }
    
    // MARK: - Text Alignment
    @IBAction func textAlignmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:  chartView.labelAlignment = .left
        case 1:  chartView.labelAlignment = .center
        default: chartView.labelAlignment = .right
        }
    }
    
    
    
    // MARK: - CNChartDelegate
    private var colors: [UIColor?] = [.red, .green, .blue, .brown, .cyan, .orange, .yellow, .gray]
    private var count = 1
    func onLoadMore() {
        var data: [ChartData] = []
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.count += 1
            for i in 0...10 {
                let value = self.count == 1 ?
                    Float.random(in: 0..<80) :
                    Float.random(in: 0..<100)
                
                let chart = ChartData(value: value,
                                      label: self.chartView.axis == .vertical
                                        ? "Data_\(i*i*self.count*self.count)"
                                        : "\(i*i*self.count*self.count)",
                                      color: self.colors.randomElement() ?? nil)
                data.append(chart)
            }
            self.chartView.addData(data: data, isEnd: self.count > 5)
        })
    }
    
}


