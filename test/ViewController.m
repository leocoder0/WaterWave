//
//  ViewController.m
//  test
//
//  Created by caifeng on 16/9/28.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "ScaleView.h"
#import "MWSparkPointView.h"

#import "MWWaveProgressView.h"
#import "MWWaveCycleAnimationView.h"

 NSString * const str = @"hello";

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@", str);
    NSLog(@"%p", str);
    NSLog(@"%p", &str);
    
//    [str stringByAppendingString:@"world"];
//    str = @"world";
    NSString *s = str;
    NSLog(@"%@", s);
    NSLog(@"%p", s);
    NSLog(@"%p", &s);
 
    // 闪光点
    [self sparkPoint];
    
    // 比例进度
    [self scale];
    
    // 水波纹
    [self waterWave];
    
    
    // 动画水波纹
    [self waterWaveWithAnimation];
    
    
//    UIImage *image = [UIImage imageNamed:@"wave.bundle/cycleBorder.png"];
//    NSData *data = UIImagePNGRepresentation(image);
    
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"wave" ofType:@"bundle"];
//    NSData *data = [NSData dataWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"cycleBorder.png"]];
//    
//    if (data) {
//        NSLog(@"%f", data.length / 1024.0);
//    }
    
   
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    
}


- (void)time:(NSTimer *)t {

    NSLog(@"xxxxx");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.timer setFireDate:[NSDate distantFuture]];
    
}

- (void)sparkPoint {

    MWSparkPointView *point = [[MWSparkPointView alloc] initWithFrame:CGRectMake(100, 80, 50, 50)];
    [self.view addSubview:point];

}


- (void)scale {
    
    ScaleView *scale = [[ScaleView alloc] initWithFrame:CGRectMake(220, 50, 100, 100)];
    scale.sections = @[@10, @20, @30, @40];
    scale.sectionColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor blueColor]];
    [self.view addSubview:scale];
}


- (void)waterWave {

        MWWaveProgressView *waterWave = [[MWWaveProgressView alloc] init];
        waterWave.frame = CGRectMake(120, 230, 150, 150);
        waterWave.percent = 0.8;
        waterWave.speed = 0.1;
        waterWave.peak = 6;
        waterWave.explainText = @"complete";
        waterWave.explainFont = 16;
        waterWave.explainColor = [UIColor grayColor];
        waterWave.completeText = @"90.00%";
        waterWave.completeFont = 30;

        [self.view addSubview:waterWave];
        [waterWave startWave];
}


- (void)waterWaveWithAnimation {

    MWWaveCycleAnimationView *wave = [[MWWaveCycleAnimationView alloc] init];
    wave.frame = CGRectMake(120, 420, 150, 150);
    wave.percent = 0.7;
    //    wave.cycleAnimate = NO;
    //    wave.speed = 12;
    wave.explainText = @"complete";
    wave.explainFont = 16;
    wave.explainColor = [UIColor grayColor];
    wave.completeText = @"90.00%";
    wave.completeFont = 30;
    wave.completeColor = [UIColor redColor];
    [self.view addSubview:wave];
    [wave startWave];
}

@end
