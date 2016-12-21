//
//  MWSparkPointView.m
//  test
//
//  Created by caifeng on 16/10/17.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import "MWSparkPointView.h"

@interface MWSparkPointView ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *expendedLayer;
@end

@implementation MWSparkPointView

- (void)drawRect:(CGRect)rect {

    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = rect;
    bgLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:bgLayer];
    
    UIBezierPath *expendedPath = [self pathWithRadius:12];
    CAShapeLayer *expendedLayer = [CAShapeLayer layer];
    expendedLayer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor;
    expendedLayer.strokeColor = [UIColor clearColor].CGColor;
    expendedLayer.lineWidth = 1.0;
    expendedLayer.path = expendedPath.CGPath;
    [bgLayer addSublayer:expendedLayer];
    _expendedLayer = expendedLayer;
    
    [expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:20] duration:0.5] forKey:@"SparkPointExpendAnimation"];
    [expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] toValue:[UIColor clearColor] duration:0.5]  forKey:@"FillAnimation"];
    
    
    UIBezierPath *pointPath = [self pathWithRadius:6];
    CAShapeLayer *epointLayer = [CAShapeLayer layer];
    epointLayer.fillColor = [UIColor whiteColor].CGColor;
    epointLayer.strokeColor = [UIColor clearColor].CGColor;
    epointLayer.lineWidth = 1.0;
    epointLayer.path = pointPath.CGPath;
    [expendedLayer addSublayer:epointLayer];

}

- (CABasicAnimation *)fillColorAnimationFromValue:(UIColor *)fromColor toValue:(UIColor *)toColor duration:(CGFloat)duration {

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    anim.fromValue = (id)fromColor.CGColor;
    anim.toValue = (id)toColor.CGColor;
    anim.duration = duration;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    return anim;
}

- (CABasicAnimation *)pathAnimationWithPath:(UIBezierPath *)path duration:(CGFloat)duration {

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (id)path.CGPath;
    anim.duration = duration;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    return anim;
}


- (UIBezierPath *)pathWithRadius:(CGFloat)radius {

    UIBezierPath *pointPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 20) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    return pointPath;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if ([_expendedLayer animationForKey:@"SparkPointExpendAnimation"] == anim) {
        
        [_expendedLayer removeAllAnimations];
        [_expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:12] duration:0.01] forKey:@"SparkPointShrinkAnimation"];
        [_expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor clearColor] toValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] duration:0.01] forKey:@"FillAnimation"];

    } else if ([_expendedLayer animationForKey:@"SparkPointShrinkAnimation"] == anim) {
        [_expendedLayer removeAllAnimations];
        [_expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:20] duration:0.5] forKey:@"SparkPointExpendAnimation2"];
        [_expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] toValue:[UIColor clearColor] duration:0.5] forKey:@"FillAnimation"];
    } else if ([_expendedLayer animationForKey:@"SparkPointExpendAnimation2"] == anim) {
    
        [_expendedLayer removeAllAnimations];
        [_expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:12] duration:0.01] forKey:@"SparkPointShrinkAnimation2"];
        [_expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor clearColor] toValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] duration:0.01] forKey:@"FillAnimation"];
    } else if ([_expendedLayer animationForKey:@"SparkPointShrinkAnimation2"] == anim){
        [_expendedLayer removeAllAnimations];
        [_expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] toValue:[UIColor clearColor] duration:1.0] forKey:@"FillAnimation2"];
    } else if ([_expendedLayer animationForKey:@"FillAnimation2"] == anim) {
    
        [_expendedLayer removeAllAnimations];
        [_expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor clearColor] toValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] duration:0.5] forKey:@"FillAnimation3"];
    
    } else if ([_expendedLayer animationForKey:@"FillAnimation3"] == anim) {
    
        [_expendedLayer removeAllAnimations];
        [_expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:20] duration:0.5] forKey:@"SparkPointExpendAnimation"];
        [_expendedLayer addAnimation:[self fillColorAnimationFromValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] toValue:[UIColor clearColor] duration:0.5]  forKey:@"FillAnimation"];
    }
}

@end
