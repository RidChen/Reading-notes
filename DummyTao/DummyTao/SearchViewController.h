//
//  SearchViewController.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/20.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UITableView *tableView;
@end
