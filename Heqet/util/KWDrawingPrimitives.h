//
//  KWDrawingprimitives.h
//  Heqet
//
//  Created by  on 1/12/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#ifndef __KW_DRAWING_PRIMITIVES_H
#define __KW_DRAWING_PRIMITIVES_H

#import <Availability.h>
#import <Foundation/Foundation.h>

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#import <CoreGraphics/CGGeometry.h>  // for CGPoint
#endif


#ifdef __cplusplus
extern "C" {
#endif  
  
  void ccFillPoly( const CGPoint *vertices, NSUInteger numOfVertices, BOOL closePolygon );
  void ccFillCircle( CGPoint center, float radius, float angle, NSUInteger segments, BOOL drawLineToCenter);
  void ccFillQuadBezier(CGPoint origin, CGPoint control, CGPoint destination, NSUInteger segments);
  void ccFillCubicBezier(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, NSUInteger segments);
  void ccFillRect(CGRect rect);
  
#ifdef __cplusplus
}
#endif

#endif //  __KW_DRAWING_PRIMITIVES_H
