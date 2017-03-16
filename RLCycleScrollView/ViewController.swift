//
//  ViewController.swift
//  RLCycleScrollView
//
//  Created by runlin on 17/3/14.
//  Copyright © 2017年 gavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let width = UIScreen.main.bounds.size.width
        
        let view_ = RLCycleScrollView.init(frame: CGRect(x:0,y:100,width:width,height:width*(9/16)))
        view_.setItems(itemsPar: ["","",""])
        view_.downloadItem { (imgview, index) in
            print("======== download img ========")
            print(imgview)
            print(index)
        }
        self.view.addSubview(view_)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

