//
//  KWLoopAudioTrack.m
//  Spring
//
//  Created by  on 2012/6/26.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWLoopAudioTrack.h"

@implementation KWLoopAudioTrack
@synthesize intro;
@synthesize introTrack;
@synthesize loopTrack;
@synthesize volume;
@synthesize track;

+ (id)trackWithIntro:(NSString *)introFile loop:(NSString *)loopFile {
  return [[[self class] alloc] initWithIntro:introFile loop:loopFile];
}

- (id)initWithIntro:(NSString *)introFile loop:(NSString *)loopFile {
  self = [super init];
  if (self) {
    introTrack = [OALAudioTrack track];
    [introTrack preloadFile:introFile];
    loopTrack = [OALAudioTrack track];
    [loopTrack preloadFile:loopFile];
    loopTrack.numberOfLoops = -1;
    intro = YES;
  }
  return self;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  [self.loopTrack play];
  intro = NO;
}

- (OALAudioTrack*)track {
  return intro ? introTrack : loopTrack;
}

- (bool)play {
  if (intro) {
    [loopTrack playAfterTrack:introTrack timeAdjust:0.1];
  }
  return [self.track play];
}

- (void)stop {
  intro = YES;
  [self.track stop];
}

- (float)volume {
  return [[self track] volume];
}

- (void)setVolume:(float)v {
  self.loopTrack.volume = v;
  self.introTrack.volume = v;
}

@end
