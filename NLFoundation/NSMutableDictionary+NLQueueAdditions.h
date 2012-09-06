//
//  NLQueueAdditions.h
//  NuLayer-Utilities
//
//  Created by Remy Demarest on 27/04/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NLQueueAdditions)

/**
 Adds objects to the array for aKey.
 */
- (void)enqueueObjectsFromArray:(NSArray *)objects forKey:(id)aKey;

/**
 Adds anObject to the given key-array pair of the dictionary.
 */
- (void)enqueueObject:(id)anObject forKey:(id)aKey;

/**
 Returns the first object in the array at the given aKey and removes it from the receiver.
 */
- (id)dequeueObjectForKey:(id)aKey;

/**
 Removes the object from the array at aKey.
 */
- (void)removeObject:(id)anObject forKey:(id)aKey;

@end
