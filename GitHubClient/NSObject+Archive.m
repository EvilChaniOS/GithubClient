//
//  NSObject+Archive.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NSObject+Archive.h"
#import <objc/runtime.h>

@implementation NSObject (Archive)

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const void *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0 ; i < outCount; i++) {
            Ivar ivar = ivars[i];
            const void *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
