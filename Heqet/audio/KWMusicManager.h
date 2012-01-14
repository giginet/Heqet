//
//  KWMusicManager.h
//  Heqet
//
//  Created by  on 12/01/11.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KWSingleton.h"
#import "ObjectAL.h"

@interface KWMusicManager : OALSimpleAudio <AVAudioPlayerDelegate> {
  BOOL loop_;
  BOOL isIntro_;
  NSString* introPath_;
  NSString* loopPath_;
}

+ (KWMusicManager*)sharedManager;
- (BOOL)playBGWithLoopFile:(NSString*)loopFile introFile:(NSString*)introFile;
- (void)preloadLoopFile:(NSString*)loopFile introFile:(NSString*)introFile;

@property(readonly) BOOL isIntro;
@end
