//
//  PinYinForObjc.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanyuPinyinOutputFormat.h"
#import "PinyinHelper.h"

@interface PinYinForObjc : NSObject

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;//转换为拼音
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;//转换为拼音首字母

@end
