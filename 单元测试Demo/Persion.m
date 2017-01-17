//
//  Persion.m
//  单元测试Demo
//
//  Created by m on 2017/1/15.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "Persion.h"

@implementation Persion

+ (instancetype)personWithDict:(NSDictionary *)dict
{
    //使用self是为了方便子类来继承
//    id obj = [[self alloc] init];
    Persion * obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    if (obj.age <= 0 && obj.age >= 130) {
        obj.age = 0;
    }
    return obj;
}

+ (void)loadPersonAsync:(void (^)(Persion *))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1.0];
        
        Persion *person = [Persion personWithDict:@{@"name":@"marlonxlj",@"age":@29}];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(person);
            }
        });
    });
}

//空方法，使用其不会崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
