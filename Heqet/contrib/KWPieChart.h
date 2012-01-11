//
//  KWPieChart.h
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 12/01/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "cocos2d.h"

@interface KWPieChart : CCSprite {
  CGFloat rate_;
  CGFloat radius_;
  
  CGPoint* vertices_;
  BOOL reverse_;
  int segments_;
  int segmentsDrawn_;
}

@property(readwrite) BOOL reverse;
@property(readwrite) int segments;
@property(readwrite) CGFloat rate;
@property(readwrite) CGFloat radius;

+ (id)chartWithRadius:(CGFloat)radius color:(ccColor3B)color;

- (id)initWithRadius:(CGFloat)radius color:(ccColor3B)color;

@end
