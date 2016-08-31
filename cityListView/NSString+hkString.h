//
//  NSString+hkString.h
//  Test
//
//  Created by cps on 16/7/19.
//  Copyright © 2016年 xinzhangqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hkString)

/**
 *  汉字转拼音
 *
 *  @param chinese 中文
 *
 *  @return pinyin
 */
+ (NSString *)transform:(NSString *)chinese;


@end
