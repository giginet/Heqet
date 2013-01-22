//
//  KWSessionManager.m
//  Heqet
//
//  Created by giginet on 2013/1/23.
//
//

#import "KWSessionManager.h"

@implementation KWSessionManager

const NSTimeInterval kDefaultConnectionTimeoutInterval = 5.0f;
const NSTimeInterval kDefaultDisconnectionTimeoutInterval = 5.0f;

+ (id)sharedManager {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[[self class] alloc] init];
  });
  return sharedInstance;
}

- (id)init {
  self = [super init];
  if (self) {
    _session = nil;
    _initialize = NO;
  }
  return self;
}

- (void)startSession:(NSString *)sessionID sessionMode:(GKSendDataMode)mode {
  if (!_initialize) {
    _session = [[GKSession alloc] initWithSessionID:sessionID displayName:nil sessionMode:mode];
    self.connectionTimeoutInterval = kDefaultConnectionTimeoutInterval;
    self.disconnectionTimeoutInterval = kDefaultDisconnectionTimeoutInterval;
    _initialize = YES;
  }
}

- (void)available {
  if (_initialize) {
    _session.available = YES;
  }
}

- (void)disable {
  if (_initialize) {
    _session.available = NO;
  }
}

- (void)connectToPeer:(NSString *)peerID {
  [_session connectToPeer:peerID withTimeout:self.connectionTimeoutInterval];
}

- (void)disconnectFromPeer:(NSString *)peerID {
  [_session disconnectPeerFromAllPeers:peerID];
}

- (NSError*)sendDataToPeer:(NSData *)data to:(NSString *)peerID mode:(GKSendDataMode)mode {
  NSError* err = nil;
  [_session sendData:data toPeers:[NSArray arrayWithObject:peerID] withDataMode:mode error:&err];
  return err;
}

- (NSError*)broadCastData:(NSData *)data mode:(GKSendDataMode)mode {
  NSError* err = nil;
  [_session sendDataToAllPeers:data withDataMode:mode error:&err];
  return err;
}

- (NSError*)sendStringToPeer:(NSString *)string to:(NSString *)peerID mode:(GKSendDataMode)mode {
  NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
  return [self sendDataToPeer:data to:peerID mode:mode];
}

- (NSError*)broadCastString:(NSString *)string mode:(GKSendDataMode)mode {
  NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
  return [self broadCastData:data mode:mode];
}

- (BOOL)isConnectedWith:(NSString *)peerID {
  return [[_session peersWithConnectionState:GKPeerStateConnected] containsObject:peerID];
}

- (NSTimeInterval)disconnectionTimeoutInterval {
  return _session.disconnectTimeout;
}

- (void)setDisconnectionTimeoutInterval:(NSTimeInterval)disconnectionTimeoutInterval {
  _session.disconnectTimeout = disconnectionTimeoutInterval;
}

@end