//
//  XTCirView.h
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XTCirStyle) {
    XTCirFullStyle = 0,
    XTCirEmptyStyle
};

@interface XTCirView : UIView

/**
 圆的类型
 */
@property (nonatomic, assign)XTCirStyle cirStyle;

/**
 圆环宽度，默认20
 */
@property (nonatomic, assign)CGFloat cirWidth;


/**
 根据frame创建圆

 @param frame 对应的frame
 @param color 颜色
 @param style 圆的类型
 @param animation 是否动画
 */
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color cirStyle:(XTCirStyle)style isAnimation:(bool)animation;

/**
 使用圆心以及半径创建圆

 @param center 圆心点
 @param raduis 半径
 @param color 颜色
 @param style 圆的类型
 @param animation 是否动画
 */
- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)raduis color:(UIColor *)color cirStyle:(XTCirStyle)style isAnimation:(bool)animation;

@end
