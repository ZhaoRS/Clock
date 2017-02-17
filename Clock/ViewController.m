//
//  ViewController.m
//  Clock
//
//  Created by 赵瑞生 on 2017/2/17.
//  Copyright © 2017年 赵瑞生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *minuteView;
@property (nonatomic, strong) UIView *hourView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CALayer *dialLayer = [[CALayer alloc] init];
    //设置layer的大小
    dialLayer.bounds = CGRectMake(0, 0, 150, 150);
    //设置layer的位置
    dialLayer.position = self.view.center;
    dialLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    [self.view.layer addSublayer:dialLayer];
    
    //设置秒针
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 60)];
    [self setAllView:_secondView backgroundColor:[UIColor redColor]];
    
    //设置分针
    _minuteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 60)];
    [self setAllView:_minuteView backgroundColor:[UIColor darkGrayColor]];
    
    //设置时针
    _hourView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 60)];
    [self setAllView:_hourView backgroundColor:[UIColor blackColor]];
    
    //创建CADisplayLink
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(clockRunning)];
    //将创建的CADisplayLink加入到主线程
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
 
}

- (void)clockRunning {

    NSTimeZone *tZone = [NSTimeZone localTimeZone];
    //获取日日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *currentDate = [NSDate date];
    [calendar setTimeZone:tZone];
    
    NSDateComponents *currentTime = [calendar components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour fromDate:currentDate];
    
    CGFloat secondAngle = (M_PI * 2 / 60) *currentTime.second;
    _secondView.transform = CGAffineTransformMakeRotation(secondAngle);
    
    CGFloat minuteAngle = (M_PI * 2 / 60) *currentTime.minute;
    _minuteView.transform = CGAffineTransformMakeRotation(minuteAngle);
    
    CGFloat hourAngle = (M_PI * 2 / 12) *currentTime.hour;
    _hourView.transform = CGAffineTransformMakeRotation(hourAngle);
    
}

- (void)setAllView:(UIView *)view backgroundColor:(UIColor *)backgroundColor  {

    view.backgroundColor = backgroundColor;
    view.center = self.view.center;
    //设置描点
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
