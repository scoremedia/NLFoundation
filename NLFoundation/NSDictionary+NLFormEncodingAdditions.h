//
//  NSDictionary+NLFormEncodingAdditions.h
//  NuLayer-Foundation-Utilities
//
//  Created by William Hua on 2012-09-20.
//  Copyright (c) 2012 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLMultipartEncoding : NSObject

@property(nonatomic, readonly) NSString *contentType;
@property(nonatomic, readonly) NSData   *body;

+ (id)encodingForBody:(NSData *)data;
+ (id)encodingForBody:(NSData *)data contentType:(NSString *)type;

- (id)initWithBody:(NSData *)data;
- (id)initWithBody:(NSData *)data contentType:(NSString *)type;

@end

@interface NSDictionary (NLFormEncodingAdditions)

- (NLMultipartEncoding *)multipartEncoding;

@end
