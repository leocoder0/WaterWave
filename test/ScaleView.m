//
//  ScaleView.m
//  test
//
//  Created by caifeng on 16/10/17.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import "ScaleView.h"

@implementation ScaleView



- (void)drawRect:(CGRect)rect {

    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = rect;
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:maskLayer];

    // 计算总数
    NSInteger sum = 0;
    for (int i = 0; i < self.sections.count; i++) {
        sum += [self.sections[i] integerValue];
    }
    
    if (sum == 0) {
        // 总资产
        UIBezierPath *totalPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.5 - 4 startAngle:0  endAngle:2 * M_PI clockwise:YES];
        CAShapeLayer *totalLayer = [CAShapeLayer layer];
        totalLayer.lineWidth = 6.5;
        totalLayer.fillColor = [UIColor whiteColor].CGColor;
        totalLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        totalLayer.path = totalPath.CGPath;
        [maskLayer addSublayer:totalLayer];
        
    } else {
        
        
        CGFloat startAngle = 0; // 设置起始角度
        for (int i = 0; i < self.sections.count; i++) {
            
            //计算比例
            CGFloat scale = [self.sections[i] integerValue] / (sum * 1.0);
            
            // 设置结束角度
            CGFloat endAngle = startAngle + scale  * M_PI * 2;
            
            // 设置 sections 颜色
            UIColor *sectionColor = self.sectionColors[i];
        
                
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.5 - 4 startAngle:startAngle endAngle:endAngle clockwise:YES];
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.strokeColor = sectionColor.CGColor;
            layer.lineWidth = 6.5;
        
            [maskLayer addSublayer:layer];
  
            
            // 重新设置起始角度
            startAngle = endAngle;
        }
        
        
        // 总资产
        UIBezierPath *totalPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.5 - 4 startAngle:0  endAngle:2 * M_PI clockwise:NO];
        CAShapeLayer *totalLayer = [CAShapeLayer layer];
        totalLayer.lineWidth = 7;
        totalLayer.fillColor = [UIColor whiteColor].CGColor;
        totalLayer.strokeColor = [UIColor whiteColor].CGColor;
        totalLayer.path = totalPath.CGPath;
        [maskLayer addSublayer:totalLayer];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @1;
        animation.toValue = @0;
        animation.duration = 5.0;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.delegate = self;
        [totalLayer addAnimation:animation forKey:@"Test"];
    }
    


}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    NSLog(@"-----");
}


@end
