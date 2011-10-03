//
//  RegexOnNSStringOSXExampleTests.m
//  RegexOnNSStringOSXExampleTests
//
//  Created by Carl Brown on 10/3/11.
//  Copyright 2011 PDAgent, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSString+PDRegex.h"

@interface RegexOnNSStringOSXExampleTests : SenTestCase

@end

@implementation RegexOnNSStringOSXExampleTests

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
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringOSXExampleTests";
    NSString *newString = [originalString stringByreplacingRegexPattern:@" not implemented yet " withString:@" implemented " caseInsensitive:NO];
    
    STAssertEqualObjects(newString, @"Unit tests are implemented in RegexOnNSStringOSXExampleTests", @"Regex replace failed");
    
}
- (void)testWildCardReplace
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringOSXExampleTests";
    NSString *newString = [originalString stringByreplacingRegexPattern:@" not.*yet " withString:@" implemented " caseInsensitive:NO];
    
    STAssertEqualObjects(newString, @"Unit tests are implemented in RegexOnNSStringOSXExampleTests", @"Regex replace failed");
    
}

-(void) testBadRegex
{
    
    STAssertNil([@"test" stringByreplacingRegexPattern:@"[sdf" withString:@"" caseInsensitive:NO], @"Should have returned error since square brackets ([) unmatched");
}

- (void)testCaptureReplace
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringOSXExampleTests";
    NSString *newString = [originalString stringByreplacingRegexPattern:@"^.*(Re.*)Tests.*$" withString:@"$1" caseInsensitive:NO];
    
    STAssertEqualObjects(newString, @"RegexOnNSStringOSXExample", @"Regex replace via parenthesis failed");
    
}

@end
