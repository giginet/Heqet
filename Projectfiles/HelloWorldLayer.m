/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

@synthesize helloWorldString, helloWorldFontName;
@synthesize helloWorldFontSize;

-(id) init {
	if ((self = [super init])) {
		CCLOG(@"%@ init", NSStringFromClass([self class]));
		
		CCDirector* director = [CCDirector sharedDirector];
		
		CCSprite* sprite = [CCSprite spriteWithFile:@"ship.png"];
		sprite.position = director.screenCenter;
		sprite.scale = 0;
		[self addChild:sprite];
		
		id scale = [CCScaleTo actionWithDuration:1.0f scale:1.6f];
		[sprite runAction:scale];
		id move = [CCMoveBy actionWithDuration:1.0f position:CGPointMake(0, -120)];
		[sprite runAction:move];
    
		// get the hello world string from the config.lua file
		[KKConfig injectPropertiesFromKeyPath:@"HelloWorldSettings" target:self];
		
		CCLabelTTF* label = [CCLabelTTF labelWithString:helloWorldString 
                                           fontName:helloWorldFontName 
                                           fontSize:helloWorldFontSize];
		label.position = director.screenCenter;
		label.color = ccGREEN;
		[self addChild:label];
    
		// print out which platform we're on
		NSString* platform = @"(unknown platform)";
		
		if (director.currentPlatformIsIOS) {
			// add code 
			platform = @"iPhone/iPod Touch";
			
			if (director.currentDeviceIsIPad)
				platform = @"iPad";
      
			if (director.currentDeviceIsSimulator)
				platform = [NSString stringWithFormat:@"%@ Simulator", platform];
      }
		else if (director.currentPlatformIsMac) {
			platform = @"Mac OS X";
      }
		
		CCLabelTTF* platformLabel = nil;
		if (director.currentPlatformIsIOS) {
			// use kobold.ttf truetype font, see kobold.txt for licensing info
			float fontSize = (director.currentDeviceIsIPad) ? 48 : 28;
			platformLabel = [CCLabelTTF labelWithString:platform 
                                         fontName:@"koboldc.ttf" 
                                         fontSize:fontSize];
      }
		else if (director.currentPlatformIsMac) {
			// Mac builds have to rely on fonts installed on the system.
			platformLabel = [CCLabelTTF labelWithString:platform 
                                         fontName:@"Zapfino" 
                                         fontSize:32];
      }
    
		platformLabel.position = director.screenCenter;
		platformLabel.color = ccYELLOW;
		[self addChild:platformLabel];
		
		id movePlatform = [CCMoveBy actionWithDuration:0.2f 
                                          position:CGPointMake(0, 50)];
		[platformLabel runAction:movePlatform];
    
    [[KWLoopManager shared] setWithIntroFile:@"hurry_int.caf" loopFile:@"hurry.caf"];
    KWTimerLabel* tLabel = [KWTimerLabel labelWithHour:0 minute:0 second:10];
    [self addChild:tLabel];
    [tLabel play];
    tLabel.position = ccp(100, 100);
    tLabel.displayMiliSecond = YES;
    chart_ = [KWPieChart chartWithRadius:30 color:ccc3(1, 0, 0)];
    chart_.position = ccp(100, 100);
    chart_.rate = 0.0;
    [self addChild:chart_];
    gauge_ = [[KWGauge alloc] initWithColor:ccc3(0, 1, 0) andSize:CGSizeMake(200, 20)];
    gauge_.position = ccp(200, 200);
    [self addChild:gauge_];
    glClearColor(0.2f, 0.2f, 0.4f, 1.0f);
  }
	return self;
}

- (void)onEnterTransitionDidFinish {
  //[[KWLoopManager sharedManager] play];
}

- (void)update:(ccTime)dt {
  chart_.rate += 0.01;
  gauge_.rate -= 0.001;
}

@end
