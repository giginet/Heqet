//
//  LogoLayer.m
//  Heqet
//
//  Created by  on 12/01/01.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "LogoLayer.h"
#import "HelloWorldLayer.h"

@interface LogoLayer()
-(void)goToNext;
@end

@implementation LogoLayer
@synthesize nextScene=nextScene_;

-(id)init{
	self.backgroundColor = ccc4(255, 255, 255, 255);
  if( (self = [super init]) ) {
    self.nextScene = nil;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    KWSprite* logo = [KWSprite spriteWithFile:@"kawaz.png"];
    logo.position = ccp(winSize.width/2, winSize.height/2);
    logo.opacity = 0;
    id fadeIn = [CCFadeIn actionWithDuration:2];
    id wait = [CCMoveBy actionWithDuration:2];
    id fadeOut = [CCFadeOut actionWithDuration:2];
    id toNext = [CCCallFunc actionWithTarget:self 
                                    selector:@selector(goToNext)];
    CCSequence* seq = [CCSequence actions:fadeIn, wait, fadeOut, toNext, nil];
    [logo runAction:seq];
    [self addChild:logo];
    self.isTouchEnabled = YES;
    self.nextScene = [HelloWorldLayer scene];
  }
	return self;
}

-(void) registerWithTouchDispatcher{
  [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
                                                   priority:0 
                                            swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
  return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
  [self goToNext];
}

- (void)goToNext{
  CCScene* scene = self.nextScene;
  CCTransitionFade* transition = [CCTransitionFade transitionWithDuration:0.5f 
                                                                    scene:scene];
  [[CCDirector sharedDirector] replaceScene:transition];
}

@end
