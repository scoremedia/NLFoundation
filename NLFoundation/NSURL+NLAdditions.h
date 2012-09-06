//
//  NSURL+NLAdditions.h
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 18/05/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (NLAdditions)

- (NSString *)pathAndQuery;

- (NSURL *)URLWithScheme:(NSString *)aScheme;

- (NSURL *)URLByAppendingQueryString:(NSString *)query;

- (NSDictionary *)queryParameters;

@end
