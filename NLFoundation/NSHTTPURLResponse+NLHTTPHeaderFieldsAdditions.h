//
//  NSHTTPURLResponse+NLHTTPHeaderFieldsAdditions.h
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPURLResponse (NLHTTPHeaderFieldsAdditions)
- (NSDate *)lastModifiedDate;
- (NSDate *)reloadAfterDate;
- (NSString *)entityTag;
@end
