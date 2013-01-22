//
//  KWSessionDelegate.h
//  Heqet
//
//  Created by giginet on 2013/1/23.
//
//

#import <Foundation/Foundation.h>

/*
 GKSessionDelegateでは、なぜかreceiveDataがプロトコル化されていなくて非常にキモイので
 GKSessionDelegateを継承した新しいプロトコルを定義している
 */
@protocol KWSessionDelegate <GKSessionDelegate>
@optional
/**
 @brief 他のPeerからDataが届いたときコールバックされます
 @param NSData* data 届いたデータ
 @param NSString* peer 送信元peerID
 @param GKSession* session データを受け取ったセッション
 @param void* context 任意のポインタ
 @see http://developer.apple.com/library/ios/#documentation/GameKit/Reference/GKSession_Class/Reference/Reference.html
 setDataRecieveHandler
 */
- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context;
@end
