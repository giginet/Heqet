//
//  KWRandom.m
//  Heqet
//
//  Created by  on 2012/1/17.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWRandom.h"
#import "time.h"

@implementation KWRandom
@synthesize seed = seed_;
@synthesize state = state_;

+ (id)random {
  return [[[self class] alloc] init];
}

+ (id)randomWithSeed:(uint32_t)seed {
  return [[[self class] alloc] initWithSeed:seed];
}

+ (id)randomWithState:(tinymt32_t)state {
  return [[[self class] alloc] initWithState:state];
}

- (id)init {
  uint32_t s = (u_int32_t)time(NULL);
  self = [self initWithSeed:s];
  return self;
}

- (id)initWithSeed:(uint32_t)seed {
  self = [super init];
  if (self) {
    seed_ = seed;
    tinymt32_init(&state_, seed_);
  }
  return self;
}

- (id)initWithState:(tinymt32_t)state {
  self = [super init];
  if (self) {
    seed_ = -1;
    state_ = state;
  }
  return self;
}

- (int)nextInt {
  return (int)tinymt32_generate_uint32(&state_);
}

- (int)nextIntWithRange:(NSRange)range {
  return range.location + [self nextInt] % range.length;
}

- (int)nextIntFrom:(int)from to:(int)to {
  return [self nextIntWithRange:NSMakeRange(from, to - from + 1)];
}

- (float)nextFloat {
  return tinymt32_generate_float(&state_);
}

- (double)nextDouble {
  return tinymt32_generate_32double(&state_);
}

@end
