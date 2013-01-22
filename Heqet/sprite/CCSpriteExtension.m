//
//  CCSpriteExtension.m
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "objc/runtime.h"

#import "CCSpriteExtension.h"
#import "KWDrawingPrimitives.h"

#import "KWVector.h"

@implementation CCSprite(KWCCSpriteExtension)
@dynamic displayHitBox;
@dynamic hitBox;
@dynamic absoluteHitBox;
@dynamic x;
@dynamic y;

- (BOOL)collideWithPoint:(CGPoint)point{
  return CGRectContainsPoint(self.absoluteHitBox, point);
}

- (BOOL)collideWithSprite:(CCSprite*)sprite{
  return CGRectIntersectsRect(self.absoluteHitBox, sprite.absoluteHitBox);
}

- (BOOL)displayHitBox {
  return [(NSNumber*)objc_getAssociatedObject(self, @"displayHitBox") boolValue];
}

- (void)setDisplayHitBox:(BOOL)displayHitBox {
  objc_setAssociatedObject(self, @"displayHitBox", [NSNumber numberWithBool:displayHitBox], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)hitBox {
  id value = objc_getAssociatedObject(self, @"hitBox");
  if(!value) {
    return CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
  }
  return [(NSValue*)value CGRectValue];
}

- (void)setHitBox:(CGRect)hitBox {
  objc_setAssociatedObject(self, @"hitBox", [NSValue valueWithCGRect:hitBox], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)absoluteHitBox{
  CGPoint origin = [self convertToWorldSpace:self.hitBox.origin];
  return CGRectMake(origin.x, 
                    origin.y, 
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

- (void)draw {
  [super draw];
}

- (void)drawHitBox {
  if (!self.displayHitBox) return;
  glColor4f(1, 0, 0, 0.1);
  ccFillRect(self.hitBox);
}

@end
