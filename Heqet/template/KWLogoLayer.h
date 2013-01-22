//
//  KWLogoLayer.h
//  Spring
//
//  Created by  on 2012/7/6.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "kobold2d.h"
#import "KWLayer.h"

@interface KWLogoLayer : KWLayer

@property(readwrite, strong) Class nextLayerClass;

- (id)initWithNext:(Class)next;
- (void)buildLogo;
- (void)goToNext;

@end
