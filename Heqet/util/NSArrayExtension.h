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
- (NSArray*)mapUsingBlock:(void (^)(id))block;

@end
