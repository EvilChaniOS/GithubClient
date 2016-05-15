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
#import "NSString+ArchivePath.h"
#import "AFNetworkReachabilityManager.h"
#import "DBManager.h"

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
requestFinishedCallback:(RequestFinishedCallback)requestFinishedCallback; {
    
    NSLog(@"etag path is %@",[NSString etagPathFromRequestURL:url]);
    NSAssert(url.length != 0, @"URL is empty");
    
    // 注释掉了？
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addTokenForHTTPHeader];
    
    // 网络不可用
//    if (![AFNetworkReachabilityManager sharedManager].isReachable) {
//        if (requestFinishedCallback) {
//            requestFinishedCallback(nil, @"");
//        }
//    }
    
    [self.sessionManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        // 2.添加Etag到请求头让服务器进行校验,并强制修改缓存策略(忽略URL缓存)
        // 2.1 除了判断Etag 还须判断本地有无缓存
        NSString *etag = [UserDefaultHelper getArchivedEtagWithURL:url];
//        id cache = [UserDefaultHelper getArchivedCacheWithURL:url];
        NSArray *cache = [[DBManager shareInstance] queryCacheWithURl:url];
        if (etag.length > 0 && cache.count ) {
            [self.sessionManager.requestSerializer setValue:etag forHTTPHeaderField:@"If-None-Match"];
            self.sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        } else {
            self.sessionManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
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
            if (response.statusCode == 304) {
                if (requestFinishedCallback) {
                    requestFinishedCallback(nil,cache);
                    NSLog(@"Use cache ");
                }
            } else {
                NSLog(@"Response allHeaderFields - %@",response.allHeaderFields);
                NSString *etag = response.allHeaderFields[@"Etag"];
                if (etag) {
                    [UserDefaultHelper archiveRequestEtag:etag withUrl:url];
                }

//                [UserDefaultHelper archiveRequestResponse:responseObject withURL:url];
                [[DBManager shareInstance] updataCacheResponseObject:responseObject withURL:url];
                if (requestFinishedCallback) {
                    requestFinishedCallback(nil, responseObject);
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFinishedCallback) {
            requestFinishedCallback(error, nil);
        }
    }];
}

- (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
requestFinishedCallback:(RequestFinishedCallback)requestFinishedCallback;{
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addTokenForHTTPHeader];
    [self.sessionManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestFinishedCallback) {
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            requestFinishedCallback(nil, data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFinishedCallback) {
            requestFinishedCallback(error, nil);
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
