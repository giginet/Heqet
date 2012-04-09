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
  
  NSAssert(!usesBatchNode_, @"If CCSprite is being rendered by CCSpriteBatchNode, CCSprite#draw SHOULD NOT be called");
  
  // Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
  // Needed states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
  // Unneeded states: -
  
  BOOL newBlend = blendFunc_.src != CC_BLEND_SRC || blendFunc_.dst != CC_BLEND_DST;
  if( newBlend )
    glBlendFunc( blendFunc_.src, blendFunc_.dst );
  
#define kQuadSize sizeof(quad_.bl)
  glBindTexture(GL_TEXTURE_2D, [texture_ name]);
  
  long offset = (long)&quad_;
  
  // vertex
  NSInteger diff = offsetof( ccV3F_C4B_T2F, vertices);
  glVertexPointer(3, GL_FLOAT, kQuadSize, (void*) (offset + diff) );
  
  // color
  diff = offsetof( ccV3F_C4B_T2F, colors);
  glColorPointer(4, GL_UNSIGNED_BYTE, kQuadSize, (void*)(offset + diff));
  
  // tex coords
  diff = offsetof( ccV3F_C4B_T2F, texCoords);
  glTexCoordPointer(2, GL_FLOAT, kQuadSize, (void*)(offset + diff));
  
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  
  if( newBlend )
    glBlendFunc(CC_BLEND_SRC, CC_BLEND_DST);
  
#if CC_SPRITE_DEBUG_DRAW == 1
  // draw bounding box
  CGSize s = self.contentSize;
  CGPoint vertices[4] = {
    ccp(0,0), ccp(s.width,0),
    ccp(s.width,s.height), ccp(0,s.height)
  };
  ccDrawPoly(vertices, 4, YES);
#elif CC_SPRITE_DEBUG_DRAW == 2
  // draw texture box
  CGSize s = self.textureRect.size;
  CGPoint offsetPix = self.offsetPositionInPixels;
  CGPoint vertices[4] = {
    ccp(offsetPix.x,offsetPix.y), ccp(offsetPix.x+s.width,offsetPix.y),
    ccp(offsetPix.x+s.width,offsetPix.y+s.height), ccp(offsetPix.x,offsetPix.y+s.height)
  };
  ccDrawPoly(vertices, 4, YES);
#endif // CC_SPRITE_DEBUG_DRAW
  [self drawHitBox];
}

- (void)drawHitBox {
  if (!self.displayHitBox) return;
  glColor4f(1, 0, 0, 0.1);
  ccFillRect(self.hitBox);
}

@end
