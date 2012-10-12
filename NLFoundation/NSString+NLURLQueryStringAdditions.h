//
//  NSString+NLURLQueryStringAdditions.h
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NLURLQueryStringAdditions)
// Assumes the first question mark '?' character to be the beginning of the query string
- (NSString *)URLStringByAppendingQueryString:(NSString *)query;

- (NSDictionary *)queryParameters;

- (NSString *)stringByPreparingForURL;
- (NSString *)stringByDecodingFromURL;

@end
