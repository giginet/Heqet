//
//  NSArrayExtension.m
//  Heqet
//
//  Created by  on 11/12/27.
//  Copyright (c) 2011年 Kawaz. All rights reserved.
//

#import "NSArrayExtension.h"

@implementation NSArray (NSArrayExtension)

- (NSArray *)mapUsingBlock:(void (^)(id))block {
  NSMutableArray* newArray = [NSMutableArray array];
  [self enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop){
    id obj = item;
    [newArray addObject:obj];
  }];
  return [NSArray arrayWithArray:newArray];
}

@end
