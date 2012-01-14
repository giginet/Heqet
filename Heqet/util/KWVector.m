//
//  KWVector.m
//  Heqet
//
//  Created by giginet on 10/12/08.
//  Copyright 2010 Kawaz. All rights reserved.
//

#import "KWVector.h"

@implementation KWVector

@synthesize x = x_;
@synthesize y = y_;
@dynamic angle;
@dynamic length;
@dynamic point;

+ (KWVector*)vector{
  return [[KWVector alloc] init];
}

+ (KWVector*)vectorWithPoint:(CGPoint)point{
  return [[KWVector alloc] initWithPoint:point];
}

- (id)init{
	self = [super init];
  if (self) {
    x_ = 0;
    y_ = 0;
  }
	return self;
}

- (id)initWithPoint:(CGPoint)point{
	self = [self init];
  if (self) {
    x_ = point.x;
    y_ = point.y;
  }
	return self;
}

- (KWVector*)set:(CGPoint)point{
	x_ = point.x;
	y_ = point.y;
	return self;
}

- (KWVector*)copy{
	return [[KWVector alloc] initWithPoint:CGPointMake(x_, y_)];
}

- (KWVector*)add:(KWVector *)v{
  KWVector* vector = [KWVector vector];
	[vector set:CGPointMake(self.x + v.x, self.y + v.y)];
  return vector;
}

- (KWVector*)sub:(KWVector *)v{
  KWVector* vector = [KWVector vector];
	[vector set:CGPointMake(self.x - v.x, self.y - v.y)];
  return vector;
}

- (CGFloat)scalar:(KWVector *)v{
	return self.x * v.x + self.y * v.y;
}

- (CGFloat)cross:(KWVector *)v{
	return self.x * v.y - self.y * v.x;
}

- (KWVector*)scale:(CGFloat)n{
  return [KWVector vectorWithPoint:CGPointMake(self.x * n, self.y * n)];
}

- (CGFloat)length{
	return hypotf(x_, y_);
}

- (KWVector*)normalize{
	if ([self length] == 0) {
		return [KWVector vector];
	}	
  return [[self copy] scale:1/[self length]];
}

- (KWVector*)resize:(CGFloat)n{
	return [[[self copy] normalize] scale:n];
}

- (CGFloat)angle{
	return atan2(self.y, self.x);
}

- (KWVector*)rotate:(CGFloat)deg{
	CGFloat rad = M_PI*deg/180;
	CGFloat tmpx = self.x;
	CGFloat x = sin(rad) * self.y + cos(rad) * self.x;
	CGFloat y = cos(rad) * self.y - sin(rad) * tmpx;
	return [KWVector vectorWithPoint:CGPointMake(x, y)];
}

- (KWVector*)reverse{
	return [KWVector vectorWithPoint:CGPointMake(self.x * -1, self.y * -1)];
}

- (KWVector*)zero{
	return [self set:CGPointMake(0, 0)];
}

- (KWVector*)reflect:(KWVector*)normal{
  double t = -[self scalar:normal];
  return [KWVector vectorWithPoint:CGPointMake(self.x + t * normal.x * 2.0, self.y + t * normal.y * 2.0)];
}

- (KWVector*)max:(CGFloat)max{
	if([self length] > max){
		[[self copy] resize:max]; 
	}
	return self;
}

- (KWVector*)min:(CGFloat)min{
	if([self length] < min){
		[[self copy] resize:min]; 
	}
	return self;
}

- (CGPoint)point{
  return CGPointMake(self.x, self.y);
}

- (BOOL)isEqual:(id)object{
  KWVector* v = (KWVector*)object;
  return v.x == self.x && v.y == self.y;
}

- (NSString*)description{
  return [NSString stringWithFormat:@"(%f, %f)", self.x, self.y];
}

@end
