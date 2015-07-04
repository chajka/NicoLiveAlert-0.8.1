//
//  NLAUserTest.m
//  NicoLiveAlert
//
//  Created by Чайка on 7/4/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "NLAUser.h"

@interface NLAUserTest : XCTestCase

@end

@implementation NLAUserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
	NLAUser *user = [[NLAUser alloc] initWithAccount:@"chajka.niconico@gmail.com" wathEnabled:YES];
    XCTAssertNotNil(user, @"Test01 allocation fail\"%s\"", __PRETTY_FUNCTION__);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
