//
//  KWShadowLabelTTF.m
//  Heqet
//
//  Created by  on 2012/3/29.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWShadowLabelTTF.h"

@implementation KWShadowLabelTTF
@synthesize offset;
@synthesize shadowColor;

- (id)initWithString:(NSString *)string fontName:(NSString *)name fontSize:(CGFloat)size {
  self = [super initWithString:string fontName:name fontSize:size];
  if (self) {
    self.shadowColor = ccc3(0, 0, 0);
    self.offset = ccp(2, -2);
    shadowLabel_ = [CCLabelTTF labelWithString:string fontName:name fontSize:size];
    shadowLabel_.position = self.offset;
    [self addChild:shadowLabel_ z:-1];
  }
  return self;
}

- (id)initWithString:(NSString *)str 
          dimensions:(CGSize)dimensions 
           alignment:(UITextAlignment)alignment 
       lineBreakMode:(UILineBreakMode)lineBreakMode 
            fontName:(NSString *)name 
            fontSize:(CGFloat)size {
  self = [super initWithString:str 
                    dimensions:dimensions 
                     alignment:alignment 
                 lineBreakMode:lineBreakMode 
                      fontName:name 
                      fontSize:size];
  if (self) {
    self.shadowColor = ccc3(0, 0, 0);
    self.offset = ccp(2, -2);
    shadowLabel_ = [CCLabelTTF labelWithString:str 
                                    dimensions:dimensions 
                                     alignment:alignment 
                                 lineBreakMode:lineBreakMode 
                                      fontName:name 
                                      fontSize:size];
    shadowLabel_.position = self.offset;
    [self addChild:shadowLabel_ z:-1];
  }
  return self;
}

- (ccColor3B)shadowColor {
  return shadowColor;
}

- (void)setShadowColor:(ccColor3B)sc {
  shadowColor = sc;
  shadowLabel_.color = sc;
}

- (void)draw {
  shadowLabel_.position = [self convertToNodeSpace:ccpAdd(self.position, self.offset)];
  [shadowLabel_ setString:self.string];
  [super draw];
}

@end
