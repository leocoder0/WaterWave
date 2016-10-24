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
    
    UIBezierPath *expendedPath = [self pathWithRadius:8];
    
    CAShapeLayer *expendedLayer = [CAShapeLayer layer];
    expendedLayer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor;
    expendedLayer.strokeColor = [UIColor clearColor].CGColor;
    expendedLayer.lineWidth = 1.0;
    expendedLayer.path = expendedPath.CGPath;
    [self.layer addSublayer:expendedLayer];
    _expendedLayer = expendedLayer;
    
    [expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:14]] forKey:@"SparkPointExpendAnimation"];
    [expendedLayer addAnimation:[self fillColorAnimation]  forKey:@"FillAnimation"];
    
    
    UIBezierPath *pointPath = [self pathWithRadius:8];
    CAShapeLayer *epointLayer = [CAShapeLayer layer];
    epointLayer.fillColor = [UIColor whiteColor].CGColor;
    epointLayer.strokeColor = [UIColor clearColor].CGColor;
    epointLayer.lineWidth = 1.0;
    epointLayer.path = pointPath.CGPath;
    [expendedLayer addSublayer:epointLayer];

}

- (CABasicAnimation *)fillColorAnimation {

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    anim.toValue = (id)[UIColor clearColor].CGColor;
    anim.duration = 0.5;
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    return anim;
}

- (CABasicAnimation *)pathAnimationWithPath:(UIBezierPath *)path {

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (id)path.CGPath;
    anim.duration = 0.5;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    return anim;
}


- (UIBezierPath *)pathWithRadius:(CGFloat)radius {

    UIBezierPath *pointPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    return pointPath;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if ([_expendedLayer animationForKey:@"SparkPointExpendAnimation"] == anim) {
        
        [_expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:8]] forKey:@"SparkPointShrinkAnimation"];

    } else if ([_expendedLayer animationForKey:@"SparkPointShrinkAnimation"] == anim) {
       
        [_expendedLayer addAnimation:[self pathAnimationWithPath:[self pathWithRadius:16]] forKey:@"SparkPointExpendAnimation"];
        [_expendedLayer addAnimation:[self fillColorAnimation]  forKey:@"FillAnimation"];
    }
}

@end
