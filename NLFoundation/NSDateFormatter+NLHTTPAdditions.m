//
//  NSDateFormatter+NLHTTPAdditions.m
//  TheScore
//
//  Created by Remy Demarest on 05/10/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSDateFormatter+NLHTTPAdditions.h"

@interface NSDateFormatter (NLHTTPAdditions_private)
+ (id)dateFormatterForHTTPDateField;
+ (id)legacyDateFormatterForHTTPDateField;
@end

@implementation NSDateFormatter (NLHTTPAdditions_private)
+ (id)dateFormatterForHTTPDateField
{
    static NSDateFormatter *formatter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(formatter == nil)
        {
            formatter = [[self alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
            [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
        }
    });
    
    return formatter;
}

+ (id)legacyDateFormatterForHTTPDateField
{
    static NSDateFormatter *formatter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(formatter == nil)
        {
            formatter = [[self alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
            [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
        }
    });
    
    return formatter;
}
@end

@implementation NSDateFormatter (NLHTTPAdditions)

+ (NSDate *)dateForHTTPDateField:(NSString *)string
{
    // NSDateFormatter is not thread-safe, so perform these requests synchronously
    
    static dispatch_queue_t formatterQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterQueue = dispatch_queue_create("formatter queue", NULL);
    });
    
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForHTTPDateField];
    NSDateFormatter *legacyDateFormatter = [NSDateFormatter legacyDateFormatterForHTTPDateField];
    
   __block NSDate *date = nil;
    dispatch_sync(formatterQueue, ^{
        date = [dateFormatter dateFromString:string];
        if (!date)
        {
            date = [legacyDateFormatter dateFromString:string];
        }
    });
    return date;
}

@end
