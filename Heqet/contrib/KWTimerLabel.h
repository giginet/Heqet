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

typedef enum {
  KWTimerLabelDisplayClock,
  KWTimerLabelDisplaySecond
} KWTimerLabelDisplay;

@interface KWTimerLabel : CCLabelTTF{
  BOOL displayMiliSecond_;
  KWTimerLabelDisplay displayMode_;
  KWTimer* timer_;
}

@property(readonly) BOOL active;
@property(readonly) NSTimeInterval now;
@property(readwrite) BOOL displayMiliSecond;
@property(readwrite) KWTimerLabelDisplay displayMode;
@property(readonly) KWTimer* timer;

+ (id)timerLabelWithHour:(int)hour minute:(int)minute second:(int)second;
+ (id)timerLabelWithSecond:(NSTimeInterval)second;
+ (id)timerLabelWithSecond:(NSTimeInterval)second fontName:(NSString *)name fontSize:(CGFloat)size;

- (id)initWithHour:(int)hour minute:(int)minute second:(int)second;
- (id)initWithSecond:(NSTimeInterval)second;
- (id)initWithSecond:(NSTimeInterval)second fontName:(NSString *)name fontSize:(CGFloat)size;


- (void)setHour:(int)hour minute:(int)minute second:(int)second;
- (void)setSecond:(int)second;
- (void)play;
- (void)pause;
- (void)stop;
- (BOOL)isOver;

@end
