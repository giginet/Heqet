//
//  KWPieChart.m
//  Heqet
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

- (id)init {
  self = [super init];
  if (self) {
    vertices_ = 0;
    rate_ = 1.0;
    radius_ = 0;
    chartColor_ = ccc3(1, 1, 1);
    backgroundColor_ = ccc4(0, 0, 0, 0);
    reverse_ = NO;
  }
  return self;
}

- (void)dealloc {
  free(vertices_);
}

- (id)initWithRadius:(CGFloat)radius color:(ccColor3B)color {
  self = [self init];
  if (self) {
    rate_ = 1.0;
    radius_ = radius;
    chartColor_ = color;
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
  [self updateTexture];
}  

- (CGFloat)radius {
  return radius_;
}

- (void)setRadius:(CGFloat)rad {
  float screenScale = 1.0f;  
  radius_ = rad * screenScale;
  [self updateVertices];
}

- (int)segments {
  return segments_;
}

- (void) setSegments:(int)segs {  
  assert(segs >= 3);  
  
  segments_ = segs;
  segmentsDrawn_ = (int)(segs * self.rate) + 2;
  float numVertexBytes = sizeof(CGPoint) * (segs + 2);
  
  vertices_ = realloc(vertices_, numVertexBytes);  
  assert(vertices_ != 0);
  [self updateVertices];
}

- (CGFloat)rate {
  return rate_;
}

- (void)setRate:(CGFloat)rate {
  rate = MAX(0, MIN(1, rate));
  rate_ = rate;
  segmentsDrawn_ = (int)(self.segments * self.rate) + 2;
  [self updateTexture];
}

- (ccColor3B)chartColor {
  return chartColor_;
}

- (void)setChartColor:(ccColor3B)chartColor {
  chartColor_ = chartColor;
  [self updateTexture];
}

- (ccColor4B)backgroundColor {
  return backgroundColor_;
}

- (void)setBackgroundColor:(ccColor4B)backgroundColor {
  backgroundColor_ = backgroundColor;
  [self updateTexture];
}

- (void)updateTexture {
  if(!vertices_) return;
  CCRenderTexture* tex = [CCRenderTexture renderTextureWithWidth:self.radius * 2 
                                                          height:self.radius * 2];
  [tex beginWithClear:0 g:0 b:0 a:0];
  glColor4f(self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b, self.backgroundColor.a);
  ccFillCircle(CGPointMake(self.radius, self.radius), self.radius - 1, 0, self.segments, NO);
  glColor4f(self.chartColor.r, self.chartColor.g, self.chartColor.b, 1);
  ccFillPoly(vertices_, segmentsDrawn_, YES);
  [tex end];
  texture_ = tex.sprite.texture;
  self.contentSize = texture_.contentSize;
}

- (void)draw {
  [texture_ drawInRect:CGRectMake(-self.radius, -self.radius, self.contentSize.width, self.contentSize.height)];
}


@end
