//
//  KWVector.h
//  Heqet
//
//  Created by giginet on 10/12/08.
//  Copyright 2010 Kawaz. All rights reserved.
//

#import "math.h"
@interface KWVector : NSObject {
  CGFloat x_, y_;
}

@property(readwrite) CGFloat x;
@property(readwrite) CGFloat y;
@property(readonly) CGFloat length;
@property(readonly) CGFloat angle;
@property(readonly) CGPoint point;

+ (KWVector*)vector;
+ (KWVector*)vectorWithPoint:(CGPoint)point;
+ (KWVector*)vectorAtRandom;

- (id)init;
- (id)initWithPoint:(CGPoint)point;

- (KWVector*)set:(CGPoint)point;
- (KWVector*)add:(KWVector*)v;
- (KWVector*)sub:(KWVector*)v;
- (CGFloat)scalar:(KWVector*)v;
- (CGFloat)cross:(KWVector*)v;
- (KWVector*)scale:(CGFloat)n;
- (KWVector*)normalize;
- (KWVector*)resize:(CGFloat)n;
- (KWVector*)rotate:(CGFloat)deg;
- (KWVector*)reverse;
- (KWVector*)zero;
- (KWVector*)reflect:(KWVector*)normal;
- (KWVector*)max:(CGFloat)max;
- (KWVector*)min:(CGFloat)min;
- (KWVector*)lerp:(KWVector*)to t:(float)t;

@end
