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
    
    private var button: UIButton!
    private var loading: UIView!
    open var delegate: CNChartDelegate?
    
    open override var axis : UILayoutConstraintAxis {
        get {
            return super.axis
        }
        set {
            super.axis = newValue
            #if DEBUG
                log(string: "axis")
            #endif
            
            self.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
            
            self.constraints.forEach {
                self.removeConstraint($0)
            }
            
            let sampleLabel = UILabel()
            switch newValue {
            case .horizontal:
                sampleLabel.text = "CNChart\n.        (Horizonal)       .\n"
            case .vertical:
                sampleLabel.text = "\n\n\n\nCNChart\n(Vertical)\n\n\n\n"
            }
            sampleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            sampleLabel.textAlignment = .center
            sampleLabel.numberOfLines = 0
            sampleLabel.backgroundColor = UIColor(red: 0.1,
                                                  green: 0.1,
                                                  blue: 0.5,
                                                  alpha: 0.2)
            sampleLabel.layer.borderWidth = 1
            sampleLabel.layer.borderColor = UIColor(red: 1,
                                                    green: 1,
                                                    blue: 1,
                                                    alpha: 1).cgColor
            self.addArrangedSubview(sampleLabel)
        }
    }
    
    
    
    
    
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        #if DEBUG
            log(string: "draw")
        #endif
    }
    
    
    /// initialized on xib or storyboard
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        #if DEBUG
            log(string: "public init(coder aDecoder: NSCoder)")
        #endif
        
        self.spacing = 6
        
        let bundle = Bundle(for: self.classForCoder)
        
        for _ in 0...10 {
            let stat = UINib(nibName: "StatCell", bundle: bundle)
                .instantiate(withOwner: nil, options: nil)
                .first as! StatCell
            
            self.addArrangedSubview(stat)
        }
        
        
        button = UINib(nibName: "LoadMoreButton", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as! LoadMoreButton
        
        button.addTarget(self, action: #selector(onLoadMore), for: .touchUpInside)
        
        loading = UINib(nibName: "LoadingView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as! LoadingView
        
        self.addArrangedSubview(button)
        self.addArrangedSubview(loading)
        
        
    }
    
    @objc private func onLoadMore() {
        log(string: "onLoadMore!!")
        delegate?.onLoadMore()
    }
    
    
    /// if isEnd,
    open func reloadChart(data: [ChartData], isEnd: Bool) {
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
            log(string: "init1")
        #endif
    }
    
    public convenience init(axis: UILayoutConstraintAxis = .vertical) {
        self.init(frame: CGRect.zero)
        self.axis = axis
        
        #if DEBUG
            log(string: "public convenience init")
        #endif
    }
    
    
    private func log(string: String) {
        print("[CNChart\(icon)]: \(string)")
    }
    
    
    // MARK: - LOGIC
    
}
