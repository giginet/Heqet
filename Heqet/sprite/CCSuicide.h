//
//  CCSuicide.h
//  Spring
//
//  Created by  on 2012/7/6.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCActionInstant.h"

/**
 いつのまにかKobold2DにCCRemoveFromParentというActionが拡張されていたのでそちらを利用しましょう
 */
@interface CCSuicide : CCCallBlockN

+ (id)actionWithCleanUp:(BOOL)cleanup;

@end
