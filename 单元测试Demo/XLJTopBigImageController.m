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

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
@end
