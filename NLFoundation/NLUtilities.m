//
//  NLUtilities.m
//  NuLayer-Utilities
//
//  Created by Remy Demarest on 13/09/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import "NLUtilities.h"

CFTypeRef _NLCFAutorelease(CFTypeRef obj)
{
    return (CFTypeRef)[(id)obj autorelease];
}
