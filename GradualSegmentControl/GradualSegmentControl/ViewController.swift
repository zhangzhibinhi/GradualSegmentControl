//
//  ViewController.swift
//  GradualSegmentControl
//
//  Created by 张志彬 on 2018/1/29.
//  Copyright © 2018年 张志彬. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentControl = ZBSegmentControl(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.size.width - 40, height: 50))
        segmentControl.layer.masksToBounds = true
        segmentControl.layer.cornerRadius = 8
        segmentControl.layer.borderColor = UIColor.lightGray.cgColor
        segmentControl.layer.borderWidth = 0.5
        
        weak var weakSelf = self
        segmentControl.segmentItems = [
            ZBSegmentGradientItem(UIConstructBlock: { (item) in
                item.tag = 0
                item.title = "item \(item.tag)"
                item.titleFont = UIFont.systemFont(ofSize: 14)
                item.defaultTitleColor = UIColor.gray
                item.selectedTitleColor = UIColor.white
                item.defaultColors = [UIColor.lightGray, UIColor.white]
                item.selectedColors = [UIColor.red, UIColor.purple]
            }, segmentSelectAction: { (item) in
                let alert = UIAlertController(title: "SegmentItemSelect", message: "\(item.tag)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (action) in
                    
                }))
                weakSelf?.present(alert, animated: true, completion: {
                    
                })
            })
            , ZBSegmentGradientItem(UIConstructBlock: { (item) in
                item.tag = 1
                item.title = "item \(item.tag)"
                item.titleFont = UIFont.systemFont(ofSize: 14)
                item.defaultTitleColor = UIColor.gray
                item.selectedTitleColor = UIColor.white
                item.defaultColors = [UIColor.lightGray, UIColor.white]
                item.selectedColors = [UIColor.blue, UIColor.purple]
            }, segmentSelectAction: { (item) in
                let alert = UIAlertController(title: "SegmentItemSelect", message: "\(item.tag)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (action) in
                    
                }))
                weakSelf?.present(alert, animated: true, completion: {
                    
                })
            })]
        self.view.addSubview(segmentControl)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

