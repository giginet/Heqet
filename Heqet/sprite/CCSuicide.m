//
//  CCSuicide.m
//  Spring
//
//  Created by  on 2012/7/6.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCSuicide.h"

@implementation CCSuicide

+ (id)action {
  return [[self class] actionWithCleanUp:YES];
}

+ (id)actionWithCleanUp:(BOOL)cleanup {
  return [CCCallBlockN actionWithBlock:^(CCNode* node) {
    [node.parent removeChild:node cleanup:cleanup];
  }];
}


@end
