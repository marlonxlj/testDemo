//
//  PersionTests.m
//  单元测试Demo
//
//  Created by m on 2017/1/15.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Persion.h"
/** NSAssert */
#if !defined(_NSAssertBody)
#define NSAssert(condition, desc, ...)    \
do {                \
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {        \
NSString *__assert_file__ = [NSString stringWithUTF8String:__FILE__]; \
__assert_file__ = __assert_file__ ? __assert_file__ : @"<Unknown File>"; \
[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
object:self file:__assert_file__ \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}                \
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)
#endif
@interface PersionTests : XCTestCase

@end

@implementation PersionTests
/**
 * 1.单元测试是以代码测试代码
 * 2.红灯/绿灯迭代开发
 * 3.在日常开发中，必要避免边界数据出现程序闪退
 * 4.自己建立测试用例
 * 5.单元测试中不用NSLog来测试，使用`断言`来测试
 * 扩展：单元测试的缺点:代码覆盖度不好确认
 * 提示:
 * 1.不是所有的方法都需要测试
 * 比如:私有方法不需要测试，只有暴露在.h中的方法需要测试,面向对象有一个原则，开闭原则
 * 2.所有跟UI相关的都不需要测试，也不好测试
 * MVVM:把小的业务逻辑封装出来，变成可以测试的代码;给控制器减负,在控制器里面不好写单元测试
 * 3.一般而言，代码的覆盖度在50~70%
 */
//一次单元测试开始前的准备工作，可以设置全局变量
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
//一次单元测试结束前的销毁工作
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//测试新建的Persion模型
- (void)testNewPersion{
    [self checkPersionWithDict:@{@"name":@"marlonxlj",@"age":@28}];
    [self checkPersionWithDict:@{@"name":@"marlonxlj"}];
    [self checkPersionWithDict:@{}];
    [self checkPersionWithDict:@{@"name":@"marlonxlj",@"age":@20,@"title":@"boss"}];
    [self checkPersionWithDict:@{@"name":@"marlonxlj",@"age":@200,@"title":@"boss"}];
    [self checkPersionWithDict:@{@"name":@"marlonxlj",@"age":@-1,@"title":@"boss"}];
    
}
//测试根据字典检查新建的Persion信息
- (void)checkPersionWithDict:(NSDictionary *)dict{
    Persion *persion = [Persion personWithDict:dict];
    
//    NSLog(@"%@", persion);
    
    NSString *name = dict[@"name"];
    NSInteger age = [dict[@"age"] integerValue];
    NSAssert([name isEqualToString:persion.name] || persion.name == nil,@"姓名不一致");
    
    if (persion.age > 0 && persion.age < 130) {
        NSAssert(age == persion.age, @"年龄不一致");
    }else{
//        NSAssert(age == 0, @"年龄超限");
    }
    
    
}
//测试异步加载person
//苹果的单元测试是串行的
/**
 setUp
    testXXX1
    testXXX2
    testXXX3
 tearDown
 中间不会等待异步的回调完成
 */
- (void)testLoadAsyncPerson{
    //Xcode6.0 开始解决,Expectation预期
    XCTestExpectation *expection = [self expectationWithDescription:@"异步加载Person"];
    [Persion loadPersonAsync:^(Persion *person) {
        NSLog(@"%@", person.name);
        
        //标注预期达成
        [expection fulfill];
    }];
    
    //等待10s预期的达成
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
//
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//性能测试
/**
 1.相同的代码重复执行10次，统计计算时间，平均时间
 
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        //将需要测量执行时间的代码放在此处
        
        NSTimeInterval start = CACurrentMediaTime();
        
        for (int i = 0; i < 10000; i++) {
            [Persion personWithDict:@{@"name":@"marlonxlj",@"age":@28}];
        }
        
        NSLog(@"%f", CACurrentMediaTime() - start);
    }];
}

@end
