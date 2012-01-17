//
//  KWUtility.m
//  Heqet
//
//  Created by  on 1/15/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWUtility.h"

@implementation KWUtility

const NSString* IPAD_DEFAULT_SUFFIX = @"-ipad";

+ (NSString*)fileNameWithiPadSuffix:(NSString *)fileName {
  if ([CCDirector sharedDirector].currentDeviceIsIPad) {
    NSArray* path = [fileName componentsSeparatedByString:@"."];
    NSString* basename = [path objectAtIndex:0];
    NSString* ext = [path lastObject];
    NSString* suffix = [KKConfig stringForKey:@"iPadSuffix"];
    if (!suffix) {
      suffix = (NSString*)IPAD_DEFAULT_SUFFIX;
    }
    NSString* suffixedPath = [NSString stringWithFormat:@"%@%@%@", basename, suffix, ext];
    if (![[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", basename, suffix] ofType:ext] ) {
      return suffixedPath;
    } else {
      CCLOG(@"The file named '%@' is not found.", suffixedPath);
    }
  }
  return fileName;
}

@end
