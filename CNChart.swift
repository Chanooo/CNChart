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
                                                  alpha: 0.1)
            sampleLabel.layer.borderWidth = 1
            sampleLabel.layer.borderColor = UIColor(red: 1,
                                                    green: 1,
                                                    blue: 1,
                                                    alpha: 1).cgColor
            self.addArrangedSubview(sampleLabel)
        }
    }
    
    
    /// initialized on xib or storyboard
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        #if DEBUG
            log(string: "public init(coder aDecoder: NSCoder)")
        #endif
        
        let bundle = Bundle(for: self.classForCoder)
        
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        self.spacing = 6
        
        
//        for _ in 0...10 {
//            let stat = getStatCell()
//            self.addArrangedSubview(stat)
//        }
        
        button = UINib(nibName: "LoadMoreButton", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as! LoadMoreButton
        
        button.addTarget(self, action: #selector(onLoadMore), for: .touchUpInside)
        
        loading = UINib(nibName: "LoadingView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as! LoadingView
        
//        self.addArrangedSubview(button)
        self.addArrangedSubview(loading)
//        loading.isHidden = true
    }
    
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        #if DEBUG
            log(string: "draw")
        #endif
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
    
    
    
    @objc private func onLoadMore() {
        log(string: "onLoadMore!!")
        delegate?.onLoadMore()
        
        setButton(on: false)
        setLoading(on: true)
    }
    
    
    /// if isEnd,
    private var mData: [ChartData] = []
    open func reloadChart(data: [ChartData], isEnd: Bool) {
        
        var newIdx = 0
        data.forEach { chart in
            if !mData.contains(where: {$0.id == chart.id}) {
                // 이미 포함된 것 - setMax
                
            } else {
                // 새로 들어온 것
                mData.append(chart)
                let cell = self.getStatCell()
                cell.alpha = 0
                self.addArrangedSubview(cell)
                cell.transform = CGAffineTransform(translationX: 0, y: 10)
                let duration = 0.5
                UIView.animate(withDuration: duration,
                               delay: Double(newIdx)*duration)
                {
                    cell.transform = CGAffineTransform.identity
                    cell.alpha = 1
                }
                newIdx += 1
            }
        }
        
        setButton(on: !isEnd)
        setLoading(on: false)
    }
    // MARK: - LOGIC
    private func calculateMax() {
        var maxValue = 0
        if let mData.sorted(by: {$0.value < $1.value}).first?.value
        
    }
    
    // MARK: - UI
    private func getStatCell() -> StatCell {
        let bundle = Bundle(for: self.classForCoder)
        return UINib(nibName: "StatCell", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as! StatCell
    }
    
    private func setButton(on: Bool) {
        if button.superview != nil {
            button.removeFromSuperview()
        }
        
        if on {
            addArrangedSubview(button)
        }
    }
    
    private func setLoading(on: Bool) {
        if loading.superview != nil {
            loading.removeFromSuperview()
        }
        
        if on {
            addArrangedSubview(loading)
        }
    }
    
    
    
    
    // MARK: - LOGGING
    private var isDebugging = true
    
    /// if relase mode, it will automatically be set a non-debug mode
    public func setDebug(on: Bool) {
        isDebugging = on
    }
    
    private func log(string: String) {
        print("[CNChart\(icon)]: \(string)")
    }
    
    
    
}
