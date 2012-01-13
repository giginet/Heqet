//
//  NSArrayExtension.m
//  Heqet
//
//  Created by  on 11/12/27.
//  Copyright (c) 2011 Kawaz. All rights reserved.
//

#import "NSArrayExtension.h"

@implementation NSArray (NSArrayExtension)

- (id)at:(NSInteger)index {
  if (index < 0) {
    index = [self count] + index;
  }
  return [self objectAtIndex:index];
}

- (NSArray *)mapUsingBlock:(id (^)(id, int))__block block {
  NSMutableArray* newArray = [NSMutableArray array];
  [self enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop){
    id obj = block(item, idx);
    [newArray addObject:obj];
  }];
  return newArray;
}

- (NSArray *)filterUsingBlock:(BOOL (^)(id, int))block {
  int count = [self count];
  NSMutableArray* newArray = [NSMutableArray array];
  for (int i = 0; i < count; ++i) {
    id obj = [self objectAtIndex:i];
    if (block(obj, i)) {
      [newArray addObject:[self objectAtIndex:i]];
    }
  }
  return newArray;
}

- (id)reduceUsingBlock:(id (^)(id, id, int))block {
  NSAssert1([self count] > 0, @"Array is Empty: %@", self);
  id result = [self objectAtIndex:0];
  for (int i = 1; i < (int)[self count]; i++) {
    result = block(result, [self objectAtIndex:i], i);
  }
  return result;
}

- (NSArray *)shuffle {
  NSMutableArray* newArray = [NSMutableArray arrayWithArray:self];
  int count = [self count];
  for (int i = 0; i < count; ++i) {
    int index = rand() % count;
    [newArray exchangeObjectAtIndex:i withObjectAtIndex:index];
  }
  return newArray;
}

- (id)objectAtRandom {
  int index = rand() % [self count];
  return [self objectAtIndex:index];
}

- (NSArray *)objectsAtRandom:(int)k {
  NSMutableArray* newArray = [NSMutableArray arrayWithArray:[self shuffle]];
  [newArray removeObjectsInRange:NSMakeRange(k, (int)[self count] - 1)];
  return newArray;
}

- (NSString *)joinObjects:(NSString *)separator {
  return (NSString*)[self reduceUsingBlock:^(id result, id obj, int idx) {
    NSString* description = [obj description];
    return [NSString stringWithFormat:@"%@%@%@", result, separator, description];
  }];
}

@end
