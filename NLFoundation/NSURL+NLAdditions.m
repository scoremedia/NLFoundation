//
//  NSURL+NLAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 18/05/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSURL+NLAdditions.h"
#import "NSObject+NLKVCAdditions.h"
#import "NSDateFormatter+NLHTTPAdditions.h"
#import "NSString+NLURLQueryStringAdditions.h"

@implementation NSURL (NLAdditions)

- (NSDictionary *)queryParameters
{
    return [[self query] queryParameters];
}

- (NSString *)pathAndQuery
{
    NSString *abs = [self absoluteString];
    
    NSUInteger beginning = NSNotFound;
    
    if([self path] != nil) beginning = [abs rangeOfString:[self path]].location;
    else if([self query] != nil) beginning = [abs rangeOfString:[self query]].location;
    
    return (beginning != NSNotFound ? [abs substringFromIndex:beginning] : nil);
}

- (NSURL *)URLWithScheme:(NSString *)aScheme
{
    NSString *abs = [self absoluteString];
    NSString *current = [self scheme];
    
    return [[self class] URLWithString:[abs stringByReplacingOccurrencesOfString:current withString:aScheme options:NSLiteralSearch range:NSMakeRange(0, [current length])]];
}

- (NSURL *)URLByAppendingQueryString:(NSString *)query
{
    return [NSURL URLWithString:[[self absoluteString] URLStringByAppendingQueryString:query]];
}

@end
