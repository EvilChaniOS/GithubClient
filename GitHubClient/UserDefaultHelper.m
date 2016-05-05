//
//  UserDefaultHelper.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "UserDefaultHelper.h"

static NSString * const kAccessToken = @"kAccessToken";
static NSString * const kEtag = @"kEtag";

@implementation UserDefaultHelper

+ (void)setToken:(NSString *)token {
    NSAssert(token.length > 0, @"token is nill");
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getToken {
   return [[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
}

+ (void)setEtag:(NSString *)etag {
    NSAssert(etag.length > 0, @"Etag is nill");
    [[NSUserDefaults standardUserDefaults] setObject:etag forKey:kEtag];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getEtag {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kEtag];
}

@end
