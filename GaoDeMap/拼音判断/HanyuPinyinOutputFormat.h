//
//  HanyuPinyinOutputFormat.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//
#ifndef _HanyuPinyinOutputFormat_H_ //测试是否被宏定义过 如果x没有被宏定义过，定义，并编译程序段
#define _HanyuPinyinOutputFormat_H_


#import <Foundation/Foundation.h>

typedef enum {
    ToneTypeWithToneNumber,
    ToneTypeWithoutTone,
    ToneTypeWithToneMark
}ToneType;

typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;

typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;

@interface HanyuPinyinOutputFormat : NSObject

@property (nonatomic, assign)VCharType vCharType;
@property (nonatomic, assign)CaseType caseType;
@property (nonatomic, assign)ToneType toneType;

- (id)init;
- (void)restoreDefault;


@end

#endif