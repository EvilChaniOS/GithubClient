//
//  NetworkManager.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^CompleteBlock)(id responseObj);
//typedef void (^NetworkErrorBlock)(NSError *error);
typedef void(^FinishedCallback)(NSError *error, id responseObject);

@interface NetworkManager : NSObject

/**
 *  获取Token
 */
+ (void)githubExchangeTokenWithCode:(NSString *)code
            finishedCallback:(FinishedCallback)finishedCallback;
;

/**
 *  获取用户数据
 */
+ (void)accessUserInfoWithFinishedCallback:(FinishedCallback)finishedCallback;

/**
 *  获取Trending首页数据
 */
+ (void)fetchTrendingDataWithFinishedCallback:(FinishedCallback)finishedCallback;


/**
 *  获取我的仓库
 */
+ (void)fetchMyRepositoriesWithFinishedCallback:(FinishedCallback)finishedCallback;

@end
