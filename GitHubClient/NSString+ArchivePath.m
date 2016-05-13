//
//  NSString+ArchivePath.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/12.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "NSString+ArchivePath.h"
#import "NSString+MD5.h"

@implementation NSString (ArchivePath)

+ (NSString *)etagPathDirectoryFromRequestURL:(NSString *)url {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths lastObject];
    return [documentPath stringByAppendingPathComponent:[url md5]];
}

+ (NSString *)etagPathFromRequestURL:(NSString *)url {
    return [[NSString etagPathDirectoryFromRequestURL:url] stringByAppendingPathComponent:@"etag.archive"];
}

+ (NSString *)cachePathDirectoryFromRequestURL:(NSString *)url {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths lastObject];
    return [documentPath stringByAppendingPathComponent:[url md5]];
}

+ (NSString *)cachePathFromRequestURL:(NSString *)url {
    return [[NSString cachePathDirectoryFromRequestURL:url] stringByAppendingPathComponent:@"cache.archive"];
}

@end
