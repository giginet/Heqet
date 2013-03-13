//
//  KWDrawingprimitives.m
//  Heqet
//
//  Created by  on 1/12/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import <math.h>
#import <stdlib.h>
#import <string.h>

#import "KWDrawingPrimitives.h"
#import "ccTypes.h"
#import "ccMacros.h"
#import "Platforms/CCGL.h"
#import "CCDrawingPrimitives.h"

static CCGLProgram *shader_ = nil;
static int colorLocation_ = -1;
static ccColor4F color_ = {1,1,1,1};

void ccFillPoly( const CGPoint *vertices, NSUInteger numOfVertices, BOOL closePolygon ) {
  NSLog(@"Please use CCFillSolidPoly.");
}

void ccFillCircle( CGPoint center, float r, float a, NSUInteger segs, BOOL drawLineToCenter)
{
  lazy_init();
  
  int additionalSegment = 1;
  if (drawLineToCenter)
    additionalSegment++;
  
  const float coef = 2.0f * (float)M_PI/segs;
  
  GLfloat *vertices = calloc( sizeof(GLfloat)*2*(segs+2), 1);
  if( ! vertices )
    return;
  
  for(NSUInteger i = 0;i <= segs; i++) {
    float rads = i*coef;
    GLfloat j = r * cosf(rads + a) + center.x;
    GLfloat k = r * sinf(rads + a) + center.y;
    
    vertices[i*2] = j;
    vertices[i*2+1] = k;
  }
  vertices[(segs+1)*2] = center.x;
  vertices[(segs+1)*2+1] = center.y;
  
  [shader_ use];
  [shader_ setUniformsForBuiltins];
  [shader_ setUniformLocation:colorLocation_ with4fv:(GLfloat*) &color_.r count:1];
  
  ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
  
  glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei) segs+additionalSegment);
  
  free( vertices );
  
  CC_INCREMENT_GL_DRAWS(1);
}

void ccFillQuadBezier(CGPoint origin, CGPoint control, CGPoint destination, NSUInteger segments)
{
  lazy_init();
  
  ccVertex2F vertices[segments + 1];
  
  float t = 0.0f;
  for(NSUInteger i = 0; i < segments; i++)
    {
    vertices[i].x = powf(1 - t, 2) * origin.x + 2.0f * (1 - t) * t * control.x + t * t * destination.x;
    vertices[i].y = powf(1 - t, 2) * origin.y + 2.0f * (1 - t) * t * control.y + t * t * destination.y;
    t += 1.0f / segments;
    }
  vertices[segments] = (ccVertex2F) {destination.x, destination.y};
  
  [shader_ use];
  [shader_ setUniformsForBuiltins];
  [shader_ setUniformLocation:colorLocation_ with4fv:(GLfloat*) &color_.r count:1];
  
  ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
  
  glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei) segments + 1);
  
  CC_INCREMENT_GL_DRAWS(1);
}

void ccFillCubicBezier(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, NSUInteger segments)
{
  lazy_init();
  
  ccVertex2F vertices[segments + 1];
  
  float t = 0;
  for(NSUInteger i = 0; i < segments; i++)
    {
    vertices[i].x = powf(1 - t, 3) * origin.x + 3.0f * powf(1 - t, 2) * t * control1.x + 3.0f * (1 - t) * t * t * control2.x + t * t * t * destination.x;
    vertices[i].y = powf(1 - t, 3) * origin.y + 3.0f * powf(1 - t, 2) * t * control1.y + 3.0f * (1 - t) * t * t * control2.y + t * t * t * destination.y;
    t += 1.0f / segments;
    }
  vertices[segments] = (ccVertex2F) {destination.x, destination.y};
  
  [shader_ use];
  [shader_ setUniformsForBuiltins];
  [shader_ setUniformLocation:colorLocation_ with4fv:(GLfloat*) &color_.r count:1];
  
  ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
  
  glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei) segments + 1);
  
  CC_INCREMENT_GL_DRAWS(1);
}

void ccFillRect(CGRect rect) {
  CGPoint vertices[4];
  vertices[0] = rect.origin;
  vertices[1] = ccpAdd(rect.origin, CGPointMake(rect.size.width, 0));
  vertices[2] = ccpAdd(rect.origin, CGPointMake(rect.size.width, rect.size.height));
  vertices[3] = ccpAdd(rect.origin, CGPointMake(0, rect.size.height));
  ccFillPoly(vertices, 4, YES);
}
