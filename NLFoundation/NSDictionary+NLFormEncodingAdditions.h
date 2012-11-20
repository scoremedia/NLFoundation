//
//  NSDictionary+NLFormEncodingAdditions.h
//  NuLayer-Foundation-Utilities
//
//  Created by William Hua on 2012-09-20.
//  Copyright (c) 2012 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLFormEncoding : NSObject

@property(nonatomic, readonly) NSString *contentType;
@property(nonatomic, readonly) NSString *filename;
@property(nonatomic, readonly) NSData   *body;

+ (id)newEncodingForBody:(NSData *)data;
+ (id)newEncodingForBody:(NSData *)data contentType:(NSString *)type;
+ (id)newEncodingForBody:(NSData *)data contentType:(NSString *)type filename:(NSString *)name;

- (id)initWithBody:(NSData *)data;
- (id)initWithBody:(NSData *)data contentType:(NSString *)type;
- (id)initWithBody:(NSData *)data contentType:(NSString *)type filename:(NSString *)name;

@end

@interface NSDictionary (NLFormEncodingAdditions)

- (BOOL)requiresMultipartEncoding;

- (NLFormEncoding *)multipartEncoding;

@end
