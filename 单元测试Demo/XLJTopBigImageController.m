//
//  XLJTopBigImageController.m
//  单元测试Demo
//
//  Created by m on 2017/1/17.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJTopBigImageController.h"
#import "XLJChildTopController.h"

@interface XLJTopBigImageController ()

@end

@implementation XLJTopBigImageController
- (IBAction)itemAction:(id)sender {
    XLJChildTopController *vc = [XLJChildTopController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示动画
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Item2";
}
@end
