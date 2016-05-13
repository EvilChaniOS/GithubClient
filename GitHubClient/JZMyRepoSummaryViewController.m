//
//  JZMyRepoSummaryViewController.m
//  GitHubClient
//
//  Created by jiong23 on 16/5/9.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import "JZMyRepoSummaryViewController.h"
#import "JZMyRepoHeader.h"
#import "JZRepoSummaryCell.h"
#import "JZCommonCell.h"

@interface JZMyRepoSummaryViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) JZMyRepoHeader *myRepoHeader;

@property (nonatomic, strong) NSArray *items;

@end

@implementation JZMyRepoSummaryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network
#pragma mark - Delegate

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger seciotn = indexPath.section;
    NSInteger row = indexPath.row;
    if (seciotn == 0 && row == 0) {
        JZRepoSummaryCell *cell = [JZRepoSummaryCell repoSummaryCellWithTableView:tableView];
        return cell;
    }
    NSDictionary *itemDict = self.items[seciotn][row];
    JZCommonCell *cell = [JZCommonCell commonCellWithTableView:tableView];
    [cell bindDataWithModelDictionary:itemDict];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger seciotn = indexPath.section;
    NSInteger row = indexPath.row;
    CGFloat heigh = 60.0;
    if (seciotn == 0 && row == 0) {
        heigh = 150.0;
    }
    return heigh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
}

#pragma mark - Response Event
#pragma mark - Privite Method
#pragma mark - Setter && Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        _tableView.tableHeaderView = self.myRepoHeader;

    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (JZMyRepoHeader *)myRepoHeader {
    if(!_myRepoHeader) {
        _myRepoHeader = [JZMyRepoHeader myRepoHeader];
        _myRepoHeader.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    }
    return _myRepoHeader;
}

- (NSArray *)items{
    if (!_items) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RepoSummary" ofType:@"plist"];
        _items = [[NSArray alloc] initWithContentsOfFile:plistPath];
        NSLog(@"plist - items %@",_items);
    }
    return _items;
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
