//
//  NSDictionary+NLFormEncodingAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by William Hua on 2012-09-20.
//  Copyright (c) 2012 NuLayer Inc. All rights reserved.
//

#import "NSDictionary+NLFormEncodingAdditions.h"

@implementation NLMultipartEncoding

@synthesize contentType, body;

+ (id)encodingForBody:(NSData *)data
{
    return [[self alloc] initWithBody:data];
}

+ (id)encodingForBody:(NSData *)data contentType:(NSString *)type
{
    return [[self alloc] initWithBody:data contentType:type];
}

- (id)initWithBody:(NSData *)data
{
    return [self initWithBody:data contentType:nil];
}

- (id)initWithBody:(NSData *)data contentType:(NSString *)type
{
    if((self = [super init]))
    {
        contentType = [type copy];
        body        = [data copy];
    }
    
    return self;
}

@end

@implementation NSDictionary (NLFormEncodingAdditions)

- (NLMultipartEncoding *)multipartEncoding
{
    NSMutableArray *parts = [NSMutableArray arrayWithCapacity:[self count]];
    
    for(NSString *key in self)
    {
        id object = [self objectForKey:key];
        
        if([object isKindOfClass:[NSDictionary class]])
            object = [object multipartEncoding];
        
        if([object isKindOfClass:[NLMultipartEncoding class]] && [object contentType] == nil)
            object = [object body];
        
        if([object isKindOfClass:[NLMultipartEncoding class]])
        {
            NSMutableData *data = [NSMutableData data];
            
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\nContent-Type: %@\r\n\r\n", key, [object contentType]] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[object body]];
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [parts addObject:data];
        }
        else if([object isKindOfClass:[NSData class]])
        {
            NSMutableData *data = [NSMutableData data];
            
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:object];
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [parts addObject:data];
        }
        else
            [parts addObject:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key, [object description]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *boundary     = [self NL_randomBoundaryForParts:parts];
    NSData   *boundaryData = [[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *encoding = [NSMutableData data];
    
    for(NSData *part in parts)
    {
        [encoding appendData:boundaryData];
        [encoding appendData:part];
    }
    
    [encoding appendData:boundaryData];
    [encoding appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [NLMultipartEncoding encodingForBody:encoding contentType:[@"multipart/form-data; boundary=" stringByAppendingString:boundary]];
}

- (NSString *)NL_randomBoundaryForParts:(NSArray *)parts
{
    NSMutableString *boundary = [NSMutableString string];
    
    BOOL done;
    
    do
    {
        [boundary appendFormat:@"%08x", arc4random()];
        
        NSData *boundaryData = [boundary dataUsingEncoding:NSUTF8StringEncoding];
        
        done = YES;
        
        for(NSData *part in parts)
        {
            if([part rangeOfData:boundaryData options:0 range:NSMakeRange(0, [part length])].location != NSNotFound)
            {
                done = NO;
                
                break;
            }
        }
    }
    while(!done);
    
    return boundary;
}

@end
