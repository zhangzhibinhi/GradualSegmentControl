//
//  ZBGradualSegmentControl.swift
//  GradualSegmentControl
//
//  Created by 张志彬 on 2018/1/29.
//  Copyright © 2018年 张志彬. All rights reserved.
//

import UIKit

typealias SegmentItemConstructBlock = (_ gradientSegmentItem: ZBSegmentGradientItem) -> Void
typealias SegmentItemSelectAction = (_ gradientSegmentItem: ZBSegmentGradientItem) -> Void

class ZBSegmentGradientItem: UIControl {
    public var title: String?
    public var defaultColors: [UIColor]?
    public var selectedColors: [UIColor]?
    public var defaultTitleColor: UIColor?
    public var selectedTitleColor: UIColor?
    public var titleFont: UIFont?
    public var itemSelectAction: SegmentItemSelectAction?
    
    override var isSelected: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }

    convenience init(UIConstructBlock itemConstructBlock: SegmentItemConstructBlock, segmentSelectAction: @escaping SegmentItemSelectAction) {
        self.init(frame: CGRect.zero)
        // ui construct block
        self.backgroundColor = UIColor.white
        itemConstructBlock(self)
        // action block
        self.itemSelectAction = segmentSelectAction
        self.addTarget(self, action: #selector(itemSelectAction(_:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc private func itemSelectAction(_ item: ZBSegmentGradientItem) {
        if !item.isSelected {
            item.isSelected = true
            item.itemSelectAction!(item)
        }
    }
    
    private var titleLabel: UILabel
    private var gradientLayer: CAGradientLayer
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel.init(frame: CGRect.zero)
        self.gradientLayer = CAGradientLayer()
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.titleLabel = UILabel.init(frame: CGRect.zero)
        self.gradientLayer = CAGradientLayer()
        super.init(coder: aDecoder)
        
        self.addSubview(self.titleLabel)
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    override func draw(_ rect: CGRect) {
        self.gradientLayer.frame = self.bounds
        
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        var colors = [CGColor]();
        for color in (self.isSelected ? self.selectedColors! : self.defaultColors!){
            colors.append(color.cgColor)
        }
        self.gradientLayer.colors = colors
        self.gradientLayer.locations = [0.0, 0.75, 1.0]
        
        self.titleLabel.text = self.title
        self.titleLabel.font = self.titleFont
        self.titleLabel.textColor = self.isSelected ? self.selectedTitleColor! : self.defaultTitleColor!
        
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.sizeToFit()
        self.titleLabel.center.x = self.frame.size.width/2
        self.titleLabel.center.y = self.frame.size.height/2
    }
}

class ZBSegmentControl: UIView {
    public var selectedIndex: Int {
        didSet {
            self.reloadStates()
        }
    }
    
    // items
    public var segmentItems: [ZBSegmentGradientItem] {
        didSet {
            self.layoutIfNeeded()
            self.selectedIndex = 0
        }
    }
    
    override init(frame: CGRect) {
        self.selectedIndex = 0
        self.segmentItems = [ZBSegmentGradientItem]()
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.selectedIndex = 0
        self.segmentItems = [ZBSegmentGradientItem]()
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        let count = self.segmentItems.count
        let width = (self.frame.size.width) / CGFloat(count)
        let height = self.frame.size.height
        
        var index = 0
        for segmentItem in self.segmentItems {
            segmentItem.frame.size.width = width
            segmentItem.frame.size.height = height
            segmentItem.frame.origin.x = width * CGFloat(index)
            segmentItem.tag = index
            segmentItem.addTarget(self, action: #selector(itemSelectAction(item:)), for: UIControlEvents.touchUpInside)
            self.addSubview(segmentItem)
            
            index += 1
        }
        
        super.layoutSubviews()
    }
    
    @objc private func itemSelectAction(item: ZBSegmentGradientItem) {
        self.selectedIndex = item.tag
    }
    
    private func reloadStates() {
        for segmentItem in self.segmentItems {
            segmentItem.isSelected = (segmentItem.tag == self.selectedIndex)
        }
    }
}

