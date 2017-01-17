//
//  XLJChildTopController.m
//  单元测试Demo
//
//  Created by m on 2017/1/17.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJChildTopController.h"

NSString *const CellID = @"CellID";

@interface XLJChildTopController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XLJChildTopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self SettingTableView];
}

- (void)SettingTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
    [self.view addSubview:tableView];
    
}

#pragma dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}






@end
