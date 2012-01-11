//
//  KWTimer.m
//  Heqet
//
//  Created by giginet on 11/03/04.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWTimer.h"

@interface KWTimer()
- (void)tick:(ccTime)dt;
- (void)onUpdate;
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

+ (KWTimer*)timerWithMax:(int)max{
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

- (id)initWithMax:(int)max{
	self = [self init];
	if(self) {
    [self set:max];
  }
	return self;
}

- (id)play{
	active_ = NO;
  double fps = 60.0;
  [[CCScheduler sharedScheduler] scheduleSelector:@selector(tick:) 
                                        forTarget:self 
                                         interval:1.0/fps 
                                           paused:YES];
	return self;
}

- (id)stop{
	[self pause];
	[self reset];
	return self;
}

- (id)pause{
	[[CCScheduler sharedScheduler] unscheduleSelector:@selector(tick:) forTarget:self];
  return self;
}

- (id)reset{
	now_ = 0;
	return self;
}

- (void)count{
	if(active_) now_ += 1;
}

- (id)move:(int)n{
  if([self isOver]) return self;
  [self onUpdate];
  for (int i = 0; i < n; ++i) {
    [self count];
    if([self isOver]){
      [self onComplete];
      if(looping_){
        [self reset];
      }
    }
  }
  return self;
}

- (BOOL)isOver{
	return now_ >= max_;
}

- (void)setOnCompleteListener:(id)listener selector:(SEL)selector {
  completeListener_ = listener;
  completeSelector_ = selector;
}

- (void)setOnCompleteListenerWithBlock:(void (^)(id))block {
  completeBlock_ = block;
}

- (void)setOnUpdateListener:(id)listener selector:(SEL)selector {
  updateListener_ = listener;
  updateSelector_ = selector;
}

- (void)setOnUpdateListenerWithBlock:(void (^)(id))block {
  updateBlock_ = block;
}

- (int)max{
  return max_;
}

- (void)set:(int)max{
  max_ = max;
}

- (void)tick:(ccTime)dt{
	if([self isOver]) return;
  [self onUpdate];
  [self count];
  if([self isOver]){
    [self onComplete];
		if(looping_){
			[self reset];
		}
	}
}

- (void)onUpdate{
  if (updateListener_ && updateSelector_) {
    // http://stackoverflow.com/questions/8773226/performselector-warning
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [updateListener_ performSelector:updateSelector_ withObject:self];
    #pragma clang diagnostic pop
  }
  if (updateBlock_) {
    updateBlock_(self);
  }
}

- (void)onComplete{
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
