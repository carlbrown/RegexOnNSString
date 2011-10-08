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

- (void)testGroupExtract
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    NSArray *matches = [originalString 
                        stringsByExtractingGroupsUsingRegexPattern:@"^Unit *(t[a-z][a-z]*) [^y]*([a-z]*)"
                        caseInsensitive:NO treatAsOneLine:NO];
    STAssertEquals([matches count], (uint) 2, @"Should be 2 strings since there are 2 sets of parens");
    NSString *firstMatch=[matches objectAtIndex:0];
    NSString *secondMatch=[matches objectAtIndex:1];
    
    STAssertEqualObjects(firstMatch, @"tests", @"Regex extract via parenthesis failed");
    STAssertEqualObjects(secondMatch, @"yet", @"Regex extract via parenthesis failed");
    
}

- (void)testNestedGroupExtract
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    NSArray *matches = [originalString 
                        stringsByExtractingGroupsUsingRegexPattern:@"^Unit *(t[a-z][a-z]*) [^y]*(imp[^y]*([a-z]*))"
                        caseInsensitive:NO treatAsOneLine:NO];
    STAssertEquals([matches count], (uint) 3, @"Should be 3 strings since there are 3 sets of parens");
    NSString *firstMatch=[matches objectAtIndex:0];
    NSString *secondMatch=[matches objectAtIndex:1];
    NSString *thirdMatch=[matches objectAtIndex:2];
    
    STAssertEqualObjects(firstMatch, @"tests", @"Regex extract via parenthesis failed");
    STAssertEqualObjects(secondMatch, @"implemented yet", @"Regex extract via parenthesis failed");
    STAssertEqualObjects(thirdMatch, @"yet", @"Regex extract via parenthesis failed");
    
}

- (void)testMatchBooleanTrue
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    
    STAssertTrue([originalString matchesPatternRegexPattern:@"imp[^t][^t]*Ted" caseInsensitive:YES treatAsOneLine:NO], @"That should have matched");
}

- (void)testMatchBooleanFalse
{
    
    NSString *originalString = @"Unit tests are not implemented yet in RegexOnNSStringIOSExampleTests";
    
    STAssertFalse([originalString matchesPatternRegexPattern:@"imp[^t][^t]*Ted" caseInsensitive:NO treatAsOneLine:NO], @"That should not have matched");
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
