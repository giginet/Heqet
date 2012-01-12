//
//  KWGauge.h
//  Heqet
//
//  Created by  on 1/12/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCSprite.h"

typedef enum {
  kwGaugeAlignVertically,
  kwGaugeAlignHorizontally
} kwGaugeAlign;

@interface KWGauge : CCSprite {
  float rate_;
  kwGaugeAlign align_;
  
  ccColor3B gaugeColor_;
  ccColor4B backgroundColor_;
  
  NSString* gaugeImage_;
  CCTexture2D* gaugeTexture_;
}

@property(readwrite) float rate;
@property(readwrite) ccColor3B gaugeColor;
@property(readwrite) ccColor4B backgroundColor;

+ (id)gaugeWithColor:(ccColor3B)color andSize:(CGSize)size;

- (id)initWithColor:(ccColor3B)color andSize:(CGSize)size;

- (void)alignHolizontally;
- (void)alignVertically;

@end