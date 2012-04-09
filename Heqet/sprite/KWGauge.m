//
//  KWGauge.m
//  Heqet
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

+ (id)gaugeWithFile:(NSString *)filename {
  return [[KWGauge alloc] initWithFile:filename];
}

- (id)init {
  self = [super init];
  if (self) {
    rate_ = 1.0;
    align_ = kwGaugeAlignHorizontally;
  }
  return self;
}

- (id)initWithFile:(NSString *)filename {
  self = [self init];
  if (self) {
    gaugeSprite_ = [CCSprite spriteWithFile:filename];
    gaugeSprite_.anchorPoint = ccp(0, 0);
    gaugeSprite_.position = ccp(-gaugeSprite_.contentSize.width / 2, -gaugeSprite_.contentSize.height / 2);
    originalSize_ = gaugeSprite_.contentSize;
    [self addChild:gaugeSprite_];
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
  if (rate_ != rate) {
    rate_ = rate;
    [self updateTexture];
  }
}

- (CGSize)contentSize {
  return [super contentSize];
}

- (void)setContentSize:(CGSize)contentSize {
  [super setContentSize:contentSize];
  [self updateTexture];
}

- (void)updateTexture {
  CGSize size = originalSize_;
  CGRect rect;
  if(align_ == kwGaugeAlignHorizontally) {
    rect = CGRectMake(0, 
                      0, 
                      size.width * self.rate,
                      size.height);
  } else {
    rect = CGRectMake(0, 
                      size.height - size.height * self.rate, 
                      size.width, 
                      size.height * self.rate);
  }
  [gaugeSprite_ setTextureRect:rect];
}

@end
