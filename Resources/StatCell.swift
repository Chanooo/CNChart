//
//  StatCell.swift
//  CNChart
//
//  Created by CNOO on 2021/07/24.
//

import UIKit

class StatCell: UIView {
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var labelWidthConstraint: NSLayoutConstraint!
    
    
    // Vertical
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    // Horizontal
    var progressWidth: CGFloat = 10 {
        didSet { progress.bounds.size.height = progressWidth }
    }
    
    
    private var axis: UILayoutConstraintAxis!
    
    
    
    var value: Float = 1.0
    var maxValue: Float = 1.0
    
    func updateProgress(duration: TimeInterval, delay: TimeInterval = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            UIView.animate(withDuration: duration) {
                self.progress.setProgress(self.value/self.maxValue, animated: true)
            }
        })
    }
    
    func rotateView() {
        progress.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if self.axis == .horizontal {
//            let width = bounds.width
            let height = bounds.height
    //
            progress.bounds.size.width = height
            progress.bounds.size.height = progressWidth // width
    //        progress.center.x = bounds.midX
    //        progress.center.y = bounds.midY
        }
    }
    
    
    static func getStatCell(axis: UILayoutConstraintAxis) -> StatCell {
        let bundle = Bundle(for: self.classForCoder())
        let nib = UINib(nibName: "StatCell", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
        
        let cell = axis == .vertical
            ? nib.first as! StatCell
            : nib.last as! StatCell
        
        cell.axis = axis
        return cell
    }
}
