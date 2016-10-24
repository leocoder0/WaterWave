//
//  MWWaterWaveProgressView.h
//  test
//
//  Created by caifeng on 2016/10/19.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import <UIKit/UIKit.h>

#define mWATERWAVE_DEFAULT_SPEED 0.1;
#define mWATERWAVE_DEFAULT_PEAK  6.0
#define mWATERWAVE_DEFAULT_PERIOD 1.2
#define mFIRSTWAVE_DEFAULT_COLOR [UIColor colorWithRed:223/255.0 green:83/255.0 blue:64/255.0 alpha:0.5]
#define mSECONDEWAVE_DEFAULT_COLOR [UIColor colorWithRed:236/255.0f green:90/255.0f blue:66/255.0f alpha:0.5]
#define mExplain_Default_Font 16
#define mExplain_Default_Color [UIColor grayColor]
#define mComplete_Default_Font 20
#define mComplete_Default_Color [UIColor blackColor]

typedef NS_ENUM(NSInteger ,mCurveType) {
    
    mCurveTypeSin, // 正选
    mCurveTypeCos  // 余弦
};

@interface MWWaveProgressView : UIView

@property (nonatomic, assign) CGFloat percent;/**<完成比例 DEFAULT:0.0*/
@property (nonatomic, assign) CGFloat speed;  /**<水波纹横向移动的速度 DEFAULT:0.1*/
@property (nonatomic, assign) CGFloat peak;   /**<峰值:水波纹的纵向高度 DEFAULT:6.0*/
@property (nonatomic, assign) CGFloat period; /**<周期数:一定宽度内水波纹的周期个数 DEFAULT:1.2*/

@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;

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
