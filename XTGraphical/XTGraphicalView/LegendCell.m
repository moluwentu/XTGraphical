//
//  LegendCell.m
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/29.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "LegendCell.h"

#define legendViewWidth (self.frame.size.width * 2 / 3)
#define legendViewHeight 20

@interface LegendCell ()

@property (nonatomic, strong)UIView *legendColorView;
@property (nonatomic, strong)UILabel *legendLabel;

@end

@implementation LegendCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.legendColorView];
    [self addSubview:self.legendLabel];
}

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.legendColorView.backgroundColor = backColor;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.legendLabel.text = [NSString stringWithFormat:@"%@",title];
}

- (UIView *)legendColorView{
    if (_legendColorView == nil) {
        _legendColorView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width - legendViewWidth) / 2, 8, legendViewWidth, legendViewHeight)];
        _legendColorView.backgroundColor = [UIColor cyanColor];
    }
    return _legendColorView;
}

- (UILabel *)legendLabel{
    if (_legendLabel == nil) {
        _legendLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, legendViewWidth, self.frame.size.width, self.frame.size.height - legendViewWidth)];
//        _legendLabel.center = CGPointMake(self.frame.size.width / 2, legendViewHeight + 8 + 8);
        _legendLabel.numberOfLines = 0;
        _legendLabel.textAlignment = NSTextAlignmentCenter;
        _legendLabel.font = [UIFont systemFontOfSize:10];
        _legendLabel.textColor = [UIColor darkGrayColor];
    }
    return _legendLabel;
}

@end
