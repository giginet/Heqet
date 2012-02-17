//
//  KWAnimation.h
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "kobold2d.h"

@interface CCAnimation(KWExtension)
+ (id)animationWithFile:(NSString *)filename size:(CGSize)size delay:(float)delay;
+ (id)animationWithFiles:(NSArray*)files delay:(float)delay;
+ (id)animationWithTextureMap:(CCTexture2D *)texture size:(CGSize)size delay:(float)delay;
+ (id)animationWithTextures:(NSArray*)textures delay:(float)delay;
@end
