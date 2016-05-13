//
//  JZMyRepositoriesViewController.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/7.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZMyRepositoriesViewController.h"
#import "NetworkManager.h"
#import "JZMyRepositoryCell.h"
#import "JZMyRepository.h"
#import "JZMyRepoSummaryViewController.h"
#import "NSObject+PropertyList.h"

@interface JZMyRepositoriesViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *heighs;

@property (nonatomic, strong) JZMyRepositoryCell *caculateHeightCell;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation JZMyRepositoriesViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Repositories";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indicatorView];
    [self loadDataSource];
}

#pragma mark - Network

- (void)loadDataSource {
    __weak JZMyRepositoriesViewController *weakSelf = self;
    [self.indicatorView startAnimating];
    [NetworkManager fetchMyRepositoriesWithFinishedCallback:^(NSError *error, NSArray *myRepositoriesArray) {
                NSMutableArray *myRepositories = [JZMyRepository mj_objectArrayWithKeyValuesArray:myRepositoriesArray];
         [weakSelf.dataSource addObjectsFromArray:myRepositories];
         
         // 之前是无需显式调用在主线程中刷新UI,这里如果不显式调用会崩溃 “This application is modifying the autolayout engine from a background thread, which can lead to engine corruption and weird crashes.  This will cause an exception in a future release” ，为什么请求成功后不会切换回主线程???
         dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf.indicatorView stopAnimating];
//             for (JZMyRepository *myRepo in myRepositories) {
//                 weakSelf.caculateHeightCell.myRepository.content = myRepo.content;
//                 CGFloat cellHeigt = [weakSelf.caculateHeightCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//                 [weakSelf.heighs addObject:@(cellHeigt)];
//             }
             [weakSelf.tableView reloadData];
         });
     }];
}

#pragma mark - Delegate

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZMyRepository *myRepository = self.dataSource[indexPath.row];
    JZMyRepositoryCell *cell = [JZMyRepositoryCell myRepositoryCellWithTableView:tableView];
    [cell bindDataWithModelDictionary:[myRepository generateModelDictionary]];
    return cell;     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[JZMyRepoSummaryViewController new] animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat height = [self.heighs[indexPath.row] integerValue];
//    NSLog(@"Cellheigth %f",height);
//    return height;
//}

#pragma mark - Response Event
#pragma mark - Privite Method

#pragma mark - Setter && Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (JZMyRepositoryCell *)caculateHeightCell {
    if(!_caculateHeightCell) {
        _caculateHeightCell = [[[NSBundle mainBundle] loadNibNamed:@"JZMyRepositoryCell" owner:nil options:nil] lastObject];
    }
    return _caculateHeightCell;
}

- (NSMutableArray *)heighs {
    if(!_heighs) {
        _heighs = [NSMutableArray array];
    }
    return _heighs;
}

- (UIActivityIndicatorView *)indicatorView {
    if(!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 100);
    }
    return _indicatorView;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
