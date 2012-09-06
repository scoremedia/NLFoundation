//
//  NSMutableArray+NLQueueAdditions.h
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 Psycho Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NLQueueAdditions)

/**
 Returns the first object of the receiver or nil if the array is empty.
 */
- (id)firstObject;

/**
 Returns the first object of the receiver and removes it from the receiver.
 */
- (id)dequeueObject;

@end
