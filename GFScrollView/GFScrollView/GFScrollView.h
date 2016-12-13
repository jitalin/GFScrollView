//
//  GFScrollView.h
//  GFScrollView
//
//  Created by 高飞 on 16/12/6.
//  Copyright © 2016年 高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "SMPageControl.h"
#import "UIImageView+WebCache.h"
#import "FXImageView.h"
@interface GFScrollView : UIView
typedef void(^SelectedBlock)(NSInteger index);

@property (nonatomic,strong) SMPageControl *pageControl;
/**
 *  轮播视图
 */
@property (nonatomic,strong) iCarousel* carouselView;
/**
 *  allImages
 */
@property (nonatomic,strong) NSArray *imageArray;

/**
 *  图片frame
 */
@property (nonatomic,assign) CGRect imageRect;
/**
 *  图片内容模式
 */
@property (nonatomic,assign) UIViewContentMode imageViewType;
/**
 *  定时器（在viewDidDisappear记得要销毁)
 */
@property (nonatomic,weak) NSTimer *timer;
/**
 *  定时秒数
 */
@property (nonatomic,assign) CGFloat timingSeconds;
/**
 *  是否显示pageControl
 */
@property (nonatomic,assign,getter=isShowPageContol) BOOL showPageControl;

@property (nonatomic,copy) SelectedBlock selectedBlock;

- (void)selectedItemWithSelectedBlock:(SelectedBlock)selectedBlock;


@end
