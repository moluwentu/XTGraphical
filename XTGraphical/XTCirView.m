//
//  XTCirView.m
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTCirView.h"

@interface XTCirView ()

@property (nonatomic, strong)CAShapeLayer *shaperLayer;

@end

@implementation XTCirView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color cirStyle:(XTCirStyle)style isAnimation:(bool)animation{
    if (self = [super initWithFrame:frame]) {
        CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
        CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self drawCirWithCenter:center radius:radius color:nil cirStyle:style isAnimation:animation];
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)raduis color:(UIColor *)color cirStyle:(XTCirStyle)style isAnimation:(bool)animation{

    if (self = [super initWithFrame:CGRectMake(center.x - raduis / 2, center.y - raduis / 2, raduis, raduis)]) {
        [self drawCirWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2) radius:raduis color:nil cirStyle:style isAnimation:animation];
    }
    return self;
}

- (void)drawCirWithCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color cirStyle:(XTCirStyle)style isAnimation:(bool)animation{
    UIBezierPath *cirPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    self.shaperLayer.path = cirPath.CGPath;
    
    switch (style) {
        case XTCirEmptyStyle:
        {
            self.shaperLayer.lineWidth = 20;
            self.shaperLayer.fillColor = [[UIColor whiteColor] CGColor];
            self.shaperLayer.strokeColor = color ? [color CGColor] : [[UIColor orangeColor] CGColor];
            [self.layer addSublayer:self.shaperLayer];
        }
            break;
        case XTCirFullStyle:
        {
            self.shaperLayer.fillColor = color ? [color CGColor] : [[UIColor orangeColor] CGColor];
            [self.layer addSublayer:self.shaperLayer];

        }
            break;
        default:
            break;
    }
    
    if (animation) {
        CABasicAnimation *baseAnimation = [self animationWithDuration:1];
        [self.shaperLayer addAnimation:baseAnimation forKey:nil];
    }
}

- (CABasicAnimation *)animationWithDuration:(CFTimeInterval)duration{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = duration;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    
    return fillAnimation;
}


- (void)setCirWidth:(CGFloat)cirWidth{
    _cirWidth = cirWidth;
    self.shaperLayer.lineWidth = cirWidth;
}

- (CAShapeLayer *)shaperLayer{
    if (_shaperLayer == nil) {
        _shaperLayer = [CAShapeLayer layer];
    }
    return _shaperLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
