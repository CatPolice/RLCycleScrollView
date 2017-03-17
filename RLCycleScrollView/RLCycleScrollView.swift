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
    typealias DidSelectItemBlock = (Int) ->()
    
    var callBackDownloaditem: DownloadItemBlock?
    var callBackDidSelectItem: DidSelectItemBlock?
    
    
    //=====UI
    var scrollview:UIScrollView = UIScrollView()
    let pageControl:UIPageControl = UIPageControl()
    //=====
    var items: NSMutableArray = []

    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.buildView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}



extension RLCycleScrollView :UIScrollViewDelegate{
    
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
        self.scrollview.isPagingEnabled = true
        self.scrollview.showsHorizontalScrollIndicator = false
        self.scrollview.showsVerticalScrollIndicator = false
        self.scrollview.delegate = self
        self.addSubview(self.scrollview)
        
        
        for i in 0..<self.items.count{
            let offset = frame.size.width * CGFloat(i)
            let imgview = UIImageView(frame:CGRect(x:offset,y:0,width:frame.size.width,height:frame.size.height))
            imgview.isUserInteractionEnabled = true
            self.scrollview.addSubview(imgview)
            
            let tap = UITapGestureRecognizerExtension()
            tap.index = i
            tap.addTarget(self, action: #selector(tapAction))
            imgview.addGestureRecognizer(tap)
            
            self.callBackDownloaditem?(imgview , i)
        }
        
        
        self.pageControl.frame = CGRect(x:frame.size.width - CGFloat(20*self.items.count),y:frame.size.height - 30,width:CGFloat(20*self.items.count),height:CGFloat(20))
        self.pageControl.numberOfPages = self.items.count
        self.pageControl.currentPage = 0
        self.addSubview(self.pageControl)
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.frame
        self.pageControl.currentPage = Int(offset.x / bounds.size.width)
        print(offset.x / bounds.size.width)
    }
    
    
    @objc private func tapAction(tap:UITapGestureRecognizerExtension) ->Void{
        callBackDidSelectItem?(tap.index)
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
    
    public func didSelectItem(block:@escaping DidSelectItemBlock) {
        callBackDidSelectItem = block
    }
}



class UITapGestureRecognizerExtension: UITapGestureRecognizer {
//    var tag:Int = 0
    var index:Int = 0
}

