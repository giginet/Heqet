//
//  KWShadowLabelTTF.h
//  Heqet
//
//  Created by  on 2012/3/29.
//  Copyright (c) 2012 Kawaz. All rights reserved.
//

#import "CCLabelTTF.h"

@interface KWShadowLabelTTF : CCLabelTTF {
  CCLabelTTF* shadowLabel_;
}

@property(readwrite) CGPoint offset;
@property(readwrite) ccColor3B shadowColor;

@end
