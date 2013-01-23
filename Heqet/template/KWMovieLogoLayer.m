//
//  KWMovieLogoLayer.m
//  MultipleSession
//
//  Created by giginet on 2013/1/23.
//
//

#import "kobold2d.h"
#import "KWMovieLogoLayer.h"
#import "MediaPlayer/MediaPlayer.h"

@implementation KWMovieLogoLayer

- (void)buildLogo {
  [CCVideoPlayer setDelegate:self];
  UIDeviceOrientation deviceOrientation = (UIDeviceOrientation)UIDeviceOrientationLandscapeLeft;
  [CCVideoPlayer updateOrientationWithOrientation: deviceOrientation];
  _rotated = NO;
  [CCVideoPlayer playMovieWithFile: @"kawaz.mp4"];
}

#pragma mark CCMoviePlayerDelegate

- (void)movieStartsPlaying {
}

- (void)moviePlaybackFinished {
  [self goToNext];
}

- (void)update:(ccTime)dt {
  if (!_rotated) {
    UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
    if ([keyWindow.subviews count] > 1 && UIInterfaceOrientationIsPortrait(keyWindow.rootViewController.interfaceOrientation)) {
      UIView* movieView = [keyWindow.subviews objectAtIndex:1];
      [movieView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
      _rotated = YES;
    }
  }
}

@end
