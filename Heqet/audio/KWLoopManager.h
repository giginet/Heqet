//
//  KWLoopManager.h
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 12/01/11.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KWSingleton.h"
#import "ObjectAL.h"

@interface KWLoopManager : KWSingleton <AVAudioPlayerDelegate> {
  BOOL isIntro_;
  NSString* introPath_;
  NSString* loopPath_;
}

+ (id)sharedManager;
- (void)setWithIntro:(NSString*)introPath loopFile:(NSString*)loopPath;
- (void)playLoop;

@property(readonly) BOOL isIntro;
@end
