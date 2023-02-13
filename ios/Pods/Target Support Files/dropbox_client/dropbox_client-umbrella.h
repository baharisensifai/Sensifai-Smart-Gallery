#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DropboxPlugin.h"

FOUNDATION_EXPORT double dropbox_clientVersionNumber;
FOUNDATION_EXPORT const unsigned char dropbox_clientVersionString[];

