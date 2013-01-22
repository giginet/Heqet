//
//  KWMovieLogoLayer.m
//  MultipleSession
//
//  Created by giginet on 2013/1/23.
//
//

#import "KWMovieLogoLayer.h"

@implementation KWMovieLogoLayer

- (void)buildLogo {
  [CCVideoPlayer setDelegate:self];
  UIDeviceOrientation deviceOrientation = (UIDeviceOrientation)UIDeviceOrientationLandscapeLeft;
  [CCVideoPlayer updateOrientationWithOrientation: deviceOrientation];
  [CCVideoPlayer playMovieWithFile: @"kawaz.mp4"];
}

#pragma mark CCMoviePlayerDelegate

- (void)movieStartsPlaying {
  
}

- (void)moviePlaybackFinished {
  [self goToNext];
}

@end
