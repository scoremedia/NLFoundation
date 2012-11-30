//
//  NSDictionary+NLFormEncodingAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by William Hua on 2012-09-20.
//  Copyright (c) 2012 NuLayer Inc. All rights reserved.
//

#import "NSDictionary+NLFormEncodingAdditions.h"

@implementation NLFormEncoding

@synthesize contentType, filename, body;

+ (id)newEncodingForBody:(NSData *)data
{
    return [[self alloc] initWithBody:data];
}

+ (id)newEncodingForBody:(NSData *)data contentType:(NSString *)type
{
    return [[self alloc] initWithBody:data contentType:type];
}

+ (id)newEncodingForBody:(NSData *)data contentType:(NSString *)type filename:(NSString *)name
{
    return [[self alloc] initWithBody:data contentType:type filename:name];
}

- (id)initWithBody:(NSData *)data
{
    return [self initWithBody:data contentType:nil];
}

- (id)initWithBody:(NSData *)data contentType:(NSString *)type
{
    return [self initWithBody:data contentType:type filename:nil];
}

- (id)initWithBody:(NSData *)data contentType:(NSString *)type filename:(NSString *)name
{
    if((self = [super init]))
    {
        contentType = [type copy];
        filename    = [name copy];
        body        = [data copy];
    }
    
    return self;
}

@end

@implementation NSDictionary (NLFormEncodingAdditions)

- (BOOL)requiresMultipartEncoding
{
    for(NSString *key in self)
    {
        id object = [self objectForKey:key];
        
        if(([object isKindOfClass:[NSDictionary class]] && [object requiresMultipartEncoding]) || [object isKindOfClass:[NLFormEncoding class]] || [object isKindOfClass:[NSData class]])
            return YES;
    }
    
    return NO;
}

- (NLFormEncoding *)multipartEncoding
{
    NSMutableArray *parts = [NSMutableArray arrayWithCapacity:[self count]];
    
    for(NSString *key in self)
    {
        id object = [self objectForKey:key];
        
        if([object isKindOfClass:[NSDictionary class]])
            object = [object multipartEncoding];
        
        if([object isKindOfClass:[NSData class]])
            object = [[NLFormEncoding newEncodingForBody:object contentType:@"application/octet-stream"] autorelease];
        
        if([object isKindOfClass:[NLFormEncoding class]] && [object contentType] == nil)
            object = [[NLFormEncoding newEncodingForBody:[object body] contentType:@"application/octet-stream" filename:[object filename]] autorelease];
        
        if([object isKindOfClass:[NLFormEncoding class]])
        {
            NSString      *file = [object filename];
            NSMutableData *data = [NSMutableData data];
            
            if(file != nil)
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n", key, [object filename], [object contentType]] dataUsingEncoding:NSUTF8StringEncoding]];
            else
                [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\nContent-Type: %@\r\n\r\n", key, [object contentType]] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [data appendData:[object body]];
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
    
    [encoding appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [[NLFormEncoding newEncodingForBody:encoding contentType:[@"multipart/form-data; boundary=" stringByAppendingString:boundary]] autorelease];
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
