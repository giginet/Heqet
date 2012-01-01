//
//  KWLogoScene.h
//  Heqet
//
//  Created by  on 12/01/01.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWScene.h"
#import "KWSprite.h"

@interface KWLogoScene : KWScene{
  CCScene* nextScene_;
}

+ (CCScene*)sceneWithNextScene:(CCScene*)nextScene;

@property(readwrite, retain) CCScene* nextScene;
@end
