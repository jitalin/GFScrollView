# GFScrollView
An infinite carousel framework is mainly done using iCarousel, features can set to animation using iCarousel carousel mode, and you can set the cycle time, pictures frame, carousel picture mode, click on the return of index, and can set the attributes pageControl; convenient style selection. Support local and network pictures ，2016-12-09.Update: the use of FXImageView to increase the reflection of the mirror reflection effect 主要利用 iCarousel 做的一个无限轮播框架，特色在于能够利用iCarousel的轮播模式来设定想要的动画效果，并可以自己设定循环时间、图片frame,图片模式、返回所点击的轮播图片的index，还有可以设定pageControl等各属性；方便快捷，样式选择多。支持本地和网络图片！！2016-12-09更新：利用FXImageView 增加镜面的反射折射效果 Demo:


调用方式：

GFScrollView* view     = [[GFScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
self.myView = view;
view.imageArray        = @[@"0.jpg",@"1.jpg",@"2.jpg"];
view.imageRect = CGRectMake(80, 50, CGRectGetWidth(view.bounds) - 160, CGRectGetHeight(view.bounds)-100);
[self.view addSubview: view];

[view selectedItemWithSelectedBlock:^(NSInteger index) {
    NSLog(@"%ld",(long)index);

}];
