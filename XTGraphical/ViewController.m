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
//    XTCirView *cirView = [[XTCirView alloc]initWithCenter:CGPointMake(150, 300) radius:100 color:nil cirStyle:1 isAnimation:NO];
    XTCirView *cirView = [[XTCirView alloc]initWithFrame:CGRectMake(100, 200, 100, 100) color:nil cirStyle:XTCirEmptyStyle isAnimation:YES];
    
    [cirView setCirWidth:10];
    [self.view addSubview:cirView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
