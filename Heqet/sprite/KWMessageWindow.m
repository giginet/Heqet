//
//  KWMessageWindow.m
//  LoopyLooper
//
//  Created by  on 2012/2/17.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "KWMessageWindow.h"

@interface KWMessageWindow()
- (void)update:(ccTime)dt;
- (void)updateMessage;
- (void)onCompleteMessage;
- (void)onNextMessage:(id)timer;
@end

@implementation KWMessageWindow
@synthesize currentMessageIndex = currentMessageIndex_;
@synthesize currentTextIndex = currentTextIndex_;
@synthesize updateTextLength;
@synthesize messageSpeed = messageSpeed_;
@synthesize autoSkipDelay;
@dynamic currentMessage;
@synthesize messageLabel = messageLabel_;
@synthesize delegate;
@synthesize messages = messages_;

- (id)init {
  self = [super init];
  if (self) {
    self.currentTextIndex = 0;
    self.currentMessageIndex = 0;
    self.messageSpeed = 1.0 / [[KKStartupConfig config] maxFrameRate];
    self.autoSkipDelay = 0;
    self.updateTextLength = 1;
    messages_ = [NSMutableArray array];
    timer_ = [KWTimer timerWithMax:self.messageSpeed];
    timer_.looping = YES;
    [timer_ setOnCompleteListener:self selector:@selector(updateMessage)];
    delayTimer_ = [KWTimer timerWithMax:self.autoSkipDelay];
    [delayTimer_ setOnCompleteListener:self selector:@selector(onNextMessage:)];
  }
  return self;
}

- (id)initWithMessages:(NSArray *)messages 
             alignment:(UITextAlignment)alignment
              fontName:(NSString *)fontName 
              fontSize:(double)fontSize 
                  size:(CGSize)size {
  self = [self init];
  if (self) {
    messages_ = [NSMutableArray arrayWithArray:messages];
    messageLabel_ = [CCLabelTTF labelWithString:@"" 
                                     dimensions:size
                                      alignment:alignment
                                  lineBreakMode:UILineBreakModeCharacterWrap
                                       fontName:fontName 
                                       fontSize:fontSize];
    self.contentSize = size;
    [self addChild:messageLabel_];
  }
  return self;
}

- (double)messageSpeed {
  return messageSpeed_;
}

- (void)setMessageSpeed:(double)messageSpeed {
  messageSpeed_ = messageSpeed;
  [timer_ set:messageSpeed];
}

- (double)autoSkipDelay {
  return autoSkipDelay;
}

- (void)setAutoSkipDelay:(double)asd {
  autoSkipDelay = asd;
  [delayTimer_ set:asd];
}

- (int)currentTextIndex {
  return currentTextIndex_;
}

- (void)setCurrentTextIndex:(int)currentTextIndex {
  if(currentTextIndex >= self.currentWholeMessageLength) return;
  currentTextIndex_ = currentTextIndex;
  [messageLabel_ setString:self.currentMessage];
}

- (int)currentMessageIndex {
  return currentMessageIndex_;
}

- (void)setCurrentMessageIndex:(int)currentMessageIndex {
  if(currentMessageIndex >= (int)[messages_ count]) return;
  currentMessageIndex_ = currentMessageIndex;
  self.currentTextIndex = 0;
  [messageLabel_ setString:self.currentMessage];
  [timer_ play];
}

- (BOOL)isEndMessage {
  return self.currentTextIndex >= (int)[self currentWholeMessageLength] - 1;
}

- (BOOL)isEndMessages {
  return self.currentMessageIndex >= (int)[messages_ count] - 1;
}

- (NSInteger)currentWholeMessageLength {
  if ([messages_ count] == 0) return 0;
  return [self.currentWholeMessage length];
}

- (NSString*)currentMessage {
  if ([self isEndMessage]) return self.currentWholeMessage;
  return [(NSString*)self.currentWholeMessage substringToIndex:currentTextIndex_];
}

- (NSString*)currentWholeMessage {
  int count = [messages_ count];
  if (count == 0 || self.currentMessageIndex >= count) return @"";
  return (NSString*)[messages_ objectAtIndex:currentMessageIndex_];
}

- (void)onEnter {
  [timer_ play];
}

- (void)reset {
  self.currentTextIndex = 0;
  self.currentMessageIndex = 0;
  [self.messageLabel setString:@""];
  [timer_ reset];
  [delayTimer_ reset];
}

- (void)onNextMessage:(id)timer {
  [delayTimer_ stop];
  self.currentMessageIndex += 1;
}

- (void)update:(ccTime)dt {
}

- (void)updateMessage {
  if ([self isEndMessage]) return;
  NSString* text = @"";
  if (self.currentTextIndex + self.updateTextLength < (int)[self.currentWholeMessage length]) {
    self.currentTextIndex += self.updateTextLength;
  } else {
    self.currentTextIndex = self.currentWholeMessageLength - 1;
  }
  [self.delegate didUpdateText:self text:text];
  if ([self isEndMessage]) {
    [self onCompleteMessage];
    [timer_ stop];
  }
}

- (void)onCompleteMessage {
  [self.delegate didCompleteMessage:self text:self.currentMessage];
  if (self.autoSkipDelay) {
    delayTimer_.max = self.autoSkipDelay;
    [delayTimer_ reset];
    [delayTimer_ play];
  }
}

@end
