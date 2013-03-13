//
//  KWRandom.h
//  Heqet
//
//  Created by  on 2012/1/17.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "tinymt32.h"

#import <Foundation/Foundation.h>

@interface KWRandom : NSObject {
  uint32_t seed_;
  tinymt32_t state_;
}

@property(readonly) uint32_t seed;
@property(readwrite) tinymt32_t state;

+ (id)defaultRandom;
+ (id)random;
+ (id)randomWithSeed:(uint32_t)seed;
+ (id)randomWithState:(tinymt32_t)state;

- (id)initWithSeed:(uint32_t)seed;
- (id)initWithState:(tinymt32_t)state;

- (int)nextInt;
- (int)nextIntWithRange:(NSRange)range;
- (int)nextIntFrom:(int)from to:(int)to;
- (float)nextFloat;
- (double)nextDouble;

@end
