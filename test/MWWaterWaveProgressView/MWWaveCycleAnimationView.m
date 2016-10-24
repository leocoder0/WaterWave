//
//  MWWaveCycleAnimationView.m
//  test
//
//  Created by caifeng on 2016/10/19.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import "MWWaveCycleAnimationView.h"
#import "MWWaveProgressView.h"

@interface MWWaveCycleAnimationView (){

    CAShapeLayer *_maskLayer;
    MWWaveProgressView *_wave;
    CGFloat _margin;//水波纹和外围layer的间距
}

@end

@implementation MWWaveCycleAnimationView

- (instancetype)init {

    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setDefaultProperty];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    if (self.isCycleAnimated) {
        UIImage *image = [UIImage imageNamed:@"wave.bundle/cycleBorderAnim.png"];
        [image drawInRect:rect];
    } else {
        UIImage *image = [UIImage imageNamed:@"wave.bundle/cycleBorder.png"];
        [image drawInRect:rect];
    }
}

- (void)layoutSubviews {
    
    if (_wave == nil) {
        _wave = [[MWWaveProgressView alloc] init];
        [self addSubview:_wave];
    }
    
    if (self.isCycleAnimated)
        _margin = mCYCLEANIMATION_MARGIN;
    else
        _margin = mCYCLE_MARGIN;
    
    CGRect rect = CGRectMake(_margin, _margin, self.frame.size.width - _margin * 2, self.frame.size.height - _margin * 2);
    _wave.frame = rect;
    _wave.percent = self.percent;
    _wave.peak = self.peak;
    _wave.period = self.period;
    _wave.speed = self.speed;
    _wave.explainText = self.explainText;
    _wave.explainFont = self.explainFont;
    _wave.explainColor = self.explainColor;
    _wave.completeText = self.completeText;
    _wave.completeFont = self.completeFont;
    _wave.completeColor = self.completeColor;
    [_wave setNeedsLayout];
    
    if (self.isCycleAnimated)
        [self addMaskLayerOnCycleImage];//添加image遮盖层
    else
        [_maskLayer removeFromSuperlayer];
}

#pragma mark - Helper Methods

//为外围图片添加遮盖层
- (void)addMaskLayerOnCycleImage {

    CGSize size = self.frame.size;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width * 0.5, size.height * 0.5) radius:size.width * 0.5 - mCYCLEANIMATION_MARGIN * 0.5 startAngle:3 * M_PI_2 endAngle:-M_PI_2 clockwise:NO];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = [UIColor whiteColor].CGColor;
    maskLayer.path = maskPath.CGPath;
    maskLayer.lineWidth = mCYCLEANIMATION_MARGIN + 1;
    [self.layer addSublayer:maskLayer];
    _maskLayer = maskLayer;
    
    // 为遮盖层添加动画效果
    [self addBaseAnimationWithLayer:maskLayer];
}

// 遮盖层动画效果
- (void)addBaseAnimationWithLayer:(CAShapeLayer *)maskLayer {

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.duration = mMASKLAYER_DURATION;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:anim forKey:@"MaskLayerAnimation"];
}

// 设置默认值
- (void)setDefaultProperty {
    
    // 设置默认值
    self.speed = mWATERWAVE_DEFAULT_SPEED;
    self.peak = mWATERWAVE_DEFAULT_PEAK;
    self.period = mWATERWAVE_DEFAULT_PERIOD;
    self.cycleAnimate = YES;
}





#pragma mark - Public Methods

- (void)startWave {

    [_wave startWave];
}

- (void)stopWave {

    [_wave stopWave];
}


#pragma mark - Setter Methods

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setDefaultProperty];
    [self layoutIfNeeded];
}

- (void)setPercent:(CGFloat)percent {
    NSAssert(percent >= 0.0f && percent <= 1, @"水波纹完成比例不得小于0或大于1!");
    _percent = percent;
    [self setNeedsLayout];
}


- (void)setCycleAnimate:(BOOL)cycleAnimate {
    
    _cycleAnimate = cycleAnimate;
}


@end
