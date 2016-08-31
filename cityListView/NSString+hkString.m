//
//  NSString+hkString.m
//  Test
//
//  Created by cps on 16/7/19.
//  Copyright © 2016年 xinzhangqu. All rights reserved.
//

#import "NSString+hkString.h"

@implementation NSString (hkString)

+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

@end
