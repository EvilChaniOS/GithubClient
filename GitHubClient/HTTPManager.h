//
//  HTTPMrg.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^SuccessBlock)(id responseObject);
//typedef void(^FailureErrorBlock)( NSError * error);
typedef void(^RequestFinishedCallback)(NSError *error, id responseObject);

@interface HTTPManager : NSObject

+ (instancetype)shareInstance ;

- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
requestFinishedCallback:(RequestFinishedCallback)requestFinishedCallback;

- (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
requestFinishedCallback:(RequestFinishedCallback)requestFinishedCallback;

@end
