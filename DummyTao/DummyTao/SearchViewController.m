//
//  SearchViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/20.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomNavModel.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(tapSearchButton:)];
    CustomNavModel* navModel = [CustomNavModel sharedModel];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    __weak SearchViewController* weakSelf = self;
    [navModel requestRecommendedInfo:^(CMResultType result, NSArray *info) {
        if (CMResultTypeSuccess == result) {
            weakSelf.searchBar.placeholder = info[arc4random() % 9];
        }
    }];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CustomNavModel sharedModel].searchData.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* tableCell = [tableView dequeueReusableCellWithIdentifier:@"searchItem"];
    
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchItem"];
    }
    CustomNavModel* customData = [CustomNavModel sharedModel];
    if (customData.searchData.count > 0) {
        tableCell.textLabel.text = customData.searchData[indexPath.row];
    }
    
    return tableCell;
}

- (NSUInteger)filterTextByText:(NSString*)searchText {
    CustomNavModel* customData = [CustomNavModel sharedModel];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchText];
    
    customData.searchData = [[NSMutableArray alloc] initWithArray:[customData.goodsData filteredArrayUsingPredicate:pred]];

    return customData.searchData.count;
}

- (void) updateTableCells:(NSUInteger) count {
    if (count > 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateTableCells:[self filterTextByText:searchText]];
    if (searchBar.text.length == 0) {
        [self.searchBar resignFirstResponder];
    }
}

- (void)tapSearchButton:(UIButton*)sender {
    [self updateTableCells:[self filterTextByText:self.searchBar.text]];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self updateTableCells:[self filterTextByText:searchBar.text]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self updateTableCells:[self filterTextByText:textField.text]];
    return [textField resignFirstResponder];
}

// release the keypad when selecting the cell
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    return indexPath;
}

// release the keypad when scrolling
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
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
