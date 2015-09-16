# MoreThanDrawerMenumDemo
## 说明
本来是要做一个微杂志的APP，现在又觉得没什么好玩的了。
**实现了的：**
* 类似“一刻”的抽屉式菜单
* 基于Alamofire的网络封装（只做了一个Post的封装，已测试过）
* 其他没什么

###设计如下图所示
![alt tag](https://github.com/gezhixin/MoreThanDrawerMenumDemo/blob/master/ScreenShort/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-09-16%2016.27.30.png)

抽屉式菜单的设计关键在于对UIViewController的chirldViewController特性的使用，以及SubView显示层级的使用，关键代码如下：
```swift
 var centerNavigationController : UINavigationController!
    {
        willSet(newCNVC){
            if self.centerNavigationController != nil
            {
                self.centerNavigationController.view.removeFromSuperview()
                self.centerNavigationController.removeFromParentViewController()
            }
        }
        didSet {
            if self.centerNavigationController != nil
            {
                if (self.centerNavigationController.view.superview == nil)
                {
                    self.addChildViewController(centerNavigationController)
                    self.view.insertSubview(centerNavigationController.view, atIndex:1)
                }
            }
        }
    }
```
在点击左边菜单选项时，将对应的UINavigationController对象赋值个rootViewController的centerNavigationController，上面的setter方法会将对应的VC和View添加到rootViewController中。

```swift
var c = self.centerNavigationController.view.frame
var duration   = NSTimeInterval((CenterViewOffset - c.origin.x) / CenterViewOffset * 0.45)
c.origin.x = CenterViewOffset
UIView.animateWithDuration(duration, delay:0, usingSpringWithDamping:0.9, 
                          initialSpringVelocity:1.0, 
                          options:UIViewAnimationOptions.AllowUserInteraction,
                          animations:{
                     self.centerNavigationController.view.frame = c ;
},completion:nil)
```
上面代码是打开左边菜单的代码，只需要改变centerNavigationController.view.frame.x。

**大概原理如此，其他如滑动手势、动画、View的缩放等等效果，你想怎么玩就怎么玩了。原理清楚了，其他的都只是细节而已!**


## APP截图

![alt tag](https://github.com/gezhixin/MoreThanDrawerMenumDemo/blob/master/ScreenShort/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-09-16%2013.37.13.png) －－－－－－－－－－－－－－ ![alt tag](https://github.com/gezhixin/MoreThanDrawerMenumDemo/blob/master/ScreenShort/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-09-16%2013.39.16.png)


![alt tag](https://github.com/gezhixin/MoreThanDrawerMenumDemo/blob/master/ScreenShort/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-09-16%2013.39.32.png) －－－－－－－－－－－－－－ ![alt tag](https://github.com/gezhixin/MoreThanDrawerMenumDemo/blob/master/ScreenShort/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-09-16%2013.40.12.png)

## Licence

MIT 
