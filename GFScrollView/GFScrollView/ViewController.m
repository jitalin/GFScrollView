//
//  ViewController.m
//  GFScrollView
//
//  Created by 高飞 on 16/12/6.
//  Copyright © 2016年 高飞. All rights reserved.
//

#import "ViewController.h"
#import "GFScrollView.h"
@interface ViewController ()
@property (nonatomic,strong) GFScrollView *myView;
@property (nonatomic,strong) GFScrollView *myView2;
@property (nonatomic,strong) NSArray *carouselTypeArray;
@property (nonatomic,strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carouselTypeArray = @[@"iCarouselTypeLinear",
                               @"iCarouselTypeRotary",
                               @"iCarouselTypeInvertedRotary",
                               @"iCarouselTypeCylinder",
                               @"iCarouselTypeInvertedCylinder",
                               @"iCarouselTypeWheel",
                               @"iCarouselTypeInvertedWheel",
                               @"iCarouselTypeCoverFlow",
                               @"iCarouselTypeCoverFlow2",
                               @"iCarouselTypeTimeMachine",
                               @"iCarouselTypeInvertedTimeMachine",
                               @"iCarouselTypeCustom"];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 40, CGRectGetWidth(self.view.bounds), 40)];
    [btn setTitle:@"changeMyViewCarouselType" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0.363 green:0.167 blue:0.106 alpha:1.000];
    [btn addTarget:self action:@selector(changeCarouselType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    
    
    
    
    [self setUpCarouselWithLocalImage];
    [self setUpCarouselWithUrlImage];
    
    [self addCarouselViewWithCarouselType:8 ContentView:self.view];
    
}
- (void)setUpCarouselWithLocalImage{
    GFScrollView* view     = [[GFScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    self.myView = view;
    view.imageArray        = @[@"0.jpg",@"1.jpg",@"2.jpg"];
    view.imageRect = CGRectMake(80, 50, CGRectGetWidth(view.bounds) - 160, CGRectGetHeight(view.bounds)-100);
    [self.view addSubview: view];

    [view selectedItemWithSelectedBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
       
    }];
  

    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 80, CGRectGetWidth(self.view.bounds), 40)];
    self.label = label;
    label.textAlignment = NSTextAlignmentCenter;
    NSString* str = self.carouselTypeArray[self.myView.carouselView.type];
    label.text = [NSString stringWithFormat:@"第一个轮播图的轮播类型是%@" ,str];
    [self.view addSubview:label];
    
}
- (void)setUpCarouselWithUrlImage{
    GFScrollView* view     = [[GFScrollView alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 200)];
    self.myView2 = view;
    view.carouselView.type = iCarouselTypeCylinder;
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *s1 = @"http://img4.duitang.com/uploads/item/201409/07/20140907092042_nAGzk.thumb.700_0.jpeg";
        NSString *s2 = @"http://img5.duitang.com/uploads/item/201408/12/20140812170146_AGvzn.jpeg";
        NSString *s3 = @"http://img4q.duitang.com/uploads/item/201408/06/20140806174038_he5Fc.jpeg";
        
        
        NSArray *array = @[s1,s2,s3];
        view.imageArray  = array;
    });
    [self.view addSubview: view];
    [view selectedItemWithSelectedBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
        
    }];

}
- (void)addCarouselViewWithCarouselType:(iCarouselType)type ContentView:(UIView* )contentView{
    GFScrollView* view     = [[GFScrollView alloc]initWithFrame:CGRectMake(0, 400, contentView.bounds.size.width, 200)];
    view.imageArray        = @[@"0.jpg",@"1.jpg",@"2.jpg"];
    view.carouselView.type = type;
    [contentView addSubview: view];
    [view selectedItemWithSelectedBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
        [view.timer invalidate];
        
        
    }];
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.myView.timer invalidate];
    [self.myView2.timer invalidate];
    
    NSLog(@"%@",self.myView.timer);
}
- (void)changeCarouselType:(UIButton* )btn{
    self.myView.carouselView.type = arc4random()%11;
    NSString* str = self.carouselTypeArray[self.myView.carouselView.type];
    
    self.label.text = [NSString stringWithFormat:@"第一个轮播图的轮播类型是%@" ,str];
    
   }

@end
