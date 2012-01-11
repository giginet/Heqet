//
//  KWLoopManager.m
//  _Kobold2D-With-Heqet-Template_
//
//  Created by  on 12/01/11.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import "KWLoopManager.h"

@implementation KWLoopManager
@synthesize isIntro = isIntro_;

+ (id)sharedManager {
  return (KWLoopManager*)[[self class] shared];
}

- (void)setWithIntroFile:(NSString *)introPath loopFile:(NSString *)loopPath {
  OALSimpleAudio* sa = [OALSimpleAudio sharedInstance];
  introPath_ = introPath;
  loopPath_ = loopPath;
  isIntro_ = true;
  sa.backgroundTrack.delegate = self;
  [sa preloadBg:loopPath];
  [sa preloadBg:introPath];
}

- (void)play {
  OALSimpleAudio* sa = [OALSimpleAudio sharedInstance];
  [sa playBg:introPath_ loop:NO];
}

- (void)stop {
  OALSimpleAudio* sa = [OALSimpleAudio sharedInstance];
  [sa stopBg];
  isIntro_ = false;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  if (!flag) return;
  if (self.isIntro) {
    isIntro_ = false;
    OALSimpleAudio* sa = [OALSimpleAudio sharedInstance];
    [sa playBg:loopPath_ loop:YES];
  }
}

@end
