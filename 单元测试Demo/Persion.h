//
//  Persion.h
//  单元测试Demo
//
//  Created by m on 2017/1/15.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Persion : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithDict:(NSDictionary *)dict;
//异步加载个人信息
+ (void)loadPersonAsync:(void(^)(Persion *person))completion;
@end
