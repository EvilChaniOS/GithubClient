//
//  UserDefaultHelper.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "UserDefaultHelper.h"
#import "NSString+ArchivePath.h"

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


+ (BOOL)archiveRequestEtag:(NSString *)etag withUrl:(NSString *)url {
    NSString *etagPathDirectory = [NSString etagPathDirectoryFromRequestURL:url];
    if (![[NSFileManager defaultManager] fileExistsAtPath:etagPathDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:etagPathDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSKeyedArchiver archiveRootObject:etag toFile:[NSString etagPathFromRequestURL:url]];
    
}

+ (NSString *)getArchivedEtagWithURL:(NSString *)url {
    NSString *etagPath = [NSString etagPathFromRequestURL:url];
    return (NSString *)[NSKeyedUnarchiver unarchiveObjectWithFile:etagPath];
}

+ (id)getArchivedCacheWithURL:(NSString *)url {
    NSString *cachePath = [NSString cachePathFromRequestURL:url];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
}

+ (BOOL)archiveRequestResponse:(id)responseObject withURL:(NSString *)url {
    NSString *cachePathDirectory = [NSString cachePathDirectoryFromRequestURL:url];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePathDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePathDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSKeyedArchiver archiveRootObject:responseObject toFile:[NSString cachePathFromRequestURL:url]];
}

@end
