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
#import "JZTrendingViewController.h"
#import "JZMyRepositoriesViewController.h"

@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Delegate

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifiy = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiy];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifiy];
    }
    NSInteger row = indexPath.row;
    cell.textLabel.text = self.dataSource[row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [self logonAuthentication];
            break;
        case 1: {
            [self getUserInfo];
            break;
        }
        case 2: {
            [self pushTrendingViewController];
            break;
        }
        case 3: {
            [self pushMyRepositoriesViewController];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Privite

- (void)logonAuthentication {
    [OAuthHelper loginAuthentication];
}

- (void)getUserInfo {
    [NetworkManager accessUserInfoWithFinishedCallback:^(NSError *error, id responseObject) {
        NSLog(@"vc - res - %@",responseObject);
    }];
}

- (void)pushTrendingViewController {
    [self.navigationController pushViewController:[JZTrendingViewController new] animated:YES];
}

- (void)pushMyRepositoriesViewController {
    [self.navigationController pushViewController:[JZMyRepositoriesViewController new] animated:YES];
}

#pragma  mark - Getter && Setter 

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"登录认证",@"获取用户信息",@"Trending首页",@"我的仓库", nil];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
