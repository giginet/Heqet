//
//  KWSingleton.m
//  Heqet
//
//  Created by giginet on 11/03/05.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWSingleton.h"


@implementation KWSingleton

+ (id)shared {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[[self class] alloc] init];
  });
  return sharedInstance;
}

@end
