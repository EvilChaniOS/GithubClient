//
//  JZUser.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "JZUser.h"
#import <objc/runtime.h>

@implementation JZUser

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

@end
