//
//  NSDictionary+NLURLAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSDictionary+NLURLAdditions.h"
#import "NSString+NLURLQueryStringAdditions.h"

@implementation NSDictionary (NLURLAdditions)

static NSString *_NLQueryStringByAddingPercentEscapes(NSString *string)
{
    NSString *escapedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@":/?=,!$&'()*+;[]@#", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return [escapedString autorelease];
}

static NSString *_NLQueryStringFromArrayWithName(NSString *name, NSArray *array)
{
    name = [name stringByAppendingString:@"[]"];
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:[name length] * [array count]];
    
    NSAutoreleasePool *local = [[NSAutoreleasePool alloc] init];
    
    BOOL isFirst = YES;
    
    for(id obj in array)
    {
        if(isFirst) isFirst = NO;
        else [ret appendString:@"&"];
        
        [ret appendString:name];
        
        if(obj != [NSNull null]) [ret appendFormat:@"=%@", _NLQueryStringByAddingPercentEscapes([obj description])];
    }
    
    [local drain];
    
    return [[ret copy] autorelease];
}

static NSString *_NLQueryStringFromDictionaryWithName(NSString *name, NSDictionary *dict)
{
    NSMutableString *ret = [NSMutableString stringWithCapacity:[name length] * [dict count]];
    
    BOOL isFirst = YES;
    
    NSAutoreleasePool *local = [[NSAutoreleasePool alloc] init];
    
    for(NSString *key in dict)
    {
        id obj = [dict objectForKey:key];
        
        if(isFirst) isFirst = NO;
        else [ret appendString:@"&"];
        
        key = _NLQueryStringByAddingPercentEscapes(key);
        NSString *fullKey = [NSString stringWithFormat:@"%@[%@]", name, key];
        
        if([obj isKindOfClass:[NSArray class]])
            [ret appendString:_NLQueryStringFromArrayWithName(fullKey, obj)];
        else if([obj isKindOfClass:[NSDictionary class]])
            [ret appendString:_NLQueryStringFromDictionaryWithName(fullKey, obj)];
        else
        {
            [ret appendString:fullKey];
            
            if([obj isKindOfClass:[NSValue class]] && strcmp([obj objCType], @encode(BOOL)) && strcmp([obj objCType], @encode(_Bool)))
                obj = [obj boolValue] ? @"true" : @"false";
            
            if(obj != [NSNull null]) [ret appendFormat:@"=%@", _NLQueryStringByAddingPercentEscapes([obj description])];
        }
    }
    
    [local drain];
    
    return [[ret copy] autorelease];
}

- (NSString *)queryString
{
    NSAutoreleasePool *local = [[NSAutoreleasePool alloc] init];
    NSMutableString   *temp  = [NSMutableString string];
    
    BOOL isFirst = YES;
    
    for(NSString *key in self)
    {
        if(isFirst) isFirst = NO;
        else [temp appendString:@"&"];
        
        id obj = [self objectForKey:key];
        
        key = _NLQueryStringByAddingPercentEscapes(key);
        
        if([obj isKindOfClass:[NSArray class]])
            [temp appendString:_NLQueryStringFromArrayWithName(key, obj)];
        else if([obj isKindOfClass:[NSDictionary class]])
            [temp appendString:_NLQueryStringFromDictionaryWithName(key, obj)];
        else
        {
            [temp appendString:key];
            
            if(obj != [NSNull null])
            {
                [temp appendString:@"="];
                [temp appendString:_NLQueryStringByAddingPercentEscapes([obj description])];
            }
        }
    }
    
    NSString *ret = [temp copy];
    
    [local drain];
    
    return [ret autorelease];
}

@end
