/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "heqet.h"

@interface HelloWorldLayer : KWLayer {
	NSString* helloWorldString;
	NSString* helloWorldFontName;
	int helloWorldFontSize;
  KWPieChart* chart_;
  KWGauge* gauge_;
}

@property (nonatomic, copy) NSString* helloWorldString;
@property (nonatomic, copy) NSString* helloWorldFontName;
@property (nonatomic) int helloWorldFontSize;

@end
