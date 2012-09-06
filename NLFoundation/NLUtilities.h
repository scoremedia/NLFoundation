//
//  NLUtilities.h
//  NuLayer-Utilities
//
//  Created by Remy Demarest on 13/09/2010.
//  Copyright 2010 NuLayer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)

#define RELEASE(obj) do { obj = nil; } while(NO)
#define AUTORELEASE(var) ({ __autoreleasing __typeof__(var) __ret = var; var = nil; __ret; })

static inline const char *BOOL_STR(BOOL v) { return (v ? "YES" : "NO"); }
static inline id BOOL_OBJ(BOOL v) { return (__bridge id)(v ? kCFBooleanTrue : kCFBooleanFalse); }

#else

#define RELEASE(obj) do { __typeof__(obj) __obj = obj; obj = nil; [__obj release]; } while(NO)
#define AUTORELEASE(var) ({ id __ret = [var autorelease]; var = nil; __ret; })

static inline const char *BOOL_STR(BOOL v) { return (v ? "YES" : "NO"); }
static inline id BOOL_OBJ(BOOL v) { return (id)(v ? kCFBooleanTrue : kCFBooleanFalse); }

#endif

CFTypeRef _NLCFAutorelease(CFTypeRef obj);
#define NLCFAutorelease(var) ((__typeof__(var))_NLCFAutorelease(var))
