//
//  KWSessionManager.h
//  Heqet
//
//  Created by giginet on 2013/1/23.
//
//

#import <Foundation/Foundation.h>
#import "KWSessionDelegate.h"

@interface KWSessionManager : NSObject {
  BOOL _initialize;
  id<KWSessionDelegate> _delegate;
}

+ (id)sharedManager;
- (void)startSession:(NSString*)sessionID sessionMode:(GKSendDataMode)mode;
- (void)available;
- (void)disable;
- (void)connectToPeer:(NSString*)peerID;
- (void)disconnectFromPeer:(NSString*)peerID;
- (NSError*)sendDataToPeer:(NSData*)data to:(NSString*)peerID mode:(GKSendDataMode)mode;
- (NSError*)broadCastData:(NSData*)data mode:(GKSendDataMode)mode;
- (NSError*)sendStringToPeer:(NSString*)string to:(NSString*)peerID mode:(GKSendDataMode)mode;
- (NSError*)broadCastString:(NSString*)string mode:(GKSendDataMode)mode;
- (BOOL)isConnectedWith:(NSString*)peerID;

@property(readwrite) NSTimeInterval connectionTimeoutInterval;
@property(readwrite) NSTimeInterval disconnectionTimeoutInterval;
@property(readonly, strong) NSArray* availablePeers;
@property(readonly, strong) NSArray* connectedPeers;
@property(readonly, strong) GKSession* session;
@property(readwrite, weak) id<KWSessionDelegate> delegate;

@end
