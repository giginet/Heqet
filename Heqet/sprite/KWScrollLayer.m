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
- (CCSpriteBatchNode*)generateSprites:(CCTexture2D*)texture;
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
    row_ = 1;
    col_ = 1;
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
    CCSpriteBatchNode* batch = [self generateSprites:texture];
    [self addChild:batch];
  }
  return self;
}

- (void)scrollBackground:(ccTime)dt {
  CGSize screenSize = [[CCDirector sharedDirector] screenSize];
  current_.x = current_.x + velocity_.x;
  if (current_.x > screenSize.width) {
    current_.x = current_.x - screenSize.width;
  } else if(current_.x < -screenSize.width) {
    current_.x = screenSize.width + current_.x;
  }
  
  current_.y = current_.y - velocity_.y;
  if (current_.y > screenSize.height) {
    current_.y = current_.y + screenSize.height;
  } else if(current_.y < -screenSize.height) {
    current_.y = screenSize.height + current_.y;
  }
  
  int x = 0 > velocity_.x ? 1 : -1;
  int y = 0 > velocity_.y ? 1 : -1;
  
  for (CCSprite* background in backgrounds_) {
    background.position = ccpAdd(background.position, self.velocity.point);
    if (abs(background.position.x) > screenSize.width) {
      background.position = ccp(background.position.x + x * (background.textureRect.size.width * col_ - 1), 
                                background.position.y);
    }
    if (abs(background.position.y) > screenSize.height) {
      background.position = ccp(background.position.x,
                                background.position.y + y * (background.textureRect.size.height * row_ - 1));
    }
  }
}

- (CCSpriteBatchNode*)generateSprites:(CCTexture2D *)texture {
  original_ = texture;
  CGSize original = texture.contentSize;
  CGSize screenSize = [[CCDirector sharedDirector] screenSize];
  col_ = ceil(screenSize.width / original.width) + 1;
  row_ = ceil(screenSize.height / original.height) + 1;
  CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithTexture:texture];
  for(int x = 0; x < col_; ++x) {
    for(int y = 0; y < row_; ++y) {
      CCSprite* sprite = [CCSprite spriteWithTexture:texture];
      [backgrounds_ addObject:sprite];
      sprite.anchorPoint = ccp(0, 0);
      sprite.position = ccp(original.width * x, 
                            original.height * y);
      [batch addChild:sprite];
    }
  }
  return batch;
}

- (KWVector*)velocity {
  return velocity_;
}

- (void)setVelocity:(KWVector *)velocity {
  CGSize size = original_.contentSize;
  int x = MIN(MAX(velocity.x, -size.width), size.width);
  int y = MIN(MAX(velocity.y, -size.height), size.height);
  velocity_ = velocity;
  [velocity_ set:CGPointMake(x, y)];
}

@end
