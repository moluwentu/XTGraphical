//
//  XTCirView.h
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XTCirStyle) {
    XTCirFullStyle = 0, //实心圆
    XTCirEmptyStyle     //空心圆
};

@interface XTCirView : UIView

/**
 圆的类型
 */
@property (nonatomic, assign)XTCirStyle cirStyle;

@property (nonatomic, assign)bool isLegend;

/**
 根据frame画圆

 @param frame 根据这个frame来画圆
 @param colorArray 颜色数组
 @param angleArray 比例数组
 @param style 空心圆或者实心圆
 @param animation 是否动画

 */
- (instancetype)initWithFrame:(CGRect)frame colorArray:(NSArray *)colorArray angleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation;

/**
 根据圆心画圆

 @param center 圆心
 @param raduis 半径
 @param colorArray 颜色数组
 @param angleArray 比例数组
 @param style 空心圆或者实心圆
 @param animation 是否动画
 
 */
- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)raduis colorArray:(NSArray *)colorArray AngleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation;

@end
