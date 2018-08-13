//
//  XTCirView.m
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#define animationdurition 2

#import "XTCirView.h"
#import "XTGraphicalLayer.h"
#import "LegendCell.h"

static NSString *const LegendCellID = @"LegendCellID";

@interface XTCirView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *legendView;
@property (nonatomic, strong)NSArray *colorArray;
@property (nonatomic, strong)NSArray *percentArray;

@end

@implementation XTCirView

#pragma mark --初始化--
- (instancetype)initWithFrame:(CGRect)frame colorArray:(NSArray *)colorArray angleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation{
    if (self = [super initWithFrame:frame]) {
        CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
        CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        self.colorArray = colorArray;
        self.percentArray = angleArray;
        NSAssert(colorArray.count == angleArray.count, @"colorArray's count must be equal to angleArray's count");
        
        [self drawPiewWithCenter:center radius:radius colorArray:colorArray angleArray:angleArray cirStyle:style isAnimation:angleArray];
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)raduis colorArray:(NSArray *)colorArray AngleArray:(NSArray *)angleArray cirStyle:(XTCirStyle)style isAnimation:(bool)animation{

    if (self = [super initWithFrame:CGRectMake(center.x - raduis / 2, center.y - raduis / 2, raduis, raduis)]) {
        self.colorArray = colorArray;
        self.percentArray = angleArray;
        [self drawPiewWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2) radius:raduis colorArray:colorArray angleArray:angleArray cirStyle:style isAnimation:animation];
    }
    return self;
}

#pragma mark --实现--
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
    NSLog(@"%@",percentArray);
    NSMutableArray *timeArray = [NSMutableArray array];
    [timeArray addObject:@"0"];
    [angleArray enumerateObjectsUsingBlock:^(NSString *angleStr, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat angle = [angleStr floatValue];
        //默认2秒
        [timeArray addObject:[NSString stringWithFormat:@"%f",angle / sum * animationdurition]];
    }];
    
    __block CGFloat originAngle = 0;
    __block CGFloat lastTime = 0;
//    CGFloat legendAngle = 0;
    for (int i = 0; i < percentArray.count; i++) {
        NSString *angleStr = percentArray[i];
        CGFloat angle = [angleStr floatValue];
        
//        //图例
//        legendAngle = originAngle + angle / 2;
//        [self calcCircleCoordinateWithCenter:center andWithAngle:legendAngle andWithRadius:radius];
        
        if (animation) {
            NSTimer *timer = [NSTimer timerWithTimeInterval:[timeArray[i] floatValue] + lastTime repeats:NO block:^(NSTimer * _Nonnull timer) {
                XTGraphicalLayer *glayer = [[XTGraphicalLayer alloc]initWithCenter:center radius:radius startAngle:originAngle endAngle:angle + originAngle color:colorArray[i] cirType:style == XTPieTypeFullCir ? 0 : 1];
                CABasicAnimation * animation = [self animationWithDuration:[timeArray[i + 1] floatValue] ];
                originAngle = originAngle + angle;
                [self.layer addSublayer:glayer];
                [glayer addAnimation:animation forKey:nil];
            }];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            lastTime = [timeArray[i] floatValue] + lastTime;
        }else{
            XTGraphicalLayer *glayer = [[XTGraphicalLayer alloc]initWithCenter:center radius:radius startAngle:originAngle endAngle:angle + originAngle color:colorArray[i] cirType:style == XTPieTypeFullCir ? 0 : 1];
            originAngle = originAngle + angle;
            [self.layer addSublayer:glayer];
        }
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

#pragma mark --图例--
//- (void)calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat)radius{
//    //angle*M_PI/180
//    CGFloat x2 = radius * cos(angle * M_PI / 180);
//    CGFloat y2 = radius * sin(angle * M_PI / 180);
//    CGPoint spotPoint = CGPointMake(center.x+x2, center.y-y2);
//    UIBezierPath *spotPath = [UIBezierPath bezierPathWithArcCenter:spotPoint radius:5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    CAShapeLayer *spotLayer = [CAShapeLayer layer];
//    spotLayer.path = spotPath.CGPath;
//    [self.layer addSublayer:spotLayer];
////    return CGPointMake(center.x+x2, center.y-y2);
//}

- (void)setIsLegend:(bool)isLegend{
    _isLegend = isLegend;
    if (isLegend) {
        [self addSubview:self.legendView];
    }
}

- (UICollectionView *)legendView{
    if (_legendView == nil) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((self.frame.size.width + 60) / 3, 45);
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0;
        _legendView = [[UICollectionView alloc]initWithFrame:CGRectMake(0 - 30, self.frame.size.height + 80, self.frame.size.width + 60, 100) collectionViewLayout:flowlayout];
        _legendView.delegate = self;
        _legendView.dataSource = self;
        _legendView.backgroundColor = [UIColor whiteColor];
        [_legendView registerClass:[LegendCell class] forCellWithReuseIdentifier:LegendCellID];
    }
    return _legendView;
}

#pragma mark --delegate--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LegendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LegendCellID forIndexPath:indexPath];
    cell.backColor = self.colorArray[indexPath.item];
    cell.title = self.percentArray[indexPath.item];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
