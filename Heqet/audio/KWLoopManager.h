//
//  KWLoopManager.h
//  Heqet
//
//  Created by  on 12/01/11.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KWSingleton.h"
#import "ObjectAL.h"

@interface KWLoopManager : KWSingleton <AVAudioPlayerDelegate> {
  BOOL isIntro_;
  NSString* introPath_;
  NSString* loopPath_;
}

+ (KWLoopManager*)sharedManager;
- (void)setWithIntroFile:(NSString*)introPath loopFile:(NSString*)loopPath;
- (void)play;
- (void)stop;

@property(readonly) BOOL isIntro;
@end
