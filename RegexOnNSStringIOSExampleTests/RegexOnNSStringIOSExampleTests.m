//
//  RegexOnNSStringIOSExampleTests.m
//  RegexOnNSStringIOSExampleTests
//
//  Created by Carl Brown on 10/3/11.
//  Copyright 2011 PDAgent, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSString+PDRegex.h"

@interface RegexOnNSStringIOSExampleTests : SenTestCase

@end

@implementation RegexOnNSStringIOSExampleTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testLiteralReplace
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    NSString *newString = [originalString stringByReplacingRegexPattern:@" not implemented yet " withString:@" implemented " caseInsensitive:NO];
    
    STAssertEqualObjects(newString, @"Unit tests are implemented in RegexOnNSStringIOSExampleTests", @"Regex replace failed");
    
}
- (void)testWildCardReplace
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    NSString *newString = [originalString stringByReplacingRegexPattern:@" not.*yet " withString:@" implemented " caseInsensitive:NO];
    
    STAssertEqualObjects(newString, @"Unit tests are implemented in RegexOnNSStringIOSExampleTests", @"Regex replace failed");
    
}

-(void) testBadRegex
{
    
    STAssertNil([@"test" stringByReplacingRegexPattern:@"[sdf" withString:@"" caseInsensitive:NO], @"Should have returned error since square brackets ([) unmatched");
}

- (void)testCaptureReplace
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    NSString *newString = [originalString stringByReplacingRegexPattern:@"^.*(Re.*)Tests.*$" withString:@"$1" caseInsensitive:NO];
    
    STAssertEqualObjects(newString, @"RegexOnNSStringIOSExample", @"Regex replace via parenthesis failed");
    
}

@end
