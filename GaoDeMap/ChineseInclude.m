//
//  ChineseInclude.m
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChineseInclude.h"

@implementation ChineseInclude
+(BOOL)inIncludeChineseInString:(NSString *)str{
    for (int i = 0; i < str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch && ch < 0x9fff) {//判断NSString中的字符是不是为中文
            return true;
        }
    }
    return false;
};
@end
