//
//  NSMutableArray+NLQueueAdditions.m
//  NuLayer-Foundation-Utilities
//
//  Created by Remy Demarest on 08/11/2010.
//  Copyright 2010 Psycho Inc. All rights reserved.
//

#import "NSMutableArray+NLQueueAdditions.h"

@implementation NSMutableArray (NLQueueAdditions)

- (id)firstObject;
{
    id ret = nil;
    if([self count] > 0) ret = [self objectAtIndex:0];
    return ret;
}

- (id)dequeueObject
{
    id ret = [self firstObject];
    if([self count] > 0) [self removeObjectAtIndex:0];
    return ret;
}

@end
