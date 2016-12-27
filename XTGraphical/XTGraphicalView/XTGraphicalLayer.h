//
//  XTGraphicalLayer.h
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/27.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum{
    XTPieTypeFullCir = 0,//整圆
    XTPieTypeEmptyCir = 1//圆环
}XTPieType;

@interface XTGraphicalLayer : CAShapeLayer

@property (nonatomic, assign)XTPieType pieType;

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngele color:(UIColor *)color cirType:(XTPieType)pietype;

@end
