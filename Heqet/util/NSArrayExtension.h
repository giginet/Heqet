//
//  NSArrayExtension.h
//  Heqet
//
//  Created by  on 11/12/27.
//  Copyright (c) 2011 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KWNSArrayExtension)

- (id)at:(NSInteger)index;
- (NSArray *)mapUsingBlock:(id (^)(id, NSUInteger))__block block;
- (NSArray *)filterUsingBlock:(BOOL (^)(id, NSUInteger))block;
- (id)reduceUsingBlock:(id (^)(id, id, NSUInteger))block;
- (NSArray *)shuffle;
- (id)objectAtRandom;
- (NSArray *)objectsAtRandom:(int)k;
- (NSString *)joinObjects:(NSString *)separator;

@end
