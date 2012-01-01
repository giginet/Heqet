//
//  NSArray+NSArrayExtension.h
//  Heqet
//
//  Created by  on 11/12/27.
//  Copyright (c) 2011年 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSArrayExtension)

- (id)at:(NSInteger)index;
- (NSArray*)map:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;

@end
