//
//  NetworkManager.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompleteBlock)(id responseObj);
typedef void (^NetworkErrorBlock)(NSError* error);

@interface NetworkManager : NSObject

+ (void)githubExchangeTokenWithCode:(NSString *)code
                       SuccessBlock:(CompleteBlock)success
                  NetworkErrorBlock:(NetworkErrorBlock)failure;

+ (void)accessUserInfoSuccessBlock:(CompleteBlock)success
                 NetworkErrorBlock:(NetworkErrorBlock)failure;
@end
