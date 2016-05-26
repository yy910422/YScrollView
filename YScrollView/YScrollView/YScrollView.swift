//
//  YScrollerView.swift
//  test
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 bg杨. All rights reserved.
//

import UIKit
import Foundation

class YScrollView: UIView,UIScrollViewDelegate {
    
    weak var delegate: YScrollViewDelegate?
    //页码控制器的位置
    enum PageControllerDirection{
        case Center
        case Left
        case Right
    }
    private var subFrame: CGRect!
    //滚动视图
    private var scrollView: UIScrollView!
    private var currentPage: Int = 0
    private var pageController: UIPageControl!
    //是否显示页码控制器
    var showPageController: Bool?{
        didSet{
            if showPageController! {
                self.setPageController(pageDirection)
                //设置PageController
            }else{
                //移除PageController
                for controller in self.subviews{
                    if controller == pageController {
                        controller.removeFromSuperview()
                    }
                }
            }
        }
    }
    //设置页码控制器的位置(默认是居中的)
    var pageDirection: PageControllerDirection = .Center{
        didSet{
            changePageControllerDirection(pageDirection)
        }
    }
    //设置图片，添加图片
    var pageImagesURL: [NSURL]!{
        didSet{
            print("执行添加图片了")
            self.setNeedsLayout()
            self.layoutIfNeeded()
            addImage(pageImagesURL)
            redrawScrollView()
            redrawScrollViewContentSize()
            redrawImageViews()
            //瞬间跳转第1页
            //当前页
            let sWidth = self.frame.size.width
            scrollView.setContentOffset(CGPoint(x: sWidth, y: 0), animated: false)
        }
    }
    //滚动视图的页数
    var pageCount: Int = 0
    
