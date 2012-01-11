//
//  KWPieChart.m
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 12/01/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWPieChart.h"

void ccFillPoly( CGPoint *poli, int points, BOOL closePolygon ) {
  // Ref : http://www.cocos2d-iphone.org/forum/topic/848
  // Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
  // Needed states: GL_VERTEX_ARRAY,
  // Unneeded states: GL_TEXTURE_2D, GL_TEXTURE_COORD_ARRAY, GL_COLOR_ARRAY
  glDisable(GL_TEXTURE_2D);
  glDisableClientState(GL_TEXTURE_COORD_ARRAY);
  glDisableClientState(GL_COLOR_ARRAY);
  
  glVertexPointer(2, GL_FLOAT, 0, poli);
  if(closePolygon) {
    glDrawArrays(GL_TRIANGLE_FAN, 0, points);
  } else {
    glDrawArrays(GL_LINE_STRIP, 0, points);
  }
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_TEXTURE_COORD_ARRAY);
  glEnable(GL_TEXTURE_2D);
}

@interface KWPieChart()
- (void) updateVertices;  
@end

@implementation KWPieChart
@synthesize reverse = reverse_;
@synthesize segments = segments_;
@synthesize rate = rate_;
@synthesize radius = radius_;

+ (id)chartWithRadius:(CGFloat)radius color:(ccColor3B)color {
  return [[[self class] alloc] initWithRadius:radius color:color];
}

- (id)init {
  self = [super init];
  if (self) {
    vertices_ = 0;
    self.rate = 1.0;
    self.radius = 0;
    self.color = ccc3(1, 1, 1);
    self.reverse = NO;
  }
  return self;
}

- (id)initWithRadius:(CGFloat)radius color:(ccColor3B)color {
  self = [self init];
  if (self) {
    self.rate = 1.0;
    self.radius = radius;
    self.color = color;
    [self setSegments:MAX(self.radius, 30)];
  }
  return self;
}

-(void) updateVertices {  
  float numVertexBytes = sizeof(CGPoint) * (segments_ + 2);
  memset( vertices_, 0, numVertexBytes);  
  
  float coef = (2.0f * (float)M_PI) / segments_;  
  *vertices_ = self.position;
  for(int i = 0; i < segmentsDrawn_ - 1; ++i) {
    float x = self.position.x + self.radius * cosf(i * coef + M_PI_2) * (-1 + 2 * (int)self.reverse);
    float y = self.position.y + self.radius * sinf(i * coef + M_PI_2);
    *(vertices_ + i + 1) = CGPointMake(x, y);
  } 
}  

- (CGFloat)radius {
  return radius_;
}

- (void)setRadius:(CGFloat)rad {
  self.dirty = YES;
  float screenScale = 1.0f;  
  if ([UIScreen instancesRespondToSelector:@selector(scale)]) {  
    screenScale = [[UIScreen mainScreen] scale];  
  }
  radius_ = rad * screenScale;  
}

- (int)segments {
  return segments_;
}

- (void) setSegments:(int)segs {  
  assert(segs >= 3);  
  
  segments_ = segs;
  segmentsDrawn_ = (int)(segs * self.rate) + 2;
  self.dirty = YES;
  float numVertexBytes = sizeof(CGPoint) * (segs + 2);
  
  vertices_ = realloc(vertices_, numVertexBytes);  
  assert(vertices_ != 0);  
}

- (CGFloat)rate {
  return rate_;
}

- (void)setRate:(CGFloat)rate {
  if (rate > 1) {
    rate = 1.0;
  } else if (rate < 0) {
    rate = 0;
  }
  self.dirty = YES;
  rate_ = rate;
  segmentsDrawn_ = (int)(self.segments * self.rate) + 2;
}

- (void)draw {
  if (self.dirty) {
    [self updateVertices];
    glColor4f(self.color.r, self.color.g, self.color.b, 1);
    ccFillPoly(vertices_, segmentsDrawn_, YES);
    self.dirty = NO;
  }
} 

@end
