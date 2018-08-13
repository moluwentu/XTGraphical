//
//  ViewController.m
//  XTGraphical
//
//  Created by 叶慧伟 on 2016/12/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "ViewController.h"
#import "XTCirView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XTCirView *cirView = [[XTCirView alloc]initWithCenter:self.view.center radius:100 colorArray:@[[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor orangeColor], [UIColor purpleColor]] AngleArray:@[@"14",@"23",@"66",@"40",@"33"] cirStyle:XTCirFullStyle isAnimation:YES];
    cirView.isLegend = YES;
//      XTCirView *cirView = [[XTCirView alloc]initWithFrame:CGRectMake(100, 100, 100, 100) colorArray:@[[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor orangeColor], [UIColor purpleColor]] angleArray:@[@"14",@"23",@"66",@"40",@"33"] cirStyle:XTCirFullStyle isAnimation:YES];

    [self.view addSubview:cirView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
