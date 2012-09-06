//
//  NSObject+Additions.h
//  NuLayer-Utilities
//
//  Created by Remy Demarest on 08/05/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NLKVCAdditions)
- (id)nonNullValueForKey:(NSString *)aKey; // Returns nil if the recovered value is NSNull
- (id)nonNullValueForKey:(NSString *)aKey valueIfAbsent:(id)value;

// Type-checked object
- (id)valueForKey:(NSString *)key ofType:(Class)valueType;
- (id)valueForKey:(NSString *)key ofType:(Class)valueType valueIfAbsent:(id)value;

- (NSString *)stringValueForKey:(NSString *)aKey;
- (NSString *)stringValueForKey:(NSString *)aKey valueIfAbsent:(NSString *)value;

- (NSURL *)URLValueForKey:(NSString *)aKey;
- (NSURL *)URLValueForKey:(NSString *)aKey valueIfAbsent:(NSURL *)value;

- (NSArray *)arrayValueForKey:(NSString *)aKey;
- (NSArray *)arrayValueForKey:(NSString *)aKey valueIfAbsent:(NSArray *)value;

- (NSDictionary *)dictionaryValueForKey:(NSString *)aKey;
- (NSDictionary *)dictionaryValueForKey:(NSString *)aKey valueIfAbsent:(NSDictionary *)value;

- (NSInteger)integerValueForKey:(NSString *)aKey;
- (NSInteger)integerValueForKey:(NSString *)aKey valueIfAbsent:(NSInteger)defaultValue;

- (double)doubleValueForKey:(NSString *)aKey;
- (double)doubleValueForKey:(NSString *)aKey valueIfAbsent:(double)defaultValue;

- (NSTimeInterval)timeIntervalValueForKey:(NSString *)aKey;
- (NSTimeInterval)timeIntervalValueForKey:(NSString *)aKey valueIfAbsent:(NSTimeInterval)defaultValue;

- (NSDate *)dateValueWithHTTPFormatStringForKey:(NSString *)aKey;
- (NSDate *)dateValueWithHTTPFormatStringForKey:(NSString *)aKey valueIfAbsent:(NSDate *)defaultValue;

@end
