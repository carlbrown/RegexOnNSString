//
//  RegexOnNSStringIOSExampleTests.m
//  RegexOnNSStringIOSExampleTests
//
//  Created by Carl Brown on 10/3/11.
//  Copyright 2011 PDAgent, LLC. Released under MIT License.
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

- (void)testMultiLineReplace
{
    
    NSString *originalString = @"Unit tests are not \nimplemented\n yet in RegexOnNSStringIOSExampleTests";
    NSString *newString = [originalString stringByReplacingRegexPattern:@" not.*yet " withString:@" implemented " caseInsensitive:NO treatAsOneLine:YES];
    
    STAssertEqualObjects(newString, @"Unit tests are implemented in RegexOnNSStringIOSExampleTests", @"Regex replace failed");
    
}



- (void) testPerformance
{
    NSString *lastTimeString=nil;
    CFAbsoluteTime startRegexLoop = CFAbsoluteTimeGetCurrent();
    for (uint i=0; i< 1000; i++) {
        if (lastTimeString) {
            NSString *currentNumberString=[NSString stringWithFormat:@"%u",i];
            NSString *replacementString=[lastTimeString stringByReplacingRegexPattern:@"[0-9][0-9]*" withString:currentNumberString caseInsensitive:NO];
            STAssertEqualObjects(replacementString, currentNumberString, @"regex replace failed");
        }
        lastTimeString=[NSString stringWithFormat:@"%u",i];
        i++;
    }
    CFAbsoluteTime endRegexLoop = CFAbsoluteTimeGetCurrent();
    NSLog(@"1000 regex replaces took %lf seconds",(endRegexLoop-startRegexLoop));
    CFAbsoluteTime startCreateStringLoop = CFAbsoluteTimeGetCurrent();
    for (uint i=0; i< 1000; i++) {
        if (lastTimeString) {
            NSString *currentNumberString=[NSString stringWithFormat:@"%u",i];
            NSString *replacementString=[lastTimeString stringByReplacingOccurrencesOfString:lastTimeString withString:currentNumberString];
            STAssertEqualObjects(replacementString, currentNumberString, @"string replace failed");
        }
        lastTimeString=[NSString stringWithFormat:@"%u",i];
        i++;
    }
    CFAbsoluteTime endCreateStringLoop = CFAbsoluteTimeGetCurrent();
    NSLog(@"1000 String replaces took %lf seconds",(endCreateStringLoop-startCreateStringLoop));
    NSLog(@"Simple String substitution %f times faster",((endRegexLoop-startRegexLoop)/(endCreateStringLoop-startCreateStringLoop)));
    STAssertTrue((((endRegexLoop-startRegexLoop)/(endCreateStringLoop-startCreateStringLoop)) < 15), @"Regex took way too much longer");
}


@end
