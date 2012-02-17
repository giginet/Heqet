//
//  KWStateManager.m
//  KawazBuster
//
//  Created by  on 11/06/23.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWStateManager.h"

@interface KWStateManager()

@end

@implementation KWStateManager
@synthesize runningState = runningState_;

- (id)init{
  self = [super init];
  if (self) {
    runningState_ = nil;
    stateStack_ = [[NSMutableArray alloc] init];
  }
  return self;
}

- (id)initWithInitialState:(KWState *)state{
  self = [self initWithInitialState:state andArgs:[NSDictionary dictionary]];
  return self;
}

- (id)initWithInitialState:(KWState *)state andArgs:(NSDictionary *)userData{
  self = [self init];
  if(self){
    runningState_ = state;
    [stateStack_ addObject:state];
    [state setUp:userData];
  }
  return self;
}

- (void)pushState:(KWState *)state{
  [self pushState:state andArgs:[NSDictionary dictionary]];
}

- (void)pushState:(KWState *)state andArgs:(NSDictionary *)userData{
  runningState_ = state;
  [stateStack_ addObject:state];
  [state setUp:userData];
}

- (void)replaceState:(KWState *)state{
  [self replaceState:state andArgs:[NSDictionary dictionary]];
}

- (void)replaceState:(KWState *)state andArgs:(NSDictionary *)userData{
  [self.runningState tearDown];
  runningState_ = state;
  [stateStack_ removeLastObject];
  [stateStack_ addObject:state];
  [runningState_ setUp:userData];
}

- (void)popState{
  [self.runningState tearDown];
  [stateStack_ removeLastObject];
  runningState_ = [stateStack_ lastObject];
}

@end