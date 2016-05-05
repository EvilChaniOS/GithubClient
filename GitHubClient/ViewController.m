//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "OAuthHelper.h"
#import "ArchiveHelper.h"
#import "JZUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)login:(id)sender {
    [OAuthHelper logonAuthentication];
}

- (IBAction)getUserInfo:(id)sender {
    [NetworkManager accessUserInfoSuccessBlock:^(id responseObj) {
        NSLog(@"res - %@",responseObj);
    } networkErrorBlock:^(NSError *error) {
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
