//
//  KWCounterLabel.m
//  LoopyLooper
//
//  Created by  on 2012/2/14.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWCounterLabel.h"

@interface KWCounterLabel()
- (void)update:(ccTime)dt;
@end

@implementation KWCounterLabel
@synthesize accuracy;
@synthesize duration;
@synthesize target = target_;
@synthesize onUpdateDelegate;
@synthesize onUpdateCallback;
@synthesize onFinishDelegate;
@synthesize onFinishCallback;

- (id)initWithNumber:(double)number fontName:(NSString *)name fontSize:(CGFloat)size {
  self = [super initWithString:[NSString stringWithFormat:@"%.0f", number] 
                      fontName:name
                      fontSize:size];
  if (self) {
    count_ = 0;
    current_ = number;
    self.duration = 1;
    self.target = number;
  }
  return self;
}

- (id)initWithNumber:(double)number dimensions:(CGSize)dimensions alignment:(UITextAlignment)alignment fontName:(NSString *)name fontSize:(CGFloat)size {
  self = [super initWithString:[NSString stringWithFormat:@"%.0f", number] 
                    dimensions:dimensions 
                     alignment:alignment 
                 lineBreakMode:CCLineBreakModeWordWrap 
                      fontName:name 
                      fontSize:size];
  if (self) {
    count_ = 0;
    current_ = number;
    self.duration = 1;
    self.target = number;
  }
  return self;
}

- (id)initWithNumber:(double)number dimensions:(CGSize)dimensions alignment:(UITextAlignment)alignment lineBreakMode:(UILineBreakMode)lineBreakMode fontName:(NSString *)name fontSize:(CGFloat)size {
  self = [super initWithString:[NSString stringWithFormat:@"%.0f", number] 
                    dimensions:dimensions 
                     alignment:alignment 
                 lineBreakMode:lineBreakMode 
                      fontName:name 
                      fontSize:size];
  if (self) {
    count_ = 0;
    current_ = number;
    self.duration = 1;
    self.target = number;
  }
  return self;
}

- (void)update:(ccTime)dt {
  if(current_ == target_) return;
  count_ = ++count_ % duration;
  if(count_ != 0) return;
  int order = floor(log10(abs(target_ - current_)));
  if (current_ < target_) {
    current_ += pow(10, order);
  } else {
    current_ -= pow(10, order);
  }
  [onUpdateDelegate performSelector:@selector(onUpdateCallback) withObject:[NSNumber numberWithDouble:current_]];
  [self setString:[NSString stringWithFormat:@"%.0f", current_]];
  if (current_ == target_) {
    [onFinishDelegate performSelector:@selector(onFinishCallback) withObject:[NSNumber numberWithDouble:current_]];
  }
}

- (void)setCallbackOnUpdate:(id)delegate selector:(SEL)selector {
  self.onUpdateDelegate = delegate;
  self.onUpdateCallback = selector;
}

- (void)setCallbackOnFinish:(id)delegate selector:(SEL)selector {
  self.onFinishDelegate = delegate;
  self.onFinishCallback = selector;
}

- (void)play {
  [self schedule:@selector(update:)];
}

- (void)stop {
  [self unschedule:@selector(update:)];
}

@end
