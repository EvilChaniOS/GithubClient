//
//  NSString+ArchivePath.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/12.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ArchivePath)

/**
 *  Etag
 */
+ (NSString *)etagPathDirectoryFromRequestURL:(NSString *)url;
+ (NSString *)etagPathFromRequestURL:(NSString *)url;

/**
 *  Cache
 */
+ (NSString *)cachePathDirectoryFromRequestURL:(NSString *)url;
+ (NSString *)cachePathFromRequestURL:(NSString *)url;

@end
