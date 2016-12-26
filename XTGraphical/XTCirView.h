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

@property (nonatomic, assign)XTCirStyle cirStyle;
//默认20
@property (nonatomic, assign)CGFloat cirWidth;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color cirStyle:(XTCirStyle)style;
- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)raduis color:(UIColor *)color cirStyle:(XTCirStyle)style;

@end
