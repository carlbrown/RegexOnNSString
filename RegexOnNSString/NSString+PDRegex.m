//
//  NSString+PDRegex.m
//  RegexOnNSString
//
//  Created by Carl Brown on 10/3/11.
//  Copyright 2011 PDAgent, LLC. All rights reserved.
//

#import "NSString+PDRegex.h"

@implementation NSString (PDRegex)

-(NSString *) stringByreplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement caseInsensitive:(BOOL)ignoreCase {
    
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        NSLog(@"Error creating Regex: %@",[error description]);
        return nil;
    }
    
    NSString *retVal= [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
    return retVal;
}

@end
