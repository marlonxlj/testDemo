//
//  ViewControllerTests.m
//  单元测试Demo
//
//  Created by m on 2017/1/16.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ViewControllerTests : XCTestCase

@end

@implementation ViewControllerTests
//Xcode 7.0 之前的测试使用instrument通过写js脚本
- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    //使用录制开始编写UI测试
}

@end
