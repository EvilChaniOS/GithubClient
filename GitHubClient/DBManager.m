//
//  DBManager.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/15.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "DBManager.h"
#import "NSString+ArchivePath.h"
#import "NSString+MD5.h"

@interface DBManager ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation DBManager

+ (instancetype)shareInstance {
    static DBManager *mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [DBManager new];
    });
    return mgr;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [basePath stringByAppendingPathComponent:@"cjzDB.db"];
        NSLog(@"Databse path - %@",path);
        
        FMDatabase *db = [FMDatabase databaseWithPath:path];
        self.dataBase = db;
        if (![db open]) {
            NSString *msg = [db lastErrorMessage];
            NSLog(@"打开数据库失败 - %@",msg);
        } else {
           
            NSString *sql = @"create table if not exists t_cache (id int primary key not null, cache_name text not null, data blob)";
            [db executeUpdate:sql];
            NSLog(@"打开数据库成功");
        }
        [db close];
    }
    return self;
}

- (BOOL)updataCacheResponseObject:(NSArray *)responseObject withURL:(NSString *)url {
   [self.dataBase open];
    
    NSString *cache_name = [url md5];
    BOOL success = [self.dataBase executeUpdate:@"select cache_name from t_cache where cache_name = ? ",cache_name];
    BOOL result;
    if (success) {
        result = [self.dataBase executeUpdate:@"update t_cache set data = ? where cache_name = ?",responseObject, cache_name];
    } else {
        result = [self.dataBase executeUpdate:@"insert into t_cache (cache_name, data) values (?,?)",cache_name, responseObject];
    }
    if (!result) {
        NSString *msg = [self.dataBase lastErrorMessage];
        NSLog(@"数据库更新失败 - %@",msg);
    }
    [self.dataBase close];
    
    return result;
}


- (NSArray *)queryCacheWithURl:(NSString *)url {
    [self.dataBase open];
    
    NSString *cache_name = [url md5];
    NSMutableArray *temp = [NSMutableArray array];
    FMResultSet *resultSet = [self.dataBase executeQuery:@"select data from t_cache where cache_name = ?",cache_name];
    while ([resultSet next]) {
        NSData *data = [resultSet dataForColumn:@"data"];
        [temp addObject:data];
    }
    
    [self.dataBase close];
    
    return [temp copy];
}



@end
