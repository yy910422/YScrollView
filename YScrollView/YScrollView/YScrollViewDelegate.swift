//
//  YScrollViewDelegate.swift
//  test
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 yygs. All rights reserved.
//  这里放的是所有的协议文件

import Foundation

@objc protocol YScrollViewDelegate: NSObjectProtocol{
    optional func yScrollView(clickView:UIScrollView,didClickAtIndex index:Int)
}