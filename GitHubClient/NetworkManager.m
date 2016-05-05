//
//  NetworkManager.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NetworkManager.h"
#import "HTTPManager.h"
#import "GitHubConfigure.h"
#import "ArchiveHelper.h"
#import "JZUser.h"

@implementation NetworkManager

+ (void)githubExchangeTokenWithCode:(NSString *)code
                       successBlock:(CompleteBlock)success
                  networkErrorBlock:(NetworkErrorBlock)failure {
    
    if (!code) return;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                kClientID,@"client_id",
                                kClientSecret,@"client_secret",
                                code,@"code",
                                kRedirectURI,@"code",nil];
    
    [[HTTPManager shareInstance] post:kAccessTokenURL parameters:parameters onCompletion:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } onError:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)accessUserInfoSuccessBlock:(CompleteBlock)success
                 networkErrorBlock:(NetworkErrorBlock)failure {
    
    [[HTTPManager shareInstance] get:kAccessUserInfoURL parameters:nil onCompletion:^(id responseObject) {
        if (success) {
            if (!responseObject) {
                // 使用缓存
                JZUser *user = [ArchiveHelper unarchiveJZUser];
                success(user);
            } else {
                // 返回新数据并归档缓存
                JZUser *user = [JZUser new];
                user.avatar_url = responseObject[@"avatar_url"];
                user.login = responseObject[@"login"];
                [ArchiveHelper archiveJZUserWithData:user];
                success(responseObject);
            }
        }
    } onError:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
