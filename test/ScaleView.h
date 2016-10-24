//
//  ScaleView.h
//  test
//
//  Created by caifeng on 16/10/17.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleView : UIView<CAAnimationDelegate>

@property(nonatomic,strong)NSArray *sections;
@property(nonatomic,strong)NSArray *sectionColors;

@end
