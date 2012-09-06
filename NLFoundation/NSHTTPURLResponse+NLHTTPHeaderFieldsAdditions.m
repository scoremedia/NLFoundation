//
//  NSHTTPURLResponse+NLHTTPHeaderFieldsAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSHTTPURLResponse+NLHTTPHeaderFieldsAdditions.h"
#import "NSObject+NLKVCAdditions.h"
#import "NSDateFormatter+NLHTTPAdditions.h"
#import "NSString+NLURLQueryStringAdditions.h"

@implementation NSHTTPURLResponse (NLHTTPHeaderFieldsAdditions)

- (NSDate *)lastModifiedDate
{
    return [[self allHeaderFields] dateValueWithHTTPFormatStringForKey:@"Last-Modified" valueIfAbsent:[NSDate distantPast]];
}

- (NSDate *)reloadAfterDate
{
    NSDictionary *parameters = [[[self allHeaderFields] objectForKey:@"Cache-Control"] queryParameters];
    
    return (parameters != nil
            ? [NSDate dateWithTimeIntervalSinceNow:[parameters timeIntervalValueForKey:@"max-age"]]
            : [NSDate distantPast]);
}

- (NSString *)entityTag;
{
    return [[self allHeaderFields] objectForKey:@"Etag"];
}

@end
