//
//  KWSprite.h
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCTouchDelegateProtocol.h"

@interface KWSprite : CCSprite {
  // relative hitarea from 'anchor point'.
  CGRect hitBox_;
}

- (BOOL)collideWithPoint:(CGPoint)point;
- (BOOL)collideWithSprite:(KWSprite*)sprite;
- (BOOL)collideWithCircle:(CGPoint)center:(CGFloat)radius;

- (CGFloat)distance:(KWSprite*)sprite;

@property(readwrite) CGRect hitBox;
@property(readonly) CGRect absoluteHitBox;
@property(readwrite) double x;
@property(readwrite) double y;
@end
