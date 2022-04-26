//
//  LoggerKitTests.m
//  NGLoggerKitTests
//
//  Created by Fournier, Olivier on 2021-01-18.
//  Copyright © 2021 Nuglif. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NGLoggerKit/LoggerMacros.h>
#import <NGLoggerKit/NGLoggerKit-Swift.h>
#import "NGLoggerKitTests-Swift.h"

@interface LoggerKitTests: XCTestCase
@end

@implementation LoggerKitTests

- (void)testObjcMacros {
    [ObjcBridge setupDefault];

    NSString *category = @"test_category";

    LOG_INFO(category, @"info");
    LOG_ERROR(category, @"error");
    LOG_WARNING(category, @"warning");
}

@end
