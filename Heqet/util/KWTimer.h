//
//  KWTimer.h
//  Heqet
//
//  Created by giginet on 11/03/04.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "cocos2d.h"

@interface KWTimer : NSObject {
@private
	int now_;
  int max_;
  BOOL looping_;
  BOOL active_;
  __weak id completeListener_;
  __weak id updateListener_;
  SEL completeSelector_;
  SEL updateSelector_;
  void (^completeBlock_)(id);
  void (^updateBlock_)(id, ccTime);
}

@property(readonly) BOOL active;
@property(readwrite) BOOL looping;
@property(readwrite, setter=set:) int max;
@property(readonly) int now;

+ (KWTimer*)timer;
+ (KWTimer*)timerWithMax:(int)max;

- (id)init;
- (id)initWithMax:(int)max;

- (id)play;
- (id)stop;
- (id)pause;

- (id)reset;

- (void)count;
- (id)move:(int)n;

- (BOOL)isOver;

- (void)setOnCompleteListener:(id)listener selector:(SEL)selector;
- (void)setOnCompleteListenerWithBlock:(void (^)(id))block;
- (void)setOnUpdateListener:(id)listener selector:(SEL)selector;
- (void)setOnUpdateListenerWithBlock:(void (^)(id, ccTime))block;

@end
