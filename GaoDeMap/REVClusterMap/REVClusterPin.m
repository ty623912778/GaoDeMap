//
//  REVClusterPin.m
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "REVClusterPin.h"

@implementation REVClusterPin

@synthesize title,coordinate,subtitle;
@synthesize nodes;

- (NSUInteger)nodeCount
{
    if (nodes) {
        return [nodes count];
    }
        return 0;
    
}

#if !__has_feature(objc_arc)
- (void)dealloc{
    [title release];
    [subtitle release];
    [nodes release];
    [super dealloc];
}

#endif
@end
