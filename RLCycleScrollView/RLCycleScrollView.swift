//
//  RLCycleScrollView.swift
//  RLCycleScrollView
//
//  Created by runlin on 17/3/14.
//  Copyright © 2017年 gavin. All rights reserved.
//

import UIKit

class RLCycleScrollView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //=====block
    typealias DownloadItemBlock = (UIImageView , Int) ->()
    var callBackDownloaditem: DownloadItemBlock?
    
    //=====UI
    var scrollview:UIScrollView = UIScrollView()
    //=====
    var items: NSMutableArray = []


    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.buildView(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension RLCycleScrollView{
    
    public func buildView(frame: CGRect) -> Void {}
    
    public func reloadData() ->Void{
        
        self.scrollview.subviews.forEach{
            $0.removeFromSuperview()
        }
        
        if self.items.count == 0 {
            self.scrollview.contentSize = CGSize.zero
            return
        }
        
        
        self.scrollview.frame = CGRect(x:0,y:0,width:frame.size.width,height:frame.size.height)
        self.scrollview.contentSize = CGSize(width:frame.size.width*CGFloat(items.count) , height:frame.size.height)
        self.scrollview.backgroundColor = UIColor.blue
        self.scrollview.isPagingEnabled = true
        self.addSubview(self.scrollview)
        
        
        for i in 0..<self.items.count{
            let offset = frame.size.width * CGFloat(i)
            let imgview = UIImageView(frame:CGRect(x:offset,y:0,width:frame.size.width,height:frame.size.height))
            imgview.backgroundColor = UIColor.yellow
            self.scrollview.addSubview(imgview)
            
            let tap = UITapGestureRecognizer()
            imgview.addGestureRecognizer(tap)
            
            self.callBackDownloaditem?(imgview , i)
        }
    }
    
    public func setItems(itemsPar:NSMutableArray) ->Void{
        if self.items.count > 0{
            self.items.removeAllObjects()
        }
        
        self.items = itemsPar
        self.reloadData()
    }
    
    
    public func downloadItem(block:@escaping DownloadItemBlock)  {
        callBackDownloaditem = block
        self.reloadData()
    }
    
}
