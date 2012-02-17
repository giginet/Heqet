//
//  KWCounterLabel.h
//  LoopyLooper
//
//  Created by  on 2012/2/14.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCLabelTTF.h"

@interface KWCounterLabel : CCLabelTTF {
  int count_;
  float current_;
  float target_;
}

@property(readwrite) int accuracy;
@property(readwrite) int duration;
@property(readwrite) float target;
@property(readwrite, weak) id onUpdateDelegate;
@property(readwrite) SEL onUpdateCallback;
@property(readwrite, weak) id onFinishDelegate;
@property(readwrite) SEL onFinishCallback;

- (id)initWithNumber:(double)number 
          dimensions:(CGSize)dimensions 
           alignment:(UITextAlignment)alignment 
            fontName:(NSString *)name 
            fontSize:(CGFloat)size;

- (id)initWithNumber:(double)number 
          dimensions:(CGSize)dimensions 
           alignment:(UITextAlignment)alignment 
       lineBreakMode:(UILineBreakMode)lineBreakMode 
            fontName:(NSString *)name 
            fontSize:(CGFloat)size;

- (id)initWithNumber:(double)number 
            fontName:(NSString *)name 
            fontSize:(CGFloat)size;

- (void)setCallbackOnUpdate:(id)delegate selector:(SEL)selector;
- (void)setCallbackOnFinish:(id)delegate selector:(SEL)selector;

- (void)play;
- (void)stop;

@end
