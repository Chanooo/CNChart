//
//  ChartData.swift
//  CNChart
//
//  Created by CNOO on 2021/07/26.
//

public struct ChartData {
    let id: String
    let value: Float
    let label: String
    let color: UIColor?
    
    public init(id: String,
                value: Float,
                label: String,
                color: UIColor? = nil) {
        self.id = id
        self.value = value
        self.label = label
        self.color = color
    }
    
}
