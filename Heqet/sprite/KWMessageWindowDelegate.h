//
//  KWMessageWindowDelegate.h
//  LoopyLooper
//
//  Created by  on 2012/2/17.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "kobold2d.h"
#import "KWMessageWindow.h"

@protocol KWMessageWindowDelegate <NSObject>

@optional
- (void)didUpdateText:(id)messageWindow text:(NSString*)text;
- (void)didCompleteMessage:(id)messageWindow text:(NSString*)text;
- (void)didTouchEnd:(id)messageWindow touch:(UITouch*)touch;

@end
