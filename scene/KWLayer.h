//
//  KWLayer.h
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KWLayer : CCLayer {
 @private
  ccColor4B backgroundColor_;
}

+ (CCScene*)scene;
- (void)update:(ccTime)dt;

@property(readwrite) ccColor4B backgroundColor;
@end
