//
//  NSDateFormatter+NLHTTPAdditions.m
//  TheScore
//
//  Created by Remy Demarest on 05/10/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSDateFormatter+NLHTTPAdditions.h"


@implementation NSDateFormatter (NLHTTPAdditions)

+ (id)dateFormatterForHTTPDateField;
{
    static NSDateFormatter *formatter = nil;
    
    if(formatter == nil)
    {
        formatter = [[self alloc] init];
        [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
    }
    
    return formatter;
}

@end
