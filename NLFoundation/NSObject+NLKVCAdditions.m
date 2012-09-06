//
//  NSObject+Additions.m
//  NuLayer-Utilities
//
//  Created by Remy Demarest on 08/05/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSObject+NLKVCAdditions.h"
#import "NSDateFormatter+NLHTTPAdditions.h"

@implementation NSObject (NLKVCAdditions)

- (id)nonNullValueForKey:(NSString *)aKey
{
    return [self nonNullValueForKey:aKey valueIfAbsent:nil];
}

- (id)nonNullValueForKey:(NSString *)aKey valueIfAbsent:(id)value;
{
    id obj = [self valueForKey:aKey];
    
    if(obj == nil || obj == [NSNull null]) obj = value;
    
    return obj;
}

- (id)valueForKey:(NSString *)key ofType:(Class)valueType;
{
    return [self valueForKey:key ofType:valueType valueIfAbsent:nil];
}

- (id)valueForKey:(NSString *)key ofType:(Class)valueType valueIfAbsent:(id)value;
{
    id obj = [self valueForKey:key];
    
    if(![obj isKindOfClass:valueType]) obj = value;
    
    return obj;
}

- (NSString *)stringValueForKey:(NSString *)aKey;
{
    return [self stringValueForKey:aKey valueIfAbsent:nil];
}

- (NSString *)stringValueForKey:(NSString *)aKey valueIfAbsent:(NSString *)value;
{
    return [self valueForKey:aKey ofType:[NSString class] valueIfAbsent:value];
}

- (NSURL *)URLValueForKey:(NSString *)aKey;
{
    return [self URLValueForKey:aKey valueIfAbsent:nil];
}

- (NSURL *)URLValueForKey:(NSString *)aKey valueIfAbsent:(NSURL *)value;
{
    NSString *str = [self stringValueForKey:aKey valueIfAbsent:nil];
    
    NSURL *ret = value;
    
    if(str != nil) ret = [NSURL URLWithString:str];
    
    return ret;
}

- (NSArray *)arrayValueForKey:(NSString *)aKey;
{
    return [self arrayValueForKey:aKey valueIfAbsent:nil];
}

- (NSArray *)arrayValueForKey:(NSString *)aKey valueIfAbsent:(NSArray *)value;
{
    return [self valueForKey:aKey ofType:[NSArray class] valueIfAbsent:value];
}

- (NSDictionary *)dictionaryValueForKey:(NSString *)aKey;
{
    return [self dictionaryValueForKey:aKey valueIfAbsent:nil];
}

- (NSDictionary *)dictionaryValueForKey:(NSString *)aKey valueIfAbsent:(NSDictionary *)value;
{
    return [self valueForKey:aKey ofType:[NSDictionary class] valueIfAbsent:value];
}

- (NSInteger)integerValueForKey:(NSString *)aKey
{
    return [self integerValueForKey:aKey valueIfAbsent:0];
}

- (NSInteger)integerValueForKey:(NSString *)aKey valueIfAbsent:(NSInteger)defaultValue;
{
    id value = [self nonNullValueForKey:aKey];
    
    return ([value respondsToSelector:@selector(integerValue)] ? [value integerValue] : defaultValue);
}

- (double)doubleValueForKey:(NSString *)aKey;
{
    return [self doubleValueForKey:aKey valueIfAbsent:0.0];
}

- (double)doubleValueForKey:(NSString *)aKey valueIfAbsent:(double)defaultValue;
{
    id value = [self nonNullValueForKey:aKey];
    
    return ([value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : defaultValue);
}

- (NSTimeInterval)timeIntervalValueForKey:(NSString *)aKey
{
    return [self timeIntervalValueForKey:aKey valueIfAbsent:0.0];
}

- (NSTimeInterval)timeIntervalValueForKey:(NSString *)aKey valueIfAbsent:(NSTimeInterval)defaultValue;
{
    return [self doubleValueForKey:aKey valueIfAbsent:defaultValue];
}

- (NSDate *)dateValueWithHTTPFormatStringForKey:(NSString *)aKey;
{
    return [self dateValueWithHTTPFormatStringForKey:aKey valueIfAbsent:nil];
}

- (NSDate *)dateValueWithHTTPFormatStringForKey:(NSString *)aKey valueIfAbsent:(NSDate *)defaultValue;
{
    NSDate   *date = defaultValue;
    NSString *str  = [self nonNullValueForKey:aKey];
    
    if([str isKindOfClass:[NSString class]]) date = [[NSDateFormatter dateFormatterForHTTPDateField] dateFromString:str];
    
    return date;
}

@end
