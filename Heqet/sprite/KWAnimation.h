//
//  KWAnimation.h
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "heqet.h"

@interface KWAnimation : NSObject {
}

+ (id)spriteWithArray:(NSArray*)textures delay:(float)delay;
+ (id)spriteWithFile:(NSString *)filename size:(CGSize)size delay:(float)delay;
+ (id)spriteWithFiles:(NSArray*)files delay:(float)delay;
+ (id)spriteWithTextureAtlas:(CCTexture2D *)texture size:(CGSize)size delay:(float)delay;
+ (id)spriteWithSpriteFrames:(NSArray*)frames delay:(float)delay;

@end
