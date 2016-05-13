//
//  OAuthHelper.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "OAuthHelper.h"
#import "GitHubConfigure.h"
#import <UIKit/UIKit.h>
#import "NetworkManager.h"
#import "UserDefaultHelper.h"

@implementation OAuthHelper

+ (void)loginAuthentication {
    NSString *url = [NSString stringWithFormat:@"%@?client_id=%@&scope=%@&redirect_uri=%@",kAuthorizeURL,kClientID,kScope,kRedirectURI];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}

+ (BOOL)handleOpenURLWithURL:(NSURL *)url {
    if(!url.absoluteString) return NO;
    NSLog(@"url - %@",url.absoluteString);
    NSString *code = [[self class] getCodeFromOpenURL:url];
    
    [NetworkManager githubExchangeTokenWithCode:code finishedCallback:^(NSError *error, id responseObject) {
        NSLog(@"res - %@",responseObject);
        NSString *token = responseObject[@"access_token"];
        [UserDefaultHelper setToken:token];
    }];

    return YES;
}

#pragma mark Privite

+ (NSString *)getCodeFromOpenURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    NSInteger codeLoc = range.location + range.length;
    NSInteger codeLen = urlString.length - codeLoc;
    NSRange codeRange = NSMakeRange(codeLoc, codeLen);
    return [urlString substringWithRange:codeRange];
}
@end
