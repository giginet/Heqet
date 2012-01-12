//
//  KWGauge.h
//  _Kobold2D-With-Heqet-Template_
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
}

@property(readwrite) float rate;
@property(readwrite) ccColor3B gaugeColor;
@property(readwrite) ccColor4B backgroundColor;

+ (id)gaugeWithSize:(CGSize)size;

- (id)initWithSize:(CGSize)size;

- (void)alignHolizontally;
- (void)alignVertically;

@end
