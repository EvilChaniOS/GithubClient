//
//  JZMyRepositories.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZMyRepository.h"
#import <objc/runtime.h>

@implementation JZMyRepository
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const void *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        
        id value = [self valueForKey:key];
        NSLog(@" value - %@",value);
        [encoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        
        for (int i = 0 ; i < outCount; i++) {
            Ivar ivar = ivars[i];
            const void *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];
            NSLog(@" aDecoder key -%@ , value - %@",key,value);
        }
        
        free(ivars);
    }
    return self;
}

- (NSString *)content {
    NSArray *randomArr = @[@"似懂非懂双方都十分的是非得失",@"插线板 v 从 v 把 v 次选拔程序必须储备说三道四的实打实的撒打算多撒点撒的撒的撒打算都撒到撒第三名，内心充满女性奶茶，现在年产值，才能，主线程，那",@"哦 i 乡村女从 v 也拔程序必须储备说三道四的实打实的撒打算多撒点撒的撒的撒打算都撒到撒第三名，内心充满女性奶茶，现在年产值，才能，主线程，那些支拔程序必须储备说三道四的实打实的撒打算多撒点撒的撒的撒打算都撒到撒第三名，内心充满女性奶茶，现在年产值，才能，主线程，那些支能经常见到定居点的计划和共和国结果结果结果结果看到乐山乐水了"];
    NSInteger i = arc4random()%3;
    return randomArr[i];
}

@end
