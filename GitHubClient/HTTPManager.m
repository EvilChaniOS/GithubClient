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

#pragma mark - Requet Method

- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
onCompletion:(SuccessBlock)successBlock
    onError:(FailureErrorBlock)failureErrorBlock {

    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addTokenForHTTPHeader];
    [self.sessionManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        // 2.添加Etag到请求头让服务器进行校验,并强制修改缓存策略(忽略URL缓存)
        NSString *etag = [UserDefaultHelper getEtag];
        if (etag) {
            [self.sessionManager.requestSerializer setValue:etag forHTTPHeaderField:@"If-None-Match"];
            self.sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        }
    
        // 3.AFN请求Success的状态码范围200～299,需要添加304
        AFJSONResponseSerializer *responseSerialization = [AFJSONResponseSerializer serializer];
        NSMutableIndexSet *set = [responseSerialization.acceptableStatusCodes mutableCopy];
        [set addIndex:304];
        NSLog(@"set - %@",set);
        responseSerialization.acceptableStatusCodes = set;
        self.sessionManager.responseSerializer = responseSerialization;
        
        // 1.通过response获取Etag
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if ([response respondsToSelector:@selector(allHeaderFields)]) {
            NSLog(@"Response allHeaderFields - %@",response.allHeaderFields);
            NSString *etag = response.allHeaderFields[@"Etag"];
            [UserDefaultHelper setEtag:etag];
        }
        
        if (successBlock) {
            if (!responseObject) {
                // 缓存responseObject
                NSLog(@"使用缓存");
                successBlock(nil);
            } else {
                // 返回新数据
                if (successBlock) {
                    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    NSLog(@"resonseObject data - %@",data);
                    successBlock(data);
                }
            }
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
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            successBlock(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureErrorBlock) {
            failureErrorBlock(error);
        }
    }];
}

#pragma mark - Privite

- (void)addTokenForHTTPHeader {
    NSString *token = [UserDefaultHelper getToken];
    if (token.length) {
        NSString *authorization = [NSString stringWithFormat:@"%@ %@",@"token", token];
        [self.sessionManager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    }
}

#pragma mark - Getter && Setter 

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _sessionManager = manager;
    }
    return _sessionManager;
}

@end
