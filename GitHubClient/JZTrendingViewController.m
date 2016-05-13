//
//  JZTrendingViewController.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/6.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZTrendingViewController.h"
#import "NetworkManager.h"
#import "UIImageView+SDWebImage.h"


@interface JZTrendingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *forkImageView;

@end

@implementation JZTrendingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDataSource];
    
    [_forkImageView setImageViewWithUrl:@"https://api.github.com/repos/EvilChaniOS/GithubClient/forks"];
}

#pragma mark - Network

- (void)loadDataSource {
    [NetworkManager fetchMyRepositoriesWithFinishedCallback:^(NSError *error, id responseObject) {
        NSLog(@"TrendingData - %@",responseObject);
    }];
}
#pragma mark - Delegate
#pragma mark - Response Event
#pragma mark - Privite Method
#pragma mark - Setter && Getter


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
