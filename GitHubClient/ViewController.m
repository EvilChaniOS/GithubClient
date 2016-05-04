//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "GitHubConfigure.h"
#import "NetworkManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)login:(id)sender {
    NSString *url = [NSString stringWithFormat:@"%@?client_id=%@&scope=%@&redirect_uri=%@",kAuthorizeURL,kClientID,kScope,kRedirectURI];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}

- (IBAction)getUserInfo:(id)sender {
    [NetworkManager accessUserInfoSuccessBlock:^(id responseObj) {
        NSLog(@"res - %@",responseObj);
    } NetworkErrorBlock:^(NSError *error) {
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
