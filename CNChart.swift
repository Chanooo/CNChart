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
    private let icon = "📊"
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        #if DEBUG
            print("[CNChart \(icon)], draw")
        #endif
//        self.alignment = .fill
//        self.distribution = .fillEqually
        
//        let size = CGSize(width: self.frame.size.width, height: 10)
//        self.frame = CGRect(origin: self.frame.origin, size: size)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        /*
        let bundle = Bundle(for: self.classForCoder)
        for _ in 0...3 {
            let cell = UINib(nibName: "StatCell", bundle: bundle).instantiate(withOwner: self, options: nil).first as! StatCell
            self.addArrangedSubview(cell)
        }
        let loadMoreButton = UINib(nibName: "LoadMoreButton", bundle: bundle).instantiate(withOwner: self, options: nil).first as! LoadMoreButton
        self.addArrangedSubview(loadMoreButton)
//        loadMoreCell.loadMoreStatBtn.addTarget(self, action: #selector(onLoadMoreStat(_:)), for: .touchUpInside)
        */
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        let sampleLabel = UILabel()
        sampleLabel.text = "CNChart"
        sampleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        sampleLabel.textAlignment = .center
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 255,
                                         green: 0.5,
                                         blue: 1,
                                         alpha: 1).cgColor
        self.addArrangedSubview(sampleLabel)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
            print("[CNChart \(icon)], init1")
        #endif
    }
    
    /// initialized on xib or storyboard
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        #if DEBUG
            print("[CNChart \(icon)], public init(coder aDecoder: NSCoder)")
        #endif
    }
    
    
    public convenience init(axis: UILayoutConstraintAxis = .vertical) {
        self.init(frame: CGRect.zero)
        self.axis = axis
        
        #if DEBUG
            print("[CNChart \(icon)], public convenience init")
        #endif
    }
    
    
    
    // MARK: - LOGIC
    open func setAxis(axis: UILayoutConstraintAxis) {
        self.axis = axis
    }
    
}
