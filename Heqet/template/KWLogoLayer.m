//
//  KWLogoLayer.m
//  Spring
//
//  Created by  on 2012/7/6.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "kobold2d.h"
#import "KWLogoLayer.h"

@implementation KWLogoLayer
@synthesize nextLayerClass;

- (id)initWithNext:(Class)next {
  self.backgroundColor = ccc4(255, 255, 255, 255);
  if( (self = [super init]) ) {
    [self buildLogo];
    self.isTouchEnabled = YES;
    self.nextLayerClass = next;
  }
  return self;
}

- (void)buildLogo {
  CCDirector* director = [CCDirector sharedDirector];
  NSString* logoFile = @"kawaz.png";
  if (director.currentDeviceIsIPad) logoFile = @"kawaz-ipad.png";
  CCSprite* logo = [CCSprite spriteWithFile:logoFile];
  logo.position = director.screenCenter;
  logo.opacity = 0;
  id fadeIn = [CCFadeIn actionWithDuration:2];
  id wait = [CCDelayTime actionWithDuration:2];
  id fadeOut = [CCFadeOut actionWithDuration:2];
  id toNext = [CCCallFunc actionWithTarget:self
                                  selector:@selector(goToNext)];
  CCSequence* seq = [CCSequence actions:fadeIn, wait, fadeOut, toNext, nil];
  [logo runAction:seq];
  [self addChild:logo];
}

- (void) registerWithTouchDispatcher{
  [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
                                                   priority:0 
                                            swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
  return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
  [self goToNext];
}

- (void)goToNext {
  NSAssert([self.nextLayerClass isSubclassOfClass:[CCNode class]], @"nextLayerClass must be sub class of CCNode.");
  CCTransitionFade* transition = [CCTransitionFade transitionWithDuration:0.5f 
                                                                    scene:[self.nextLayerClass nodeWithScene]];
  [[CCDirector sharedDirector] replaceScene:transition];
}

@end
