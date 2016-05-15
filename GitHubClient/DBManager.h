//
//  DBManager.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/15.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBManager : NSObject

// 单例
+ (instancetype)shareInstance;

// 获取数据
- (NSArray *)queryCacheWithURl:(NSString *)url;

// 更新操作
- (BOOL)updataCacheResponseObject:(id)responseObject withURL:(NSString *)url;

@end
