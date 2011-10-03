//
//  NSString+PDRegex.h
//  RegexOnNSString
//
//  Created by Carl Brown on 10/3/11.
//  Copyright 2011 PDAgent, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PDRegex)

-(NSString *) stringByreplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement caseInsensitive:(BOOL) ignoreCase;

@end
