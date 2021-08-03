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
    
    private var button: LoadMoreButton!
    private var loading: LoadingView!
    private var mData: [ChartData] = []
    
    open var delegate: CNChartDelegate?
    
    open var font = UIFont.systemFont(ofSize: 9, weight: .medium)
    open var chartDuration: TimeInterval = 1.5
    open var showDuration: TimeInterval = 0.05
    open var cellHeight: CGFloat = 10 {
        didSet { updateChartUI() }
    }
    open var labelAlignment: NSTextAlignment = .center {
        didSet { updateChartUI() }
    }
    open override var spacing: CGFloat {
        didSet { updateChartUI() }
    }
    
    /// Do not change this value "PROGRAMMICALLY"
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
        
        button = UINib(nibName: "LoadMoreButton", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as? LoadMoreButton
        button.addTarget(self, action: #selector(onLoadMore), for: .touchUpInside)
        
        loading = UINib(nibName: "LoadingView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as? LoadingView
        
        self.addArrangedSubview(loading)
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
    
    
    
    // MARK: - FUNCTION
    @objc private func onLoadMore() {
        delegate?.onLoadMore()
        
        setButton(on: false)
        setLoading(on: true)
    }
    
    
    /// data : data will be added. isEnd: if true, loadMore Button will be presented
    open func addData(data: [ChartData], isEnd: Bool) {
        
        // getMaxValue
        let maxValue = max(
            getMaxValue(data: mData),
            getMaxValue(data: data)
        )
        
        // getMaxLabelWidth
        let maxLabelWidth = max(
            getMaxLabelWidth(data: mData),
            getMaxLabelWidth(data: data)
        )
        
        // Update added progress
        self.arrangedSubviews.forEach {
            if let cell = $0 as? StatCell {
                cell.labelWidthConstraint.constant = maxLabelWidth
                cell.maxValue = maxValue
                cell.updateProgress(duration: chartDuration)
            }
        }
        
        
        // add new data
        var newIdx = 0
        data.forEach { chart in
            mData.append(chart)
            
            let cell = self.getStatCell()
            
            // Label Width
            cell.labelWidthConstraint.constant = maxLabelWidth
            cell.label.textAlignment = labelAlignment
            cell.label.text = chart.label
        
            // Cell Height
            cell.heightConstraint.constant = self.cellHeight
            cell.frame.size = CGSize(width: cell.frame.width, height: self.cellHeight)
        
            // Stat Color
            if let color = chart.color {
                cell.progress.progressTintColor = color
            }
        
            // Animate Progress
            cell.value = chart.value
            cell.maxValue = maxValue
            cell.updateProgress(duration: chartDuration, delay: Double(newIdx)*showDuration)
        
            // Animate Appear
            cell.alpha = 0
            self.addArrangedSubview(cell)
            
            cell.transform = CGAffineTransform(rotationAngle: 90)
            cell.transform = CGAffineTransform(translationX: 0, y: 5)
            UIView.animate(withDuration: showDuration,
                           delay: Double(newIdx)*showDuration)
            {
                cell.transform = CGAffineTransform.identity
                cell.alpha = 1
            }
            newIdx += 1
        }
        
        
        setButton(on: !isEnd)
        setLoading(on: false)
    }
    
    open func setClear() {
        mData.removeAll()
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        setButton(on: false)
        setLoading(on: true)
    }
    
    // MARK: - LOGIC
    private func getMaxValue(data: [ChartData]) -> Float {
        if let maxValue = data.sorted(by: {$0.value > $1.value}).first?.value {
            return maxValue
        } else {
            return 0
        }
    }
    
    private func getMaxLabelWidth(data: [ChartData]) -> CGFloat {
        if let maxWidthLabel = data.sorted(by: {
                                            getTextSize(text: $0.label).width >
                                            getTextSize(text: $1.label).width}
        ).first?.label {
            return getTextSize(text: maxWidthLabel).width
        } else {
            return 20
        }
    }
    
    private func getTextSize(text: String) -> CGSize {
        return text.size(withAttributes: [NSAttributedString.Key.font : self.font])
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
    
    
    // MARK: - Open Function
    /// Setting Loading label text
    public func setLoadingText(text: String) {
        loading.loadingLabel.text = text
    }
    
    /// Setting Loading label text color
    public func setLoadingTextColor(color: UIColor){
        loading.loadingLabel.textColor = color
    }
    
    /// Setting Loading indicator tint color
    public func setIndicatorTintColor(color: UIColor) {
        loading.indicator.tintColor = color
    }
    
    /// Setting LoadMore Button Title text
    public func setButtonTitle(title: String, state: UIControlState = .normal) {
        button.setTitle(title, for: state)
    }
    
    /// Setting LoadMore Button Icon
    public func setButtonIcon(image: UIImage, state: UIControlState = .normal) {
        button.setImage(image, for: state)
    }
    
    /// when the properties changed, this will be automatically called.
    public func updateChartUI() {
        arrangedSubviews.forEach {
            if let cell = $0 as? StatCell {
                
                // Label Width
                cell.label.textAlignment = labelAlignment
            
                // Cell Height
                cell.heightConstraint.constant = self.cellHeight
                cell.frame.size = CGSize(width: cell.frame.width, height: self.cellHeight)
            }
        }
    }
    
    
}
