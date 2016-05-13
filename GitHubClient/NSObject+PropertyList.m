//
//  NSObject+PropertyList.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/13.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "NSObject+PropertyList.h"
#import <objc/runtime.h>

@implementation NSObject (PropertyList)

// 1.1
// 通过class_copyIvarList方法获取到的是“成员变量”，如 _name _stargazers_count , _owner 需要截取字符串去掉“_”
//- (NSArray *)getObjectProperties {
//    
//    NSMutableArray *properties = [NSMutableArray array];
//    unsigned int outCount;
//    Ivar *ivars =  class_copyIvarList([self class], &outCount);
//    for (int i = 0; i < outCount; i++) {
//        Ivar ivar = ivars[i];
//        const char *name = ivar_getName(ivar);
//        NSString *propertyName = [NSString stringWithUTF8String:name];
//        
//        [properties addObject:propertyName];
//    }
//
//    return [properties copy];
//}

// 通过 class_copyPropertyList 直接获取对象“属性”
- (NSArray *)getClassProperties {
    NSMutableArray *keyArray = [NSMutableArray array];
    uint propertyCount;
    objc_property_t *ps = class_copyPropertyList([self class], &propertyCount);
    for (uint i = 0; i < propertyCount; i++) {
        objc_property_t property = ps[i];
        const char *propertyName = property_getName(property);
        
        [keyArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    return [keyArray copy];
}

// 目的:将对象的属性转为对应的字典
- (NSDictionary *)generateModelDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    // 1.获取对象所有属性
    NSArray *properties = [self getClassProperties];
    // 2.根据属性key获取对应的值value
    for (NSString *key in properties) {
        id value = [self valueForKey:key];
        if (value != nil) {
            [dictionary setValue:value forKey:key];
        }
    }
    // 3.返回模型对应的字典
    return [dictionary copy];
}

@end
