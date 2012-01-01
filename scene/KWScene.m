//
//  KWScene.m
//  Heqet
//
//  Created by giginet on 11/05/30.
//  Copyright 2011 Kawaz. All rights reserved.
//

#import "KWScene.h"


@implementation KWScene
@synthesize backgroundColor=backgroundColor_;

- (id)init{
  if( (self = [super init]) ){
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLayerColor* bg = [CCLayerColor layerWithColor:backgroundColor_
                                              width:winSize.width
                                             height:winSize.height];
    [self addChild:bg];
    [self schedule:@selector(update:)];
  }
  return self;
}

+ (CCScene*)scene {
  CCScene* scene = [CCScene node];
  CCLayer* layer = [[self class] node];
  [scene addChild:layer];
  return scene;
}

-(void) registerWithTouchDispatcher{ 
  [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
                                                   priority:0 
                                            swallowsTouches:YES];
}

- (void)update:(ccTime)dt{
}

@end
