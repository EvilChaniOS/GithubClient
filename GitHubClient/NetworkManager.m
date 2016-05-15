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
#import "JZMyRepository.h"

@implementation NetworkManager

+ (void)githubExchangeTokenWithCode:(NSString *)code
                   finishedCallback:(FinishedCallback)finishedCallback{
    if (!code) return;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                kClientID,@"client_id",
                                kClientSecret,@"client_secret",
                                code,@"code",
                                kRedirectURI,@"redirect_uri",nil];
    [[HTTPManager shareInstance] post:kAccessTokenURL parameters:parameters requestFinishedCallback:^(NSError *error, id responseObject) {
        if (finishedCallback) {
            finishedCallback(error, responseObject);
        }
    }];
}

+ (void)accessUserInfoWithFinishedCallback:(FinishedCallback)finishedCallback {
     [[HTTPManager shareInstance] get:kAccessUserInfoURL parameters:nil requestFinishedCallback:^(NSError *error, id responseObject) {
         if (error && finishedCallback) {
             finishedCallback(error, nil);
             return ;
         }
         // json序列化
//          NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
             if (finishedCallback) {
                 finishedCallback(nil, responseObject);
             }
     }];
}

+ (void)fetchTrendingDataWithFinishedCallback:(FinishedCallback)finishedCallback {
    [[HTTPManager shareInstance] get:kTrendingURL parameters:nil requestFinishedCallback:^(NSError *error, id responseObject) {
        if (finishedCallback) {
            finishedCallback(error, responseObject);
        }
    }];
}

+ (void)fetchMyRepositoriesWithFinishedCallback:(FinishedCallback)finishedCallback {
    
     [[HTTPManager shareInstance] get:kMyRepositoriesURL parameters:nil requestFinishedCallback:^(NSError *error, id responseObject) {
         if (error && finishedCallback) {
             finishedCallback(error, nil);
             return ;
         }
         NSLog(@"MyRepositories - %@", responseObject);
         if (finishedCallback) {
             finishedCallback(nil, responseObject);
         }
     }];
}

@end
