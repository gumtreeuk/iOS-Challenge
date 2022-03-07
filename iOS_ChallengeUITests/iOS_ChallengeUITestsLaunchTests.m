//
//  iOS_ChallengeUITestsLaunchTests.m
//  iOS_ChallengeUITests
//
//  Created by Shah, Hamdullah(eCG) on 07/03/2022.
//

#import <XCTest/XCTest.h>

@interface iOS_ChallengeUITestsLaunchTests : XCTestCase

@end

@implementation iOS_ChallengeUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
