//
//  KWAnimation.m
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "CCAnimationExtension.h"

@implementation CCAnimation(KWExtension)

+ (id)animationWithTextures:(NSArray *)textures delay:(float)delay {
  NSMutableArray* frames = [NSMutableArray arrayWithCapacity:[textures count]];
  for(CCTexture2D* texture in textures){
    CGSize texSize = texture.contentSize;
    CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, texSize.width, texSize.height)];
    [frames addObject:frame];
  }
  return [CCAnimation animationWithFrames:textures delay:delay];
}

+ (id)animationWithFile:(NSString *)filename size:(CGSize)size delay:(float)delay {
  CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:filename];
  return [CCAnimation animationWithTextureMap:texture size:size delay:delay];
}

+ (id)animationWithFiles:(NSArray *)files delay:(float)delay {
  NSMutableArray* sprites = [NSMutableArray arrayWithCapacity:[files count]];
  for(NSString* file in files) {
    CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
    [sprites addObject:texture];
  }
  return [CCAnimation animationWithTextures:sprites delay:delay];
}

+ (id)animationWithTextureMap:(CCTexture2D *)texture size:(CGSize)size delay:(float)delay {
  CGSize texSize = [texture contentSize];
  int col = texSize.width / size.width;
  int row = texSize.height / size.height;
  int frameCount = col * row;
  NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
  for(int i = 0; i < frameCount; ++i){
    CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture 
                                                      rect:CGRectMake(size.width * (i % col),
                                                                      size.height * (i % row),
                                                                      size.width, 
                                                                      size.height)];
    [frames addObject:frame];
  }
  return [CCAnimation animationWithFrames:frames delay:delay];
}

@end
