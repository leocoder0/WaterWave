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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 闪光点
    [self sparkPoint];
    
    // 比例进度
    [self scale];
    
    // 水波纹
    [self waterWave];
    
    
    // 动画水波纹
    [self waterWaveWithAnimation];
    
   
}


- (void)sparkPoint {

    MWSparkPointView *point = [[MWSparkPointView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
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
