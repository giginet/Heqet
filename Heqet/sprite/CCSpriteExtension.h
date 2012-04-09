//
//  CCSpriteExtension.h
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCTouchDelegateProtocol.h"

@interface CCSprite(KWCCSpriteExtension)
@property(readwrite) BOOL displayHitBox;
@property(readwrite) CGRect hitBox;
@property(readonly) CGRect absoluteHitBox;
@property(readwrite) double x;
@property(readwrite) double y;

- (BOOL)collideWithPoint:(CGPoint)point;
- (BOOL)collideWithSprite:(CCSprite*)sprite;

- (void)drawHitBox;

@end
