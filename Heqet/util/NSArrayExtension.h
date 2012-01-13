//
//  NSArrayExtension.h
//  Heqet
//
//  Created by  on 11/12/27.
//  Copyright (c) 2011 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSArrayExtension)

- (id)at:(NSInteger)index;
- (NSArray *)mapUsingBlock:(id (^)(id, int))__block block;
- (NSArray *)filterUsingBlock:(BOOL (^)(id, int))block;
- (id)reduceUsingBlock:(id (^)(id, id, int))block;
- (NSArray *)shuffle;
- (id)objectAtRandom;
- (NSArray *)objectsAtRandom:(int)k;
- (NSString *)joinObjects:(NSString *)separator;

@end
