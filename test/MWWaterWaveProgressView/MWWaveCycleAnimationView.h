//
//  MWWaveCycleAnimationView.h
//  test
//
//  Created by caifeng on 2016/10/19.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import <UIKit/UIKit.h>

#define mCYCLEANIMATION_MARGIN 20 //外围动画和水波纹之间的间隔
#define mCYCLE_MARGIN          10 //外围非动画和水波纹之间的间隔
#define mMASKLAYER_DURATION     3 //外围动画时间

@interface MWWaveCycleAnimationView : UIView

@property (nonatomic, assign) CGFloat percent;/**<完成比例 DEFAULT:0.0*/
@property (nonatomic, assign) CGFloat speed;  /**<水波纹横向移动的速度 DEFAULT:0.1*/
@property (nonatomic, assign) CGFloat peak;   /**<峰值:水波纹的纵向高度 DEFAULT:6.0*/
@property (nonatomic, assign) CGFloat period; /**<周期数:一定宽度内水波纹的周期个数 DEFAULT:1.2*/

@property (nonatomic, assign, getter=isCycleAnimated) BOOL cycleAnimate;/**<是否需要外围动画*/

@property (nonatomic, copy)   NSString *explainText;
@property (nonatomic, strong) UIColor *explainColor;
@property (nonatomic, assign) CGFloat explainFont;

@property (nonatomic, copy)   NSString *completeText;
@property (nonatomic, strong) UIColor *completeColor;
@property (nonatomic, assign) CGFloat completeFont;


/**
 开启水波纹动画
 */
- (void)startWave;

/**
 停止
 */
- (void)stopWave;


@end
