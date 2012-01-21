//
//  KWScrollLayer.h
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 2012/1/22.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "kobold2d.h"

#import "KWVector.h"

@interface KWScrollLayer : CCLayer {
  CGPoint current_;
  KWVector* velocity_;
  CCTexture2D* original_;
  NSMutableArray* backgrounds_;
}

@property(readwrite, strong) KWVector* velocity;
@property(readwrite, strong) CCTexture2D* original;

+ (id)layerWithFile:(NSString*)file;
+ (id)layerWithTexture:(CCTexture2D*)texture;

- (id)initWithFile:(NSString*)file;
- (id)initWithTexture:(CCTexture2D*)texture;

@end
