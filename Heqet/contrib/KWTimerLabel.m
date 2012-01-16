//
//  KWTimerLabel.m
//  KawazBuster
//
//  Created by  on 11/06/21.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWTimerLabel.h"

@interface KWTimerLabel()
- (void)setup;
- (NSString*)humalize;
- (void)tick:(ccTime)dt;
- (Time)convertToTime:(NSTimeInterval)second;
- (NSTimeInterval)convertToSecond:(Time)time;
@end

@implementation KWTimerLabel
@dynamic active;
@dynamic now;
@synthesize displayMiliSecond = displayMiliSecond_;
@synthesize displayMode = displayMode_;
@synthesize timer = timer_;

+ (id)timerLabelWithHour:(int)hour minute:(int)minute second:(int)second {
  return [[[self class] alloc] initWithHour:hour minute:minute second:second];
}

+ (id)timerLabelWithSecond:(NSTimeInterval)second {
  return [[[self class] alloc] initWithSecond:second];
}

+ (id)timerLabelWithSecond:(NSTimeInterval)second fontName:(NSString *)name fontSize:(CGFloat)size {
  return [[[self class] alloc] initWithSecond:second fontName:name fontSize:size];
}

- (id)init{
  self = [super initWithString:@"" fontName:@"helvetica" fontSize:13];
  if (self) {
    [self setup];
  }
  return self;
}

- (id) initWithString:(NSString*)str dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment lineBreakMode:(CCLineBreakMode)lineBreakMode fontName:(NSString*)name fontSize:(CGFloat)size {
	self = [super initWithString:@"0" dimensions:dimensions alignment:alignment lineBreakMode:lineBreakMode fontName:name fontSize:size];
  if(self) {
    [self setup];
  }
	return self;
}

- (id) initWithString:(NSString*)str fontName:(NSString*)name fontSize:(CGFloat)size {
	self = [super initWithString:@"0" fontName:name fontSize:size];
  if(self) {
    [self setup];
  }
	return self;
}

- (id)initWithSecond:(NSTimeInterval)second fontName:(NSString *)name fontSize:(CGFloat)size {
  self = [super initWithString:@"" fontName:name fontSize:size];
  if (self) {
    [self setup];
  }
  return self;
}

- (id)initWithHour:(int)hour minute:(int)minute second:(int)second {
  self = [self init];
  if (self) {
    [self setHour:hour minute:minute second:second];
  }
  return self;
}

- (id)initWithSecond:(NSTimeInterval)second {
  self = [self init];
  if (self) {
    [self setSecond:second];
  }
  return self;
}

- (void)dealloc {
  [self unschedule:@selector(tick:)];
}

- (void)setHour:(int)hour minute:(int)minute second:(int)second {
  Time t;
  t.hour = hour;
  t.minute = minute;
  t.second = second;
  t.milisecond = 0;
  [self setSecond:[self convertToSecond:t]];
}

- (void)setSecond:(int)second {
  [self.timer set:second];
}

- (void)play {
  [self.timer play];
}

- (void)pause {
  [self.timer pause];
}

- (void)stop {
  [self.timer stop];
}

- (BOOL)active {
  return self.timer.active;
}

- (BOOL)isOver {
  return [self.timer isOver];
}

- (NSTimeInterval)now {
  return self.timer.now;
}

- (void)setup {
  displayMiliSecond_ = NO;
  displayMode_ = KWTimerLabelDisplayClock;
  timer_ = [[KWTimer alloc] initWithMax:0];
  [self schedule:@selector(tick:) interval:1.0/[[KKStartupConfig config] maxFrameRate]];
}

- (NSString*)humalize {
  Time time = [self convertToTime:self.timer.now];
  Time initial = [self convertToTime:self.timer.max];
  if (self.displayMode == KWTimerLabelDisplayClock) {
  int hour = time.hour;
    int minute = time.minute;
    int second = time.second;
    NSMutableString* string = [NSMutableString string];
    if (initial.hour == 0) {
      if (initial.minute < 10) {
        string = [NSMutableString stringWithFormat:@"%d:%02d", minute, second];
      } else {
        string = [NSMutableString stringWithFormat:@"%02d:%02d", minute, second];
      }
    } else if(initial.minute == 0) {
      string = [NSMutableString stringWithFormat:@"%02d", second];
    } else {
      string = [NSMutableString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    }
    if (self.displayMiliSecond) {
      [string appendFormat:@":%03d", time.milisecond];
    }
    return string;
  } else { 
    if (self.displayMiliSecond) {
      return [NSString stringWithFormat:@"%.3f", self.timer.now];
    } else {
      return [NSString stringWithFormat:@"%d", (int)self.timer.now];
    }
  }
}

- (void)tick:(ccTime)dt {
  [self setString:[self humalize]];
}

- (Time)convertToTime:(NSTimeInterval)second{
  if(second < 0) second = 0;
  Time t;
  t.hour = second / 3600;
  t.minute = (second - t.hour * 3600) / 60;
  t.second = second - t.hour*3600 - t.minute * 60;
  t.milisecond = (second - floor(second)) * 1000;
  return t;
}

- (NSTimeInterval)convertToSecond:(Time)time{
  float ms = (double)(time.milisecond) / 1000.0;
  return 3600 * time.hour + 60 * time.minute + time.second + ms;
}

@end
