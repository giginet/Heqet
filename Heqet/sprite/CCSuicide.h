//
//  CCSuicide.h
//  Spring
//
//  Created by  on 2012/7/6.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCActionInstant.h"

@interface CCSuicide : CCCallBlockN

+ (id)actionWithCleanUp:(BOOL)cleanup;

@end
