//
//  NSDateFormatter+NLHTTPAdditions.h
//  TheScore
//
//  Created by Remy Demarest on 05/10/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDateFormatter (NLHTTPAdditions)
+ (NSDate *)dateForHTTPDateField:(NSString *)string;
@end
