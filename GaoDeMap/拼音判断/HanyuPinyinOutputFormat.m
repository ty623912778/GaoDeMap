//
//  HanyuPinyinOutputFormat.m
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HanyuPinyinOutputFormat.h"

@implementation HanyuPinyinOutputFormat
@synthesize vCharType = _vCharType;
@synthesize caseType = _caseType;
@synthesize toneType = _toneType;

- (id)init{
    if (self = [super init]) {
        [self restoreDefault];
    }
    return self;
}

- (void)restoreDefault{
    _vCharType = VCharTypeWithUAndColon;
    _caseType = CaseTypeLowercase;
    _toneType = ToneTypeWithToneNumber;
}


@end
