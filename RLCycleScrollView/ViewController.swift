//
//  ViewController.swift
//  RLCycleScrollView
//
//  Created by runlin on 17/3/14.
//  Copyright © 2017年 gavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
@IBOutlet weak var cycleView: RLCycleScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imgList:NSMutableArray = ["0.jpg","1.jpg","2.jpg"]
        let width = UIScreen.main.bounds.size.width
        
        
        let view_ = RLCycleScrollView.init(frame: CGRect(x:0,y:200,width:width,height:width*(9/16)))
        view_.setItems(itemsPar: imgList)
        view_.downloadItem { (imgview, index) in
            print("======== download img ========")
            print(imgview)
            print(index)
            
            imgview.image = UIImage.init(named: imgList[index] as! String)
            
            //网络图片也在此处下载显示
        }
        
        view_.didSelectItem { (index) in
            print(index)
        }
        
        self.view.addSubview(view_)
        
        
        
        self.cycleView.setItems(itemsPar: imgList)
        self.cycleView.downloadItem { (imgView, index) in
            print("======== download img ========")
            print(imgView)
            print(index)
            
            imgView.image = UIImage.init(named: imgList[index] as! String)
            
            //网络图片也在此处下载显示
        }
        
        
        self.cycleView.didSelectItem { (index) in
            print(index)
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

