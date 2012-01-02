//
//  LogoLayer.h
//  Heqet
//
//  Created by  on 12/01/01.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWLayer.h"
#import "KWSprite.h"

@interface LogoLayer : KWLayer{
  CCScene* nextScene_;
}

@property(readwrite, retain) CCScene* nextScene;
@end
