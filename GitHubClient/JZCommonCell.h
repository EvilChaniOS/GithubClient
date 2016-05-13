//
//  JZCommonCell.h
//  GitHubClient
//
//  Created by jiong23 on 16/5/9.
//  Copyright © 2016年 陈炯舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCommonCell : UITableViewCell

- (void)bindDataWithModelDictionary:(NSDictionary *)dict;

+ (instancetype)commonCellWithTableView:(UITableView *)tableView;

@end
