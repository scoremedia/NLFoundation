//
//  NSString+NLURLQueryStringAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSString+NLURLQueryStringAdditions.h"

@implementation NSString (NLURLQueryStringAdditions)

static NSString *_NLQueryParserValueForQueryParameterInArray(NSArray *queryParameter)
{
    NSString *value = (id) [NSNull null];
    
    if([queryParameter count] > 1) value = [[queryParameter objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return value;
}

static void _NLQueryParserGetKeyForField(NSString *field, NSString **fieldKey, NSString **hashKey, BOOL *isMultiple)
{
    NSRange keyRange = [field rangeOfString:@"["];
    
    *fieldKey   = nil;
    *hashKey    = nil;
    *isMultiple = NO;
    
    if(keyRange.location == NSNotFound)
        *fieldKey = [field stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    else
    {
        // If we have a square bracket it's a multiple field
        *isMultiple = YES;
        
        // Get the global key for the field
        *fieldKey = [[field substringToIndex:keyRange.location] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // Find out if it's a hash or an array
        keyRange.location++;
        keyRange.length = [field rangeOfString:@"]"].location - keyRange.location;
        
        // It's an hash, get the key and return it by parameter
        if(keyRange.length > 0) *hashKey = [[field substringWithRange:keyRange] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

static BOOL _NLQueryParserAddValueToArrayForKey(NSMutableDictionary *destination, NSString *key, NSString *value)
{
    NSMutableArray *content = [destination objectForKey:key];
    if(content == nil)
    {
        content = [NSMutableArray arrayWithCapacity:1];
        [destination setObject:content forKey:key];
    }
    else if(![content isKindOfClass:[NSArray class]])
        return NO;
    
    [content addObject:value];
    
    return YES;
}

static BOOL _NLQueryParserAddValueToDictionaryForKey(NSMutableDictionary *destination, NSString *key, NSString *hashKey, NSString *value)
{
    NSMutableDictionary *content = [destination objectForKey:key];
    if(content == nil)
    {
        content = [NSMutableDictionary dictionaryWithCapacity:1];
        [destination setObject:content forKey:key];
    }
    else if([content isKindOfClass:[NSDictionary class]])
        return NO;
    
    [content setObject:value forKey:hashKey];
    
    return YES;
}

static void _NLQueryParserParseParameterIntoDictionary(NSString *self, NSMutableDictionary *destination, NSString *parameter)
{
    __unused SEL _cmd = @selector(queryParameters);
    
    NSArray *fieldValue = [parameter componentsSeparatedByString:@"="];
    
    NSString *value = _NLQueryParserValueForQueryParameterInArray(fieldValue);
    
    BOOL fieldIsMultiple = NO;
    NSString *key = nil, *hashKey = nil;
    
    _NLQueryParserGetKeyForField([fieldValue objectAtIndex:0], &key, &hashKey, &fieldIsMultiple);
    
    if(fieldIsMultiple)
    {
        if(hashKey == nil)
            NSAssert4(_NLQueryParserAddValueToArrayForKey(destination, key, value),
                      @"Malformed URL <%@>, the field \"%@\" previously contained the non-array value <%@> and last string \"%@\" was parsed as an array.", self, key, [destination objectForKey:key], parameter);
        else
            NSAssert4(_NLQueryParserAddValueToDictionaryForKey(destination, key, hashKey, value),
                      @"Malformed URL <%@>, field \"%@\" previously contained the non-hash value <%@> and last string \"%@\" was parsed as an hash.", self, key, [destination objectForKey:key], parameter);
    }
    else [destination setObject:value forKey:key];
}

- (NSDictionary *)queryParameters
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    for(NSString *parameter in [self componentsSeparatedByString:@"&"])
        _NLQueryParserParseParameterIntoDictionary(self, ret, parameter);
    
    return [[[NSDictionary alloc] initWithDictionary:ret copyItems:YES] autorelease];
}

- (NSString *)URLStringByAppendingQueryString:(NSString *)query;
{
    NSString *ret = self;
    
    if(query != nil)
    {
        if([ret rangeOfString:@"?"].location == NSNotFound)
            ret = [ret stringByAppendingString:@"?"];
        else if(![ret hasSuffix:@"&"])
            ret = [ret stringByAppendingString:@"&"];
        ret = [ret stringByAppendingString:query];
    }
    
    return ret;
}

- (NSString *)stringByPreparingForURL {
	NSString *escapedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																				  (CFStringRef)self,
																				  NULL,
																				  (CFStringRef)@":/?=,!$&'()*+;[]@#",
																				  CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
	
	return [escapedString autorelease];
}

@end
