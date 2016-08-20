//
//  PinyinFormatter.h
//  GaoDeMap
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 mac. All rights reserved.
//


#ifndef _PinyinFormatter_H_
#define _PinyinFormatter_H_

@class HanyuPinyinOutputFormat;

#import <Foundation/Foundation.h>

@interface PinyinFormatter : NSObject {
}

+ (NSString *)formatHanyuPinyinWithNSString:(NSString *)pinyinStr
                withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat;
+ (NSString *)convertToneNumber2ToneMarkWithNSString:(NSString *)pinyinStr;
- (id)init;
@end

#endif
