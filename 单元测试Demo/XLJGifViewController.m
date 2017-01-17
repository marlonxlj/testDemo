//
//  XLJGifViewController.m
//  单元测试Demo
//
//  Created by m on 2017/1/16.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJGifViewController.h"
#import "XLJGifTableCell.h"
#import <YYWebImage.h>

#define GifURL @"http://imglf0.ph.126.net/WAAJPGdYwngSJ5_0nq6YAA==/6608699301143989092.fig"
NSString *const cellIdentifiers = @"cellIdentifiers";

@interface XLJGifViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation XLJGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTableView];
}

- (void)prepareTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[XLJGifTableCell class] forCellReuseIdentifier:cellIdentifiers];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiers forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:GifURL];
    UIImage *image = [UIImage imageNamed:@"avatar_vgirl"];
    [cell.imageView yy_setImageWithURL:url placeholder:image];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.hidesBottomBarWhenPushed = YES;
        
        //如果不设置背景色，拖拽手势返回的时候，右上角会有黑色
        self.navigationController.view.backgroundColor = [UIColor whiteColor];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
