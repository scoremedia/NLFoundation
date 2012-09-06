//
//  NLQueueAdditions.m
//  NuLayer-Utilities
//
//  Created by Remy Demarest on 27/04/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NSMutableDictionary+NLQueueAdditions.h"
#import "NSMutableArray+NLQueueAdditions.h"

@implementation NSMutableDictionary (NLQueueAdditions)

- (void)enqueueObjectsFromArray:(NSArray *)objects forKey:(id)aKey
{
    NSMutableArray *queue = [self objectForKey:aKey];
    if(queue == nil)
    {
        queue = [NSMutableArray arrayWithCapacity:[objects count]];
        [self setObject:queue forKey:aKey];
    }
    
    [queue addObjectsFromArray:objects];
}

- (void)enqueueObject:(id)anObject forKey:(id)aKey
{
    [self enqueueObjectsFromArray:[NSArray arrayWithObject:anObject] forKey:aKey];
}

- (id)dequeueObjectForKey:(id)aKey
{
    return [[self objectForKey:aKey] dequeueObject];
}

- (void)removeObject:(id)anObject forKey:(id)aKey
{
    [[self objectForKey:aKey] removeObject:anObject];
}

@end


