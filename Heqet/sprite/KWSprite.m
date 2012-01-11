//
//  KWSprite.m
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWSprite.h"
#import "KWVector.h"

@implementation KWSprite
@synthesize hitBox=hitBox_;

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect{
  self = [super initWithTexture:texture rect:rect];
  if(self){
    CGFloat width = self.contentSize.width;
    CGFloat height = self.contentSize.height;
    self.hitBox = CGRectMake(-width / 2, 
                             -height / 2, 
                             width, 
                             height);
  }
  return self;
}

- (BOOL)collideWithPoint:(CGPoint)point{
  return CGRectContainsPoint(self.hitBox, point);
}

- (BOOL)collideWithSprite:(KWSprite*)sprite{
  CGRect other = [sprite boundingBox];
  return CGRectIntersectsRect(self.hitBox, other);
}

- (BOOL)collideWithCircle:(CGPoint)center:(CGFloat)radius{
  return hypot(center.x - self.position.x, center.y - self.position.y) < radius;
}

- (CGFloat)distance:(KWSprite*)sprite{
  KWVector* this = [KWVector vectorWithPoint:self.anchorPoint];
  KWVector* other = [KWVector vectorWithPoint:sprite.anchorPoint];
  return [this sub:other].length;
}

- (CGRect)absoluteHitBox{
  CGPoint origin = [self convertToWorldSpaceAR:self.hitBox.origin];
  return CGRectMake(origin.x - self.hitBox.size.width/2, 
                    origin.y - self.hitBox.size.height/2, 
                    self.hitBox.size.width, 
                    self.hitBox.size.height);
}

- (double)x {
  return self.position.x;
}

- (double)y {
  return self.position.y;
}

- (void)setX:(double)x{
  position_.x = x;
}

- (void)setY:(double)y{
  position_.y = y;
}

@end
