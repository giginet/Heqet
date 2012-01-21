//
//  KWScrollLayer.m
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 2012/1/22.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCFileUtils.h"

#import "KWScrollLayer.h"

@interface KWScrollLayer()
- (void)scrollBackground:(ccTime)dt;
- (CCTexture2D*)generateTexture:(CCTexture2D*)texture;
@end

@implementation KWScrollLayer
@synthesize velocity = velocity_;
@synthesize original = original_;

+ (id)layerWithFile:(NSString *)file {
  return [[[self class] alloc] initWithFile:file];
}

+ (id)layerWithTexture:(CCTexture2D *)texture {
  return [[[self class] alloc] initWithTexture:texture];
}

- (id)init {
  self = [super init];
  if (self) {
    self.velocity = [KWVector vector];
    backgrounds_ = [NSMutableArray array];
    int fps = [[KKStartupConfig config] maxFrameRate];
    [self schedule:@selector(scrollBackground:) interval:1.0/fps];
  }
  return self;
}

- (id)initWithFile:(NSString *)file {
  CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
  self = [self initWithTexture:texture];
  return self;
}

- (id)initWithTexture:(CCTexture2D *)texture {
  self = [self init];
  if (self) {
    [backgrounds_ addObject:[CCSprite spriteWithTexture:texture]];
    [backgrounds_ addObject:[CCSprite spriteWithTexture:texture]];
    [self addChild:[backgrounds_ objectAtIndex:0]];
    [self addChild:[backgrounds_ objectAtIndex:1]];
  }
  return self;
}

- (void)scrollBackground:(ccTime)dt {
  CGSize screenSize = [[CCDirector sharedDirector] screenSizeInPixels];
  current_.x = (int)((current_.x - velocity_.x)) % (int)screenSize.width;
  for(int i = 0; i < 2; ++i) {
    CCSprite* sprite = [backgrounds_ objectAtIndex:i];
    sprite.position = CGPointMake(screenSize.width / 2 + screenSize.width * i - current_.x - 1, screenSize.height / 2);
  }
  NSLog(@"%f", screenSize.width / 2 + screenSize.width * 0 - current_.x);
}

- (CCTexture2D*)generateTexture:(CCTexture2D *)texture {
  CGSize original = texture.contentSizeInPixels;
  CGSize screenSize = [[CCDirector sharedDirector] screenSizeInPixels];
  int col = ceil(screenSize.width / original.width);
  int row = ceil(screenSize.height / original.height);
  CCRenderTexture* rt = [CCRenderTexture renderTextureWithWidth:col * original.width
                                                         height:row * original.height];
  [rt begin];
  for(int x = 0; x <= col; ++x) {
    for(int y = 0; y <= row; ++y) {
      [texture drawInRect:CGRectMake(original.width * x, 
                                     original.height * y,
                                     original.width,
                                     original.height)];
    }
  }
  [rt end];
  return  rt.sprite.texture;
}

@end