    //通过代码初始化
    override init(frame: CGRect) {
        super.init(frame:frame)
        pageController = UIPageControl()
        pageDirection = .Center
        self.initScrollView()
        subFrame = self.frame
    }
    //通过sb初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pageController = UIPageControl()
        pageDirection = .Center
        self.initScrollView()
        subFrame = self.frame
    }
    
    //自定义初始化构造器
    convenience init(frame: CGRect,pageCount:Int,imageURLs:[NSURL],pageControllerDirection:PageControllerDirection) {
        self.init(frame:frame)
        pageDirection = pageControllerDirection
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //计算页码
        let scrollerViewW = self.frame.size.width
        //获取偏移值
        let offset = scrollView.contentOffset.x - scrollerViewW
        //页码
        let pageIndex = Int((offset + scrollerViewW / 2.0) / scrollerViewW)
        
        pageController.currentPage = pageIndex
    }
    
    //******************************************
    //私有化方法
    //初始化scrollView
    private func initScrollView(){
        print("initScrollView加载")
        //ios7 以后的支持
        self.backgroundColor = UIColor.lightGrayColor()
        scrollView = UIScrollView()
         scrollView.backgroundColor = UIColor.redColor()
        //设置分页
        scrollView.pagingEnabled = true
        //设置代理
        scrollView.delegate = self
        //隐藏指示条
        scrollView.showsHorizontalScrollIndicator = false
        //添加个点击事件
        let gesture = UITapGestureRecognizer(target: self, action: #selector(YScrollView.clickScrollView(_:)))
        gesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(gesture)
     
        pageController = UIPageControl()
        self.addSubview(scrollView)
        nextImage()
       
    }
    //scrollview添加图片
    private func addImage(images:[NSURL]){
        pageCount = images.count
        for i in 0 ..< pageCount + 2
        {
            let imgView = UIImageView()
            imgView.userInteractionEnabled = true
            
            //设置填充模式
            imgView.contentMode = UIViewContentMode.ScaleToFill
            if i == 0
            {
                //第0张 显示广告最后一张
               // imgX = 0
                
                //缓存处理img，如果根据网络地址请求不到，则添加默认图片
                imgView.sd_setImageWithURL(pageImagesURL.last, placeholderImage: UIImage(named: "default.jpg"))
            }
            else if i == pageCount + 1
            {
                //第n+1张,显示广告第一张
               // imgX = CGFloat(pageCount + 1) * self.frame.size.width
                imgView.sd_setImageWithURL(pageImagesURL.first, placeholderImage: UIImage(named: "default.jpg"))
            }
            else
            {
               imgView.sd_setImageWithURL(pageImagesURL[i-1], placeholderImage: UIImage(named: "default.jpg"))
            }
            
            //imgView.frame = CGRect(x: imgX, y: imgY, width: imgW, height: imgH)
            scrollView.addSubview(imgView)
        }
    }
    
    func clickScrollView(sender:UIScrollView){
        self.delegate?.yScrollView?(sender, didClickAtIndex: self.currentPage)
    }
    /**
     初始化页码控制器
     - parameter direction: 页码控制器所在方向
     */
    private  func setPageController(direction:PageControllerDirection){
        print("setPageController加载")
      
        //如果用户设置不显示PageController 则不添加pageController
        guard showPageController! else{
            return
        }
        let number: Int = pageCount == 0 ? pageImagesURL.count:pageCount
        changePageControllerDirection(direction)
        //禁止点击
        pageController.hidesForSinglePage = true
        pageController.userInteractionEnabled = false
        pageController.numberOfPages = number
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.grayColor()
        pageController.backgroundColor = UIColor.clearColor()
        self.addSubview(self.pageController)
    }
    /**
    *  更改PageController的位置
    */
    private func changePageControllerDirection(direction:PageControllerDirection){
        let number: Int = pageCount == 0 ? pageImagesURL.count:pageCount
        //页码控制器的宽
        let pageControllerWidth: CGFloat = CGFloat(number * 10)
        //页码控制器的高
        let pageControllerHeight:CGFloat = 10
        //页码控制器的y坐标
        let pageControllerY = scrollView.frame.height - 20
        var frame:CGRect!
        switch direction {
        case .Center:
            let x = (scrollView.frame.width - pageControllerWidth)/2
            frame = CGRectMake(x, pageControllerY, pageControllerWidth, pageControllerHeight)
        case .Left:
            let x: CGFloat = 30
            frame = CGRectMake(x, pageControllerY, pageControllerWidth, pageControllerHeight)
        case .Right:
            let x: CGFloat = scrollView.frame.width - pageControllerWidth - 10
            frame = CGRectMake(x, pageControllerY, pageControllerWidth, pageControllerHeight)
        }
        pageController.frame = frame
    }
    //私有化方法结束
    
    //*******************************************
    //设置轮播相关,timeDelay必须>0 否则不生效
    var timeDelay: Double?{
        didSet{
            if timeDelay > 0 {
                autoDisplay = true
                addTimer()
            }
           
        }
    }
    //是否开启自动轮播
    private var autoDisplay = false
    //定时器
    private var timer: NSTimer?
    //开启定时器
    private  func addTimer(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(timeDelay!, target: self, selector: #selector(YScrollView.nextImage), userInfo: nil, repeats: true)
        //        let currentRunLoop = NSRunLoop()
        //        currentRunLoop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    //关闭定时器
    private func removeTimer(){
        timer!.invalidate()
    }
    
    //开始拖动时结束定时器
     func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if autoDisplay {
            removeTimer()
        }
        
    }
    //结束拖动时重新开启定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoDisplay {
             addTimer()
        }
       
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        carousel()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        carousel()
    }
    
    func carousel()
    {
        guard pageCount > 0 else {
            return
        }
        //获取偏移值
        let offset = scrollView.contentOffset.x;
        //当前页
        let sWidth = self.frame.size.width
        let page = Int((offset + sWidth/2) / sWidth);
        //如果是N+1页
        if page == pageCount + 1
        {
            //瞬间跳转第1页
            scrollView.setContentOffset(CGPoint(x: sWidth, y: 0), animated: false)
            currentPage = 1
        }
            //如果是第0页
        else if page == 0
        {
            //瞬间跳转最后一页
            scrollView.setContentOffset(CGPoint(x: CGFloat(pageCount) * sWidth, y: 0), animated: false)
            currentPage = pageCount
        }else{
            currentPage = page
            
        }
    }
    
    //自动换图
    @objc private func nextImage(){
        var page = self.currentPage
        page += 1
        //算当前页面图片坐标
        let x = CGFloat(page) * self.frame.size.width
      
        scrollView.setContentOffset(CGPoint(x: x,y: 0), animated: true)
        self.pageController.currentPage = page
        self.currentPage = page
    }
    
    //更新scrollView的frame
    func redrawScrollView(){
        let scrollViewFrame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        scrollView.frame = scrollViewFrame
    }
    //更新scrollView中的imageView的frame
    func redrawImageViews(){
        for(index,value) in scrollView.subviews.enumerate(){
            let imgX = self.frame.width * CGFloat(
                index)
            let frame = CGRectMake(imgX, 0, self.frame.width, self.frame.height)
            value.frame = frame
        }
    }
    //更新scrollView的滚动范围
    func redrawScrollViewContentSize(){
        //图片的宽
        let imgW = self.scrollView.bounds.width
        //设置滚动范围
        let contentW = imgW * (CGFloat(pageCount) + 2)
        //不允许在垂直方向进行滚动
        scrollView.contentSize = CGSizeMake(contentW, 0)
    }
}


