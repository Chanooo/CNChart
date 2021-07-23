//
//  CNChart.swift
//  CNChart
//
//  Created by CNOO on 2021/07/23.
//

import Foundation
import UIKit

@IBDesignable
open class CNChart: UIStackView {
    
    enum Orientation {
        case horizontal
        case vertical
    }
    
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
//        self.alignment = .fill
        self.distribution = .fillEqually
        
        var v = UIView()
        v.backgroundColor = .blue
//        v.frame = self.bounds
        self.addArrangedSubview(v)
        
        var v1 = UIView()
        v1.backgroundColor = .red
//        v1.frame = self.bounds
        self.addArrangedSubview(v1)
    }
    
    public convenience init(axis: UILayoutConstraintAxis = .vertical) {
        self.init(frame: CGRect.zero)
        self.axis = axis
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView = UIView()
//        titleLabel = UILabel()
//        lineView = UIView()
//        confirmButton = UIButton(type: .custom)
//
//        self.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        lineView.translatesAutoresizingMaskIntoConstraints = false
//        confirmButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LOGIC
    open func setAxis(axis: UILayoutConstraintAxis) {
        self.axis = axis
    }
    
}
