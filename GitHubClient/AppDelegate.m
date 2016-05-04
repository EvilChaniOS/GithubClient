//
//  AppDelegate.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "AppDelegate.h"
#import "GitHubConfigure.h"
#import "NetworkManager.h"
#import "UserDefaultHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if(!url.absoluteString) return NO;
    NSLog(@"url - %@",url.absoluteString);
    NSString *code = [self getCodeFromOpenURL:url];
    [NetworkManager githubExchangeTokenWithCode:code SuccessBlock:^(id responseObj) {
        NSLog(@"res - %@",responseObj);
        NSString *token = responseObj[@"access_token"];
        [UserDefaultHelper setToekn:token];
    } NetworkErrorBlock:^(NSError *error) {
        
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)getCodeFromOpenURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    NSInteger codeLoc = range.location + range.length;
    NSInteger codeLen = urlString.length - codeLoc;
    NSRange codeRange = NSMakeRange(codeLoc, codeLen);
    return [urlString substringWithRange:codeRange];
}
@end
