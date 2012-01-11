//
//  KWTimerLabel.h
//  Heqet
//
//  Created by  on 11/06/21.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "heqet.h"

typedef struct{
  int hour;
  int minute;
  int second;
  int milisecond;
} Time;

@interface KWTimerLabel : CCLabelTTF{
  BOOL active_;
  BOOL displayMiliSecond_;
  NSTimeInterval initial_;
  NSTimeInterval current_;
}

@property(readonly) BOOL active;
@property(readwrite) BOOL displayMiliSecond;
@property(readonly) NSTimeInterval leave;

+ (id)labelWithHour:(int)hour minute:(int)minute second:(int)second;
+ (id)labelWithSecond:(NSTimeInterval)second;

- (id)initWithHour:(int)hour minute:(int)minute second:(int)second;
- (id)initWithSecond:(NSTimeInterval)second;

- (void)setHour:(int)hour minute:(int)minute second:(int)second;
- (void)setSecond:(int)second;
- (void)play;
- (void)pause;
- (void)stop;
- (BOOL)isOver;

@end
