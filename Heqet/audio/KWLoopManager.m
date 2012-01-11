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
  return [[self class] shared];
}

- (void)setWithIntro:(NSString *)introPath loopFile:(NSString *)loopPath {
  OALSimpleAudio* sa = [OALSimpleAudio sharedInstance];
  introPath_ = introPath;
  loopPath_ = loopPath;
  isIntro_ = true;
  sa.backgroundTrack.delegate = self;
  [sa preloadBg:loopPath];
  [sa preloadBg:introPath];
}

- (void)playLoop {
  OALSimpleAudio* sa = [OALSimpleAudio sharedInstance];
  [sa playBg:introPath_ loop:NO];
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
