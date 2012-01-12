//
//  KWGauge.m
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 1/12/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWGauge.h"
#import "KWDrawingPrimitives.h"

@interface KWGauge()
- (void)updateTexture;
@end

@implementation KWGauge
@synthesize rate = rate_;
@synthesize gaugeColor = gaugeColor_;
@synthesize backgroundColor = backgroundColor_;

+ (id)gaugeWithSize:(CGSize)size {
  return [[KWGauge alloc] initWithSize:size];
}

- (id)initWithTexture:(CCTexture2D *)texture {
  self = [super initWithTexture:texture];
  if (self) {
    rate_ = 1.0;
    align_ = kwGaugeAlignHorizontally;
    gaugeColor_ = ccc3(1, 1, 1);
    backgroundColor_ = ccc4(0, 0, 0, 1);
  }
  return  self;
}

- (id)initWithSize:(CGSize)size {
  self = [self initWithTexture:[[CCTexture2D alloc] init]];
  if (self) {
    self.contentSize = size;
    [self updateTexture];
  }
  return self;
}

- (void)alignHolizontally {
  align_ = kwGaugeAlignHorizontally;
  [self updateTexture];
}

- (void)alignVertically {
  align_ = kwGaugeAlignVertically;
  [self updateTexture];
}

- (float)rate {
  return rate_;
}

- (void)setRate:(float)rate {
  rate = MAX(0, MIN(1, rate));
  rate_ = rate;
  [self updateTexture];
}

- (ccColor3B)gaugeColor {
  return gaugeColor_;
}

- (void)setGaugeColor:(ccColor3B)gaugeColor {
  gaugeColor_ = gaugeColor;
  [self updateTexture];
}

- (ccColor4B)backgroundColor {
  return  backgroundColor_;
}

- (void)setBackgroundColor:(ccColor4B)backgroundColor {
  backgroundColor = backgroundColor;
  [self updateTexture];
}

- (CGSize)contentSize {
  return [super contentSize];
}

- (void)setContentSize:(CGSize)contentSize {
  [super setContentSize:contentSize];
  [self updateTexture];
}

- (void)updateTexture {
  CCRenderTexture* tex = [CCRenderTexture renderTextureWithWidth:self.contentSize.width 
                                                          height:self.contentSize.height];
  CGRect rect;
  if(align_ == kwGaugeAlignHorizontally) {
    rect = CGRectMake(0, 
                      0, 
                      self.contentSize.width * 
                      self.rate, self.contentSize.height);
  } else {
    rect = CGRectMake(0, 
                      self.contentSize.height - self.contentSize.height * self.rate, 
                      self.contentSize.width, 
                      self.contentSize.height * self.rate);
  }
  [tex beginWithClear:self.backgroundColor.r 
                    g:self.backgroundColor.g 
                    b:self.backgroundColor.b 
                    a:self.backgroundColor.a];
  glColor4f(self.gaugeColor.r, self.gaugeColor.g, self.gaugeColor.b, 1);
  ccFillRect(rect);
  [tex end];
  [self setTexture:tex.sprite.texture];
  [self setTextureRect:tex.sprite.textureRect];
}

@end
