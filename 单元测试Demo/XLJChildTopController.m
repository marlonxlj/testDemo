//
//  XLJChildTopController.m
//  单元测试Demo
//
//  Created by m on 2017/1/17.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJChildTopController.h"
#import "HMObjcSugar.h"
#import <YYWebImage/YYWebImage.h>

#define XLJHeaderHeight 200
#define BigImageUrl @"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"
NSString *const CellID = @"CellID";

@interface XLJChildTopController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_headerImageView;
    UIView *_lineView;
    UIButton *_leftBtn;
    UIStatusBarStyle _statusBarStyle;
}

@end

@implementation XLJChildTopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //1.初始化tableview
    [self SettingTableView];
    
    //2.初始化顶部视图
    [self settingHeadView];
    _statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    //取消自动调整滚动视图间距--viewControll+NAV会自动调整tableview的contentInsert
    self.automaticallyAdjustsScrollViewInsets = NO;
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

//初始化顶部视图
- (void)settingHeadView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.hm_width,XLJHeaderHeight)];
    
    _headerView.backgroundColor = [UIColor hm_colorWithHex:0xf8f8f8];
    
    [self.view addSubview:_headerView];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    //设置contenMode,等比填充
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    //设置图像裁切
    _headerImageView.clipsToBounds = YES;
    
    _headerImageView.backgroundColor = [UIColor hm_colorWithHex:0x000033];
    [_headerView addSubview:_headerImageView];
    
    //添加分割线,一个像素点
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, XLJHeaderHeight - lineHeight, _headerView.hm_width, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];
    
    //设置图像
    [_headerImageView yy_setImageWithURL:[NSURL URLWithString:BigImageUrl] placeholder:nil options:1 completion:nil];
}

//初始化tableView
- (void)SettingTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
    [self.view addSubview:_tableView];
    
    //设置表格的间距
    _tableView.contentInset = UIEdgeInsetsMake(XLJHeaderHeight, 0, 49, 0);
    //滚动指示器
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    if (offset <= 0) {
        //放大图片,调整headView和headImageView
        _headerView.hm_y = 0;
        _headerView.hm_height = XLJHeaderHeight - offset;
        _headerImageView.hm_height = _headerView.hm_height;
        
    }else{
        //整体移动
        _headerView.hm_height = XLJHeaderHeight;
        _headerImageView.hm_height = _headerView.hm_height;
        //headview最的小y值，到这里就不再移动了
        CGFloat min = XLJHeaderHeight - 64;
        _headerView.hm_y = -MIN(min, offset);
        
        //设置透明度
        CGFloat progress = 1 - (offset/min);
        _headerImageView.alpha = progress;
        

        
        if (progress < 0.5) {
            _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(22, min+15, 44, 44)];
            [_leftBtn setTitle:@"返回" forState:UIControlStateNormal];
            [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_headerView addSubview:_leftBtn];
            [_leftBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//            _leftBtn.hidden = NO;
        }
        
        _statusBarStyle = (progress < 0.5) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    }
    
    //设置分割线的位置
    _lineView.hm_y = _headerView.hm_height - _lineView.hm_height;
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    
}

- (void)buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
