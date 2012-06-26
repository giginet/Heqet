//
//  KWLoopAudioTrack.h
//  Spring
//
//  Created by  on 2012/6/26.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "OALAudioTrack.h"

@interface KWLoopAudioTrack : NSObject <AVAudioPlayerDelegate> {
}

@property(readonly) BOOL intro;
@property(readonly, strong) OALAudioTrack* introTrack;
@property(readonly, strong) OALAudioTrack* loopTrack;
@property(readonly) OALAudioTrack* track;
@property(readwrite) float volume;

+ (id)trackWithIntro:(NSString*)introFile loop:(NSString*)loopFile;
- (id)initWithIntro:(NSString*)introFile loop:(NSString*)loopFile;
- (bool)play;
- (void)stop;

@end
