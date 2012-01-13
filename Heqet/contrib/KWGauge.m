//
//  KWGauge.m
//  Heqet
//
//  Created by  on 1/12/12.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWGauge.h"
#import "KWDrawingPrimitives.h"

@interface KWGauge()
- (CCTexture2D*)generateTexture:(ccColor3B)gaugeColor backgroundColor:(ccColor4B)backgroundColor size:(CGSize)size rate:(CGFloat)rate;
- (CCTexture2D*)generateTextureFromFile:(NSString*)filename backgroundColor:(ccColor4B)backgroundColor rate:(CGFloat)rate;
- (void)updateTexture;
@end

@implementation KWGauge
@synthesize rate = rate_;
@synthesize gaugeColor = gaugeColor_;
@synthesize backgroundColor = backgroundColor_;

+ (id)gaugeWithColor:(ccColor3B)color andSize:(CGSize)size {
  return [[KWGauge alloc] initWithColor:color andSize:size];
}

+ (id)gaugeWithFile:(NSString *)filename {
  return [[KWGauge alloc] initWithFile:filename];
}

- (id)init {
  self = [super init];
  if (self) {
    rate_ = 1.0;
    align_ = kwGaugeAlignHorizontally;
    gaugeColor_ = ccc3(1, 1, 1);
    backgroundColor_ = ccc4(0, 0, 0, 1);
    texture_ = [[CCTexture2D alloc] init];
  }
  return self;
}

- (id)initWithColor:(ccColor3B)color andSize:(CGSize)size {
  self = [self init];
  if (self) {
    gaugeColor_ = color;
    contentSize_ = size;
    [self updateTexture];
  }
  return self;
}

- (id)initWithFile:(NSString *)filename {
  self = [self init];
  if (self) {
    gaugeImage_ = filename;
    [self updateTexture];
  }
  return self;
}

- (void)alignHolizontally {
  align_ = kwGaugeAlignHorizontally;
  [self updateTexture];
}

- (void)alignVertically {
  align_ = kwGaugeAlignVertically;
  [self updateTexture];
}

- (float)rate {
  return rate_;
}

- (void)setRate:(float)rate {
  rate = MAX(0, MIN(1, rate));
  rate_ = rate;
  [self updateTexture];
}

- (ccColor3B)gaugeColor {
  return gaugeColor_;
}

- (void)setGaugeColor:(ccColor3B)gaugeColor {
  gaugeColor_ = gaugeColor;
  [self updateTexture];
}

- (ccColor4B)backgroundColor {
  return  backgroundColor_;
}

- (void)setBackgroundColor:(ccColor4B)backgroundColor {
  backgroundColor = backgroundColor;
  [self updateTexture];
}

- (CGSize)contentSize {
  return [super contentSize];
}

- (void)setContentSize:(CGSize)contentSize {
  [super setContentSize:contentSize];
  [self updateTexture];
}

- (CCTexture2D*)generateTexture:(ccColor3B)gaugeColor backgroundColor:(ccColor4B)backgroundColor size:(CGSize)size rate:(CGFloat)rate {
  CCRenderTexture* tex = [CCRenderTexture renderTextureWithWidth:size.width 
                                                          height:size.height];
  CGRect rect;
  if(align_ == kwGaugeAlignHorizontally) {
    rect = CGRectMake(0, 
                      0, 
                      size.width * rate,
                      size.height);
  } else {
    rect = CGRectMake(0, 
                      size.height - size.height * rate, 
                      size.width, 
                      size.height * rate);
  }
  [tex beginWithClear:backgroundColor.r 
                    g:backgroundColor.g 
                    b:backgroundColor.b 
                    a:backgroundColor.a];
  glColor4f(gaugeColor.r, gaugeColor.g, gaugeColor.b, 1);
  ccFillRect(rect);
  [tex end];
  return tex.sprite.texture;
}

- (CCTexture2D*)generateTextureFromFile:(NSString *)filename backgroundColor:(ccColor4B)backgroundColor rate:(CGFloat)rate {
  CCTexture2D* image = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:filename]];
  CGSize size = image.contentSize;
  CCRenderTexture* tex = [CCRenderTexture renderTextureWithWidth:size.width 
                                                          height:size.height];
  CGRect rect;
  if(align_ == kwGaugeAlignHorizontally) {
    rect = CGRectMake(0, 
                      0, 
                      size.width * rate,
                      size.height);
  } else {
    rect = CGRectMake(0, 
                      size.height - size.height * rate, 
                      size.width, 
                      size.height * rate);
  }
  [tex beginWithClear:backgroundColor.r 
                    g:backgroundColor.g 
                    b:backgroundColor.b 
                    a:backgroundColor.a];
  [image drawInRect:rect];
  [tex end];
  return tex.sprite.texture;
}

- (void)updateTexture {
  if(gaugeImage_) {
    texture_ = [self generateTextureFromFile:gaugeImage_ backgroundColor:self.backgroundColor rate:self.rate];
  } else {
    texture_ = [self generateTexture:self.gaugeColor 
                backgroundColor:self.backgroundColor 
                           size:self.contentSize 
                           rate:self.rate];
  }
  contentSize_ = texture_.contentSize;
  contentSizeInPixels_ = texture_.contentSizeInPixels;
}

- (void)draw {
  [texture_ drawInRect:CGRectMake(-self.contentSize.width / 2, 
                                  -self.contentSize.height / 2, 
                                  self.contentSize.width, 
                                  self.contentSize.height)];
}

@end
