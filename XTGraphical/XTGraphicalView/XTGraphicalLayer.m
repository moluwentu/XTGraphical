//
//  XTGraphicalLayer.m
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/27.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTGraphicalLayer.h"

@implementation XTGraphicalLayer

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngele color:(UIColor *)color cirType:(XTPieType)pietype{
    if (self = [super init]) {
        
        if (pietype == XTPieTypeFullCir) {
            radius = radius / 2;
            self.lineWidth = radius * 2;
        }else{
            self.lineWidth = 30;
        }
        
        self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngele clockwise:YES].CGPath;
        self.fillColor = nil;
        self.strokeColor = color.CGColor;
    }
    return self;
}

@end
