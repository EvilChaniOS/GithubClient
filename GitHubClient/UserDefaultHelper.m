//
//  UserDefaultHelper.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "UserDefaultHelper.h"

static NSString * const kAccessToken = @"kAccessToken";
@implementation UserDefaultHelper

+ (void)setToekn:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getToken {
   return [[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
}

@end
