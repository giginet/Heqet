//
//  KWLayer.m
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWLayer.h"


@implementation KWLayer
@synthesize backgroundColor=backgroundColor_;

- (id)init{
  if( (self = [super init]) ){
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLayerColor* bg = [CCLayerColor layerWithColor:backgroundColor_
                                              width:winSize.width
                                             height:winSize.height];
    [self addChild:bg];
    [self scheduleUpdate];
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

- (void)update:(ccTime)dt{
}

@end
