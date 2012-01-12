//
//  KWPieChart.m
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 12/01/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWPieChart.h"
#import "KWDrawingPrimitives.h"

@interface KWPieChart()
- (void) updateVertices;  
- (void) updateTexture;
@end

@implementation KWPieChart
@synthesize reverse = reverse_;
@synthesize segments = segments_;
@synthesize rate = rate_;
@synthesize radius = radius_;
@synthesize chartColor = chartColor_;
@synthesize backgroundColor = backgroundColor_;

+ (id)chartWithRadius:(CGFloat)radius color:(ccColor3B)color {
  return [[[self class] alloc] initWithRadius:radius color:color];
}

- (id)initWithTexture:(CCTexture2D *)texture {
  self = [super initWithTexture:texture];
  if (self) {
    vertices_ = 0;
    self.rate = 1.0;
    self.radius = 0;
    self.chartColor = ccc3(1, 1, 1);
    self.backgroundColor = ccc4(0, 0, 0, 0);
    self.reverse = NO;
  }
  return self;
}

- (void)dealloc {
  free(vertices_);
}

- (id)initWithRadius:(CGFloat)radius color:(ccColor3B)color {
  self = [self initWithTexture:[[CCTexture2D alloc] init]];
  if (self) {
    self.rate = 1.0;
    self.radius = radius;
    self.chartColor = color;
    [self setSegments:MAX(self.radius, 30)];
  }
  return self;
}

-(void) updateVertices {  
  float numVertexBytes = sizeof(CGPoint) * (segments_ + 2);
  memset( vertices_, 0, numVertexBytes);  
  
  float coef = (2.0f * (float)M_PI) / segments_;  
  *vertices_ = CGPointMake(self.radius, self.radius);
  for(int i = 0; i < segmentsDrawn_ - 1; ++i) {
    float x = self.radius + self.radius * cosf(i * coef + M_PI_2) * (-1 + 2 * (int)self.reverse);
    float y = self.radius + self.radius * sinf(i * coef + M_PI_2);
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
  [self updateTexture];
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
  [self updateTexture];
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
  [self updateTexture];
}

- (void)updateTexture {
  if(!vertices_) return;
  CCRenderTexture* tex = [CCRenderTexture renderTextureWithWidth:self.radius * 2 
                                                          height:self.radius * 2];
  [self updateVertices];
  [tex beginWithClear:0 g:0 b:0 a:0];
  glColor4f(self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b, self.backgroundColor.a);
  ccFillCircle(CGPointMake(self.radius, self.radius), self.radius - 1, 0, self.segments, NO);
  glColor4f(self.chartColor.r, self.chartColor.g, self.chartColor.b, 1);
  ccFillPoly(vertices_, segmentsDrawn_, YES);
  [tex end];
  CCTexture2D* texture = tex.sprite.texture;
  CGRect rect = tex.sprite.textureRect;
  [self setTexture:texture];
  [self setTextureRect:rect];
}


@end
