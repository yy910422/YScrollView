### YScrollView是一个使用起来非常简单的轮播图控件，支持StoryBoard和纯代码两种实现方式，话不多少我们直接上代码吧！！！
***

#### 使用纯代码创建的View
```swift
	let scrollView = YScrollView(frame: CGRectMake(0, 200, self.view.frame.width, 150))
        scrollView.delegate = self
        scrollView.pageImagesURL = [NSURL(string: "http://pic47.nipic.com/20140909/2531170_213531089000_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!]
        scrollView.showPageController = true
        scrollView.timeDelay = 2.5
        scrollView.pageDirection = YScrollView.PageControllerDirection.Right
        self.view.addSubview(scrollView)
```
        
***
#### 使用StoryBoard创建

首先在StoryBoard里面拖一个View 然后让这个View 继承YScrollView类，然后使用下面这段代码就可以了
```swift
	yScrollView.delegate = self
        yScrollView.pageImagesURL = [NSURL(string: "http://pic47.nipic.com/20140909/2531170_213531089000_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!,NSURL(string: "http://pic.nipic.com/2007-11-09/200711912453162_2.jpg")!]
        yScrollView.showPageController = true
        yScrollView.timeDelay = 2.5
        yScrollView.pageDirection = YScrollView.PageControllerDirection.Right
```
##### 上面几行代码的意思是：
######.delegate：
设置轮播图控件的代理，需要ViewController实现YScrollViewDelegate协议，这个协议只有一个方法：
func yScrollView(clickView:UIScrollView,didClickAtIndex index:Int)
什么意思我相信大家都懂的！！
####### .pageImagesURL:
设置一个NSURL的数组，这里默认image都是网络图片，各位用着不爽的可以自己改下源代码
###### .showPageController：
是否显示页码控制器，默认是false
###### .timeDelay：
设置自动轮播的时间，如果不设置则不自动轮播
###### .pageDirection：
页码控制器位于轮播图的位置，有左中右三种选项。

####最后，该说一下如何使用了，下载这份源码，将lib文件夹和YScrollView文件夹放到你的项目里面，就可以使用上面的代码了，项目里有demo，大家自己去尽情改动吧！！！

######最后，欢迎大家跟我交流swift学习，qq：249557189，非诚勿扰