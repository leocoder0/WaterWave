//
//  MWWaterWaveProgressView.m
//  test
//
//  Created by caifeng on 2016/10/19.
//  Copyright © 2016年 com.lingxian01. All rights reserved.
//

#import "MWWaveProgressView.h"

@interface MWWaveProgressView (){

    CAShapeLayer *_firstWaveLayer;
    CAShapeLayer *_secondWaveLayer;
//    UIColor *_firstWaveLayerColor;
//    UIColor *_secondWaveLayerColor;
    CGFloat _waveHeight;/**<水纹高度*/
    CGFloat _width;
    CGFloat _height;
    CGFloat _offSet;
    CADisplayLink *_link;
    
    CGFloat _changePercent;
    
    UILabel *_progressLabel;
    UILabel *_explainLabel;
}

@end

@implementation MWWaveProgressView

- (instancetype)init {

    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        _height = frame.size.height;
        [self setDefaultProperty];

    }
    return self;
}

- (void)layoutSubviews {

    [self layoutWaveLayers];
    [self addProgressLabel];
    [self addExplainLabel];

}

- (void)drawRect:(CGRect)rect {
    
    UIImage *cycleImage = [UIImage imageNamed:@"wave.bundle/cycleBorder.png"];
    [cycleImage drawInRect:CGRectMake(0, 0, _width, _height)];
}


#pragma mark - Public Methods

- (void)startWave {

    if (_link == nil) {
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopWave {

    _changePercent = 0.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_link invalidate];
        _link = nil;
    });
}

#pragma mark - Helper Methods

#pragma mark **** 添加解释label
- (void)addExplainLabel {

    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc] init];
        [self addSubview:_explainLabel];
    }
    
    CGFloat font = self.explainFont == 0 ? mExplain_Default_Font : self.explainFont;
    UIColor *color = self.explainColor == nil ? mExplain_Default_Color : self.explainColor;
    CGSize size = [self sizeWithText:self.explainText font:font];
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.center = CGPointMake(_width * 0.5, CGRectGetMinY(_progressLabel.frame) - size.height * 0.5 - 10);
    _explainLabel.bounds = CGRectMake(0, 0, _width, size.height);
    _explainLabel.text = self.explainText;
    _explainLabel.textColor = color;
    _explainLabel.font = [UIFont systemFontOfSize:font];
}

#pragma mark **** 添加进度Label
- (void)addProgressLabel {

    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc] init];
        [self addSubview:_progressLabel];
    }
    CGFloat font = self.completeFont == 0 ? mComplete_Default_Font : self.completeFont;
    UIColor *color = self.completeColor == nil ? mComplete_Default_Color : self.completeColor;
    CGSize size = [self sizeWithText:self.completeText font:font];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    _progressLabel.center = CGPointMake(_width * 0.5, _height * 0.5);
    _progressLabel.bounds = CGRectMake(0, 0, _width, size.height);
    _progressLabel.textColor = color;
    _progressLabel.font = [UIFont boldSystemFontOfSize:font];
    _progressLabel.attributedText = [self attributeStringWithText:self.completeText textFont:font];
}

#pragma mark **** 获得可变属性字体
- (NSMutableAttributedString *)attributeStringWithText:(NSString *)text textFont:(CGFloat)font {

    NSRange range = [text rangeOfString:@"%"];
    if (text == nil || range.location == NSNotFound) return nil;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text];
    [attrText addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font - 15]} range:range];
    return attrText;
}

#pragma mark **** 获得尺寸
- (CGSize)sizeWithText:(NSString *)text font:(CGFloat)font {

    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
}


#pragma mark **** 添加水波纹Layer
- (void)layoutWaveLayers {

    if (!self.firstWaveColor ) self.firstWaveColor = mFIRSTWAVE_DEFAULT_COLOR;
    if (!self.secondWaveColor) self.secondWaveColor = mSECONDEWAVE_DEFAULT_COLOR;
    
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_secondWaveLayer];
    }
    
    _firstWaveLayer.fillColor = self.firstWaveColor.CGColor;
    _secondWaveLayer.fillColor = self.secondWaveColor.CGColor;
}


#pragma mark **** 通过改变percent的值实现动画效果
- (void)percentChange {
    
    _changePercent += 0.005;
    if (_changePercent > _percent) {// 当定时器改变的值(_changePercent)大于设定的值(_percent)时停止变化【注意:不可以使用等于号】
        _changePercent -= 0.005;
    }
}


#pragma mark **** 定时器事件
- (void)displayLinkAction {
    
    _offSet -= _speed;
    
    [self percentChange];
    
    // 正弦曲线
    CGMutablePathRef sinPath = [self pathWithCurveType:mCurveTypeSin];
    _firstWaveLayer.path = sinPath;
    CGPathRelease(sinPath);
    
    // 余弦曲线
    CGMutablePathRef cosPath = [self pathWithCurveType:mCurveTypeCos];
    _secondWaveLayer.path = cosPath;
    CGPathRelease(cosPath);
}

#pragma mark **** 通过曲线类型获得对应的曲线路径
- (CGMutablePathRef)pathWithCurveType:(mCurveType)curveType {

    _waveHeight = (1 - _changePercent) * _height;
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, nil, 0, _waveHeight);
    CGFloat y;
    for (CGFloat x = 0.0f; x < _width; x++) {
        switch (curveType) {
            case 0:
                y = _peak * sin(_period * M_PI / _width * x + _offSet) + _waveHeight;
                break;
            case 1:
                y = _peak * cos(_period * M_PI / _width * x + _offSet) + _waveHeight;
                break;
  
            default:
                break;
        }
        CGPathAddLineToPoint(mutablePath, nil, x, y);
    }
    CGPathAddLineToPoint(mutablePath, nil, _width, _height);
    CGPathAddLineToPoint(mutablePath, nil, 0, _height);
    CGPathCloseSubpath(mutablePath);
    return mutablePath;
}

#pragma mark **** 设置默认值
- (void)setDefaultProperty {
    
    self.layer.cornerRadius = _width * 0.5;
    self.clipsToBounds = YES;

    // 设置默认值
    _waveHeight = _height;
    _speed = mWATERWAVE_DEFAULT_SPEED;
    _peak = mWATERWAVE_DEFAULT_PEAK;
    _period = mWATERWAVE_DEFAULT_PERIOD;
}


#pragma mark - Setter Methods

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _width = frame.size.width;
    _height = frame.size.height;
    [self setDefaultProperty];
}

- (void)setPercent:(CGFloat)percent {
    NSAssert(percent >= 0.0f && percent <= 1, @"水波纹完成比例不得小于0或大于1!");
    _percent = percent;
}

- (void)setSpeed:(CGFloat)speed {
    NSAssert(speed >= 0, @"水波纹横向移动速度不得小于0!");
    _speed = speed;
}

- (void)setPeak:(CGFloat)peak {
    NSAssert(peak >= 0, @"水波纹峰值不得小于0!");
    _peak = peak;
}

- (void)setPeriod:(CGFloat)period {
    NSAssert(period > 0, @"水波纹周期数必须大于0!");
    _period = period;
}


@end
