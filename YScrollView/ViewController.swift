//
//  ViewController.swift
//  YScrollView
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 bg杨. All rights reserved.
// 这个页面是Demo页面

import UIKit

class ViewController: UIViewController,YScrollViewDelegate {

    @IBOutlet weak var yScrollView: YScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
                /// 使用纯代码创建的View
        let scrollView = YScrollView(frame: CGRectMake(0, 200, self.view.frame.width, 150))
        scrollView.delegate = self
        scrollView.pageImagesURL = [NSURL(string: "http://pic47.nipic.com/20140909/2531170_213531089000_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!]
        scrollView.showPageController = true
        scrollView.timeDelay = 2.5
        scrollView.pageDirection = YScrollView.PageControllerDirection.Right
        self.view.addSubview(scrollView)
        
        /**
         通过SB创建的View
         
         - parameter string: <#string description#>
         */
        yScrollView.delegate = self
        yScrollView.pageImagesURL = [NSURL(string: "http://pic47.nipic.com/20140909/2531170_213531089000_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!]
        yScrollView.showPageController = true
        yScrollView.timeDelay = 2.5
        yScrollView.pageDirection = YScrollView.PageControllerDirection.Right
        //self.view.addSubview(scrollView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func yScrollView(clickView: UIScrollView, didClickAtIndex index: Int) {
        print(index)
    }


}

