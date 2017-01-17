//
//  XLJGifTableCell.m
//  单元测试Demo
//
//  Created by m on 2017/1/16.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJGifTableCell.h"
#import <YYWebImage.h>

@implementation XLJGifTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //使用KVC来修改imageView的属性
        [self setValue:[[YYAnimatedImageView alloc] init] forKey:@"imageView"];
        //1.栅格化，美工术语:将cell中的所有内容，生成一张独立的图像，在屏幕滚动时，只显示图像
        self.layer.shouldRasterize = YES;
        //1.1 栅格化，必须指定分辨率，否则默认使用*1,生成图像
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        //2. 异步绘制:如果cell比较复杂,可以使用
        self.layer.drawsAsynchronously = YES;
    }
    
    return self;
}
@end
