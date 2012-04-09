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

@interface KWGauge : CCNode {
  float rate_;
  kwGaugeAlign align_;
  
  CGSize originalSize_;
  CCSprite* gaugeSprite_;
}

@property(readwrite) float rate;

+ (id)gaugeWithFile:(NSString *)filename;

- (id)initWithFile:(NSString *)filename;

- (void)alignHolizontally;
- (void)alignVertically;

@end