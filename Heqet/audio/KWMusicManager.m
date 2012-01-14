//
//  KWLoopManager.m
//  
//
//  Created by  on 12/01/11.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWMusicManager.h"

@implementation KWMusicManager
@synthesize isIntro = isIntro_;

+ (id)sharedInstance {
  return (KWMusicManager*)[[[self class] alloc] init];
}

- (id)init {
  self = [super init];
  if (self) {
    isIntro_ = NO;
    introPath_ = nil;
    loopPath_ = nil;
    loop_ = YES;
  }
  return self;
}

+ (KWMusicManager*)sharedManager {
  return (KWMusicManager*)[KWMusicManager sharedInstance];
}

- (BOOL)playBGWithLoopFile:(NSString *)loopFile introFile:(NSString *)introFile {
  loop_ = YES;
  isIntro_ = YES;
  introPath_ = introFile;
  loopPath_ = loopFile;
  self.backgroundTrack.delegate = self;
  return [self.backgroundTrack playFile:introPath_ loops:0];
}

- (void)preloadLoopFile:(NSString *)loopFile introFile:(NSString *)introFile {
  introPath_ = introFile;
  loopPath_ = loopFile;
  isIntro_ = NO;
  self.backgroundTrack.delegate = self;
  [self preloadBg:loopFile];
  [self preloadBg:introFile];
}

- (bool)playBg:(NSString*) filePath loop:(bool) loop {
  introPath_ = nil;
  loopPath_ = nil;
  return [self playBgWithLoop:loop];
}

- (bool)playBgWithLoop:(_Bool)loop {
  loop_ = loop;
  if (loopPath_ && introPath_) {
    isIntro_ = YES;
    return [self.backgroundTrack playFile:introPath_ loops:0];
  } else {
    isIntro_ = NO;
    return [super playBgWithLoop:loop];
  }
}

- (bool)playBg:(NSString*) filePath
         volume:(float) volume
            pan:(float) pan
           loop:(bool) loop
{
  isIntro_ = NO;
	loopPath_ = nil;
  introPath_ = nil;
  return [super playBg:filePath volume:volume pan:pan loop:loop];
}

- (bool) playBg {
	return [self playBgWithLoop:YES];
}

- (void)stopBg {
  isIntro_ = NO;
  [super stopBg];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  if (!flag) return;
  if (self.isIntro) {
    isIntro_ = NO;
    [self.backgroundTrack playFile:loopPath_ loops:loop_ ? -1 : 0];
  }
}

@end
