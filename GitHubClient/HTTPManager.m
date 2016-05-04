//
//  HTTPMrg.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "HTTPManager.h"
#import "AFNetworking.h"
#import "UserDefaultHelper.h"

@interface HTTPManager ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation HTTPManager
+ (instancetype)shareInstance {
    static HTTPManager *httpManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [HTTPManager new];
    });
    return httpManager;
}

- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
onCompletion:(SuccessBlock)successBlock
    onError:(FailureErrorBlock)failureErrorBlock {
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addTokenForHTTPHeader];
    [self.sessionManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureErrorBlock) {
            failureErrorBlock(error);
        }
    }];
}

- (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
onCompletion:(SuccessBlock)successBlock
     onError:(FailureErrorBlock)failureErrorBlock {
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addTokenForHTTPHeader];
    [self.sessionManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureErrorBlock) {
            failureErrorBlock(error);
        }
    }];
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _sessionManager = manager;
    }
    return _sessionManager;
}

- (void)addTokenForHTTPHeader {
    NSString *token = [UserDefaultHelper getToken];
    if (token.length) {
        NSString *authorization = [NSString stringWithFormat:@"%@ %@",@"token", token];
        [self.sessionManager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    }
}

@end
