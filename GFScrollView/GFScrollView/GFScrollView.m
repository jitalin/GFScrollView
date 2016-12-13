//
//  GFScrollView.m
//  GFScrollView
//
//  Created by 高飞 on 16/12/6.
//  Copyright © 2016年 高飞. All rights reserved.
//

#import "GFScrollView.h"

@interface GFScrollView ()<iCarouselDelegate,iCarouselDataSource>
@end
@implementation GFScrollView
- (instancetype)init{
    self                                       = [super init];
    if (self) {
        [self setUpUI];
    }return self;

}
//xib
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self                                       = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpUI];
    }return self;

}
//has no xib
- (instancetype)initWithFrame:(CGRect)frame{
    self                                       = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];

    }return self;
}
- (void)setUpUI{
    self.timingSeconds                         = 5;
    self.imageRect                             = CGRectMake(0, 0, CGRectGetWidth(self.carouselView.bounds), CGRectGetHeight(self.carouselView.bounds));
    self.pageControl.hidden                    = NO;
    self.carouselView.hidden                   = NO;

}
#pragma mark--------iCarouselDelegate,iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{

    return _imageArray.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
    FXImageView *imageView                     = [[FXImageView alloc] initWithFrame:self.imageRect];
    imageView.contentMode                      = self.imageViewType;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;

    NSString *str                              = self.imageArray[index];

        if ([str hasPrefix:@"http"]) {

            [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"load.jpg"]];

        }else{

    imageView.image                            = [UIImage imageNamed:str];
        }


    view                                       = imageView;

    }


    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{

    self.selectedBlock(index);

}
#pragma mark----------Add Timer
-(void)addTimerWithSecond:(CGFloat)second
{

   NSTimer *timer                                 = [NSTimer scheduledTimerWithTimeInterval:second
                                                                        target:self
                                                                      selector:@selector(nextImage)
                                                                      userInfo:nil
                                                                       repeats:YES];
    self.timer = timer;
        //添加到runloop中
        [[NSRunLoop mainRunLoop]addTimer:timer
                                 forMode:NSRunLoopCommonModes];


}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%@",self.timer);
}


- (void)nextImage
{
    NSInteger index                            = self.carouselView.currentItemIndex + 1;
    if (index == self.imageArray.count ) {
    index                                      = 0;
    }

    [self.carouselView scrollToItemAtIndex:index animated:YES];
}

- (void)carouselDidScroll:(iCarousel *)carousel;
{
    self.pageControl.currentPage               = carousel.currentItemIndex;
    
    
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [self removeTimer];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel
                willDecelerate:(BOOL)decelerate{
    //    开启定时器
    [self addTimerWithSecond:self.timingSeconds];
    


}
//设置环绕
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;

}
#pragma mark--------bring back seletedItem infomation(数据回调)
- (void)selectedItemWithSelectedBlock:(SelectedBlock)selectedBlock{
    self.selectedBlock                         = selectedBlock;

}

#pragma mark-----------get method
- (iCarousel *)carouselView{
    if (!_carouselView) {
    _carouselView                              = [[iCarousel alloc] initWithFrame:self.bounds];

    _carouselView.delegate                     = self;
    _carouselView.dataSource                   = self;
    _carouselView.type                         = iCarouselTypeRotary;
    _carouselView.scrollSpeed                  = 6;
    _carouselView.pagingEnabled                = YES;
    _carouselView.backgroundColor              = [UIColor colorWithRed:0.367 green:0.353 blue:0.365 alpha:1.000];
    [self addSubview:_carouselView];


    }return _carouselView;

}
- (SMPageControl *)pageControl{
    if (!_pageControl) {
    _pageControl                               = [[SMPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 40, CGRectGetWidth(self.bounds), 40)];
    _pageControl.pageIndicatorTintColor        = [UIColor blackColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
         [self.carouselView addSubview:_pageControl];


    }return _pageControl;

}
#pragma mark-----set method
- (void)setImageArray:(NSArray *)imageArray{
    _imageArray                                = imageArray;
    self.pageControl.numberOfPages             = imageArray.count;
    [self.carouselView reloadData];

}

- (void)setTimingSeconds:(CGFloat)timingSeconds{
    _timingSeconds                             = timingSeconds;
        [self addTimerWithSecond:timingSeconds];
}
- (void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl                           = showPageControl;
    self.pageControl.hidden                    = !showPageControl;
}
- (void)setImageRect:(CGRect)imageRect{
    _imageRect = imageRect;
    for (UIImageView* imageView in self.carouselView.visibleItemViews) {
        imageView.frame = imageRect;
    }
}
@end
