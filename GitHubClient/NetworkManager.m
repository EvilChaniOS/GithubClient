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

@implementation NetworkManager

+ (void)githubExchangeTokenWithCode:(NSString *)code SuccessBlock:(CompleteBlock)success NetworkErrorBlock:(NetworkErrorBlock)failure {
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

+ (void)accessUserInfoSuccessBlock:(CompleteBlock)success NetworkErrorBlock:(NetworkErrorBlock)failure {

    [[HTTPManager shareInstance] get:kAccessUserInfoURL parameters:nil onCompletion:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } onError:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
