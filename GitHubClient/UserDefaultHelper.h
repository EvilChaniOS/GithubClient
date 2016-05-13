//
//  UserDefaultHelper.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultHelper : NSObject

+ (void)setToken:(NSString *)token;
+ (NSString *)getToken;

//+ (void)setEtag:(NSString *)etag;
//+ (NSString *)getEtag;


+ (BOOL)archiveRequestEtag:(NSString *)etag withUrl:(NSString *)url;
+ (NSString *)getArchivedEtagWithURL:(NSString *)url;

+ (id)getArchivedCacheWithURL:(NSString *)url;
+ (BOOL)archiveRequestResponse:(id)responseObject withURL:(NSString *)url;

@end
