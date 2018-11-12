//
//  ObjcLoggerViewController.m
//  LoggerKit_Sample
//
//  Created by Werck, Ayrton on 18-07-10.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

#import "ObjcLoggerViewController.h"
#import "LoggerKit_Sample-Swift.h"
@import CocoaLumberjack;
@import LoggerKit;

@interface ObjcLoggerViewController ()

@end

@implementation ObjcLoggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LOG_ERROR(SampleObjcCategory.VIDEO, @"Oops !");
}

@end
