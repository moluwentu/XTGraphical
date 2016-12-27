//
//  XTCirView.m
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTCirView.h"
#import "XTGraphicalLayer.h"

@interface XTCirView ()

@end

@implementation XTCirView

- (instancetype)initWithFrame:(CGRect)frame colorArray:(NSArray *)colorArray angleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation{
    if (self = [super initWithFrame:frame]) {
        CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
        CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
       
        NSAssert(colorArray.count == angleArray.count, @"colorArray's count must be equal to angleArray's count");
        
        [self drawPiewWithCenter:center radius:radius colorArray:colorArray angleArray:angleArray cirStyle:style isAnimation:angleArray];
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)raduis colorArray:(NSArray *)colorArray AngleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation{

    if (self = [super initWithFrame:CGRectMake(center.x - raduis / 2, center.y - raduis / 2, raduis, raduis)]) {
        [self drawPiewWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2) radius:raduis colorArray:colorArray angleArray:angleArray cirStyle:style isAnimation:angleArray];
    }
    return self;
}

- (void)drawPiewWithCenter:(CGPoint)center radius:(CGFloat)radius colorArray:(NSArray *)colorArray angleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation{
    __block double sum = 0;
    [angleArray enumerateObjectsUsingBlock:^(NSString *angleStr, NSUInteger idx, BOOL * _Nonnull stop) {
        sum = sum + [angleStr doubleValue];
    }];
    
    NSMutableArray *percentArray = [NSMutableArray array];
    [angleArray enumerateObjectsUsingBlock:^(NSString *angleStr, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat angle = [angleStr floatValue];
        [percentArray addObject:[NSString stringWithFormat:@"%f",angle / sum * M_PI * 2]];
    }];
    
    __block CGFloat originAngle = 0;
    for (int i = 0; i < percentArray.count; i++) {
        NSString *angleStr = percentArray[i];
        CGFloat angle = [angleStr floatValue];
        
        XTGraphicalLayer *glayer = [[XTGraphicalLayer alloc]initWithCenter:center radius:radius startAngle:originAngle endAngle:angle + originAngle color:colorArray[i] cirType:style == XTPieTypeFullCir ? 0 : 1];
        originAngle = originAngle + angle;
        [self.layer addSublayer:glayer];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
