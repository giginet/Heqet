//
//  KWTimer.m
//  Heqet
//
//  Created by giginet on 11/03/04.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWTimer.h"

@interface KWTimer()
- (void)update:(ccTime)dt;
- (void)rotate;
- (void)tick:(ccTime)dt;
- (void)onUpdate:(ccTime)dt;
- (void)onComplete;
@end

@implementation KWTimer
@synthesize active = active_;
@synthesize looping = looping_;
@synthesize now = now_;
@synthesize max = max_;

+ (KWTimer*)timer{
  return [[KWTimer alloc] init];
}

+ (KWTimer*)timerWithMax:(float)max{
  return [[KWTimer alloc] initWithMax:max];
}

- (id)init{
  self = [super init];
  if(self) {
    max_ = 0;
    now_ = 0;
    looping_ = NO;
    active_ = NO;
  }
  return self;
}

- (id)initWithMax:(float)max{
  self = [self init];
  if(self) {
    [self set:max];
  }
  return self;
}

- (id)play{
  active_ = YES;
  [[CCDirector sharedDirector].scheduler scheduleUpdateForTarget:self priority:0 paused:YES];
  return self;
}

- (void)update:(ccTime)dt {
  [self tick:dt];
}

- (id)stop{
  [self pause];
  [self reset];
  return self;
}

- (id)pause{
  active_ = NO;
  [[CCDirector sharedDirector].scheduler unscheduleSelector:@selector(tick:) forTarget:self];
  return self;
}

- (id)reset{
  now_ = max_;
  return self;
}

- (id)move:(int)n{
  if([self isOver]) return self;
  now_ = MIN(max_, now_ - n);
  [self onUpdate:0];
  if([self isOver]){
    [self onComplete];
  }
  return self;
}

- (BOOL)isOver{
  return now_ <= 0;
}

- (id)setOnCompleteListener:(id)listener selector:(SEL)selector {
  completeListener_ = listener;
  completeSelector_ = selector;
  return self;
}

- (id)setOnCompleteListenerWithBlock:(void (^)(id))block {
  completeBlock_ = block;
  return self;
}

- (id)setOnUpdateListener:(id)listener selector:(SEL)selector {
  updateListener_ = listener;
  updateSelector_ = selector;
  return self;
}

- (id)setOnUpdateListenerWithBlock:(void (^)(id, ccTime))block {
  updateBlock_ = block;
  return self;
}

- (ccTime)max{
  return max_;
}

- (void)set:(ccTime)max{
  max_ = max;
  [self reset];
}

- (void)rotate {
  now_ = MAX(self.now + self.max, self.max);
}

- (void)tick:(ccTime)dt{
  if([self isOver] && !looping_) return;
  now_ -= dt;
  [self onUpdate:dt];
  if([self isOver]){
    [self onComplete];
  }
}

- (void)onUpdate:(ccTime)dt{
  if (updateListener_ && updateSelector_) {
    // http://stackoverflow.com/questions/8773226/performselector-warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [updateListener_ performSelector:updateSelector_ withObject:self];
#pragma clang diagnostic pop
  }
  if (updateBlock_) {
    updateBlock_(self, dt);
  }
}

- (void)onComplete{
  if(looping_){
    [self rotate];
  }
  if (completeListener_ && completeSelector_) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [completeListener_ performSelector:completeSelector_ withObject:self];
#pragma clang diagnostic pop
  }
  if (completeBlock_) {
    completeBlock_(self);
  }
}

@end
