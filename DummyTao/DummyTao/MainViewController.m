//
//  MainViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/20.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "MainViewController.h"
#import "CustomNavModel.h"
#import "CustomCollectionViewCell.h"
#import "GoodsCategory.h"
#import "HotCollectionViewCell.h"
#import "HotGoods.h"
//#import "MainCollectionViewFlowLayout.h"
#import "CatCollectionViewHeader.h"
#import "CatCollectionViewFooter.h"
#import "SuperCheepCollectionViewCell.h"
#import "SupperCheepHeaderView.h"
#import "CheepGoods.h"
#import "CommonHeaderModel.h"
#import "DataModel.h"
#import "UserInformation.h"
#import "DataTransferManagement.h"
#import "MBProgressHUD.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSThread sleepForTimeInterval:2.0];

    [self initMainView];
    [self initNavigationBar];
    [self initCollectionView];
    [self requestInformationAndUpdate];
}

- (void)initMainView {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initNavigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"target_32x32"] style:UIBarButtonItemStylePlain target:self action:@selector(tapLeftBtn:)];
    
    UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:
                              CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    searchBar.searchBarStyle =  UISearchBarStyleMinimal;
    searchBar.delegate = self;
    searchBar.tag = UI_MV_SEARCH_TAG;

    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    self.navigationItem.titleView = searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"article_32x32"] style:UIBarButtonItemStylePlain target:self action:@selector(tapRightBtn:)];
}

- (void)initCollectionView {
//    NSArray* sizes = @[[NSNumber valueWithCGSize:
//                        CGSizeMake(self.view.bounds.size.width,
//                                   UI_MV_SCOLLV_HEIGHT)],
//                       [NSNumber valueWithCGSize:
//                        CGSizeMake(self.view.bounds.size.width / UI_MV_CLT_CAT_COLUMN,
//                                   UI_MV_CLT_CAT_HEIGHT / UI_MV_CLT_CAT_ROW)],
//                       [NSNumber valueWithCGSize:
//                        CGSizeMake(self.view.bounds.size.width / UI_MV_CLT_HOT_ROW,
//                                   UI_MV_CLT_HOT_HEIGHT / UI_MV_CLT_HOT_COLUMN)]];
    //MainCollectionViewFlowLayout* flowLayout = [[MainCollectionViewFlowLayout alloc] initWithSectionSize:sizes];
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:
                                        CGRectMake(UI_MV_COLLECTION_X,
                                                   UI_MV_COLLECTION_Y,
                                                   self.view.bounds.size.width,
                                                   self.view.bounds.size.height - UI_MV_COLLECTION_Y - self.tabBarController.tabBar.bounds.size.height) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.collectionViewLayout = flowLayout;
    collectionView.tag = UI_MV_COLLECTV_TAG;
    collectionView.alwaysBounceVertical = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.contentSize = CGSizeMake(self.view.bounds.size.width, UI_MV_COLLECTION_HEIGHT);

//    [collectionView registerClass:[CatCollectionViewHeader class] forCellWithReuseIdentifier:UI_MV_CLT_SCRO_CELLID];
    [collectionView registerClass:[CatCollectionViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UI_MV_CLT_CAT_HEADERID];
    [collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:UI_MV_CLT_CAT_CELLID];
    [collectionView registerNib:[UINib nibWithNibName:@"CatCollectionViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
            withReuseIdentifier:UI_MV_CLT_CAT_FOOTERID];
    
    [collectionView registerNib:[UINib nibWithNibName:@"HotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:UI_MV_CLT_HOT_CELLID];

    [collectionView registerNib:[UINib nibWithNibName:@"SupperCheepHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:UI_MV_CLT_CHP_HEADERID];
    [collectionView registerNib:[UINib nibWithNibName:@"SuperCheepCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:UI_MV_CLT_CHP_CELLID];

    UIRefreshControl* refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(dragDownToUpdate:) forControlEvents:UIControlEventValueChanged];
    refreshController.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在获取最新商品信息，请稍后……"];
    
    collectionView.refreshControl = refreshController;
//    [collectionView addSubview:refreshController];
    [self.view addSubview:collectionView];
}

- (void)requestInformationAndUpdate {
    __weak typeof(self) weakSelf = self;
    [[CustomNavModel sharedModel] requestRecommendedInfo:^(CMResultType result, NSArray* info) {
        if (CMResultTypeSuccess == result) {
            CustomNavModel* navModel = [CustomNavModel sharedModel];
            UISearchBar* searchBar = (UISearchBar*)weakSelf.navigationItem.titleView;
            
            navModel.goodsData = [[NSMutableArray alloc] initWithArray:info];
            searchBar.placeholder = info[arc4random() % info.count];
            navModel = nil;
            searchBar = nil;
        } else {
            NSLog(@"request recommended information fail!");
        }
    }];
    [[CustomNavModel sharedModel] requestFooterInfomation:^(CMResultType result, NSArray *info) {
        if (CMResultTypeSuccess == result) {
            CustomNavModel* navModel = [CustomNavModel sharedModel];
            UICollectionView* collectionView = [self.view viewWithTag:UI_MV_COLLECTV_TAG];
            
            CatCollectionViewFooter* footer = (CatCollectionViewFooter*)[collectionView supplementaryViewForElementKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            navModel.footer = [[NSArray alloc] initWithArray:info];
            
            int index = arc4random() % info.count;
            NSMutableString* textStr = [[NSMutableString alloc] initWithString:info[index]];
            [textStr appendString:@"\n"];
            [textStr appendString:info[index + 1 >= info.count ? 0 : index + 1]];
            footer.mainTextView.text = textStr;
        } else {
            NSLog(@"request recommended information fail!");
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return UI_MV_CLT_ID_TOTAL;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
//        case 0:
//            count = UI_MV_CLT_SCRO_ROW * UI_MV_CLT_SCRO_COLUMN;
//            break;
        case UI_MV_CLT_ID_CAT:
            count = UI_MV_CLT_CAT_ROW * UI_MV_CLT_CAT_COLUMN;
            break;
        case UI_MV_CLT_ID_HOT:
            count = UI_MV_CLT_HOT_ROW * UI_MV_CLT_HOT_COLUMN;
            break;
        case UI_MV_CLT_ID_CHP:
            count = UI_MV_CLT_CHP_ROW * UI_MV_CLT_CHP_COLUMN;
            break;
            
        default:
            break;
    }
    return count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    CustomNavModel* navModel = [CustomNavModel sharedModel];
    
    switch (indexPath.section) {
        case UI_MV_CLT_ID_CAT: {
            CustomCollectionViewCell* catCell = [collectionView dequeueReusableCellWithReuseIdentifier:UI_MV_CLT_CAT_CELLID forIndexPath:indexPath];
            if (indexPath.row < navModel.goodsCategory.count) {
                GoodsCategory* goodsCategory = (GoodsCategory*)navModel.goodsCategory[indexPath.row];
                catCell.textLable.text = goodsCategory.title;
                [catCell.topImage setImage:[UIImage imageNamed:goodsCategory.imageName]];
            }
            cell = catCell;
        }
            break;
            
        case UI_MV_CLT_ID_HOT: {
            HotCollectionViewCell* hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:UI_MV_CLT_HOT_CELLID forIndexPath:indexPath];
            HotGoods* hot = (HotGoods*)navModel.hotGoods[indexPath.row * 2 + navModel.hotOffset];
            if (indexPath.row * 2 < navModel.hotGoods.count) {
                hotCell.title.text = hot.title;
                hotCell.title.textColor = hot.titleColor;
                hotCell.info.text = hot.info;
                [hotCell.mainImage setImage:[UIImage imageNamed:hot.mainImagePath]];
                [hotCell.subImage setImage:[UIImage imageNamed:hot.subImagePath]];
                [hotCell.subSubImage setImage:[UIImage imageNamed:hot.subSubImagePath]];
            }
            hotCell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            hotCell.layer.borderWidth = 0.4f;
            cell = hotCell;
        }
            break;
            
        case UI_MV_CLT_ID_CHP: {
            SuperCheepCollectionViewCell* cheepCell = [collectionView dequeueReusableCellWithReuseIdentifier:UI_MV_CLT_CHP_CELLID forIndexPath:indexPath];
            CheepGoods* cheepGoods = navModel.cheepGoods[indexPath.row];
            cheepCell.mainTitle.text = cheepGoods.mainTitle;
            cheepCell.subTitle.text = cheepGoods.subTile;
            [cheepCell.mainImage setImage:[UIImage imageNamed:cheepGoods.mainImage]];
            cheepCell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cheepCell.layer.borderWidth = 0.4f;
            cell = cheepCell;
        }
            break;
            
        default:
            cell = [[UICollectionViewCell alloc] init];
            break;
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView* subView = nil;
    
    switch (indexPath.section) {
        case UI_MV_CLT_ID_CAT:
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                CatCollectionViewHeader* catHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:UI_MV_CLT_CAT_HEADERID forIndexPath:indexPath];
                subView = catHeader;
            } else {
                CatCollectionViewFooter* catFooter = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:UI_MV_CLT_CAT_FOOTERID forIndexPath:indexPath];
                subView = catFooter;
            }
            break;
            
        case UI_MV_CLT_ID_CHP: {
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                SupperCheepHeaderView* cheepHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:UI_MV_CLT_CHP_HEADERID forIndexPath:indexPath];
                CustomNavModel* navModel = [CustomNavModel sharedModel];
                cheepHeader.title.text = navModel.cheepHeader.headerTitle;
                [cheepHeader.icon setImage:[UIImage imageNamed:navModel.cheepHeader.headerIcon]];
                subView = cheepHeader;
            }
        }
            break;
        default:
            
            break;
    }
    return subView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize footerSize;
    switch (section) {
        case UI_MV_CLT_ID_CAT:
            footerSize = CGSizeMake(self.view.bounds.size.width, UI_MV_CLT_FOOTER_HEIGHT);
            break;
        
        default:
            footerSize = CGSizeZero;
            break;
    }
    return footerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize;
    switch (section) {
        case UI_MV_CLT_ID_CAT:
            headerSize = CGSizeMake(self.view.bounds.size.width, UI_MV_CLT_SCRO_HEIGHT);
            break;
        
        case UI_MV_CLT_ID_CHP:
            headerSize = CGSizeMake(self.view.bounds.size.width, UI_MV_CLT_CHP_HEADER_HEIGHT);
            break;
            
        default:
            headerSize = CGSizeZero;
            break;
    }
    return headerSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapLeftBtn:(id)sender {
    [self performSegueWithIdentifier:@"scan" sender:self];
}

- (void)tapRightBtn:(id)sender {
#if 1
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [[DataModel sharedInstance] loadData:DataTypeUserInfomation withDictionary:data];
    if (data.count > 0 && data[@"userId"] != nil) {
        NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              data[@"userId"], @"userId",
                              data[@"siteId"], @"siteId", nil];
        DataTransferRequest* request = [[DataTransferRequest alloc] initWithToken:data[@"token"] andDictionary:dict];
        [[DataTransferManagement sharedInstance] sendRequest:DataRequestTypeAutoLogin withParameters:request andResponse:^(DataResultType result, DataTransferResponse *response) {
            if (DataResultTypeSuccess == result) {
                NSLog(@"AutoLogin response:%@", response);
                [[DataModel sharedInstance] saveData:DataTypeUserInfomation andDictionary:response.dict[@"data"]];
                [self performSegueWithIdentifier:@"message" sender:self];
            } else {
                MBProgressHUD* progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
                progress.mode = MBProgressHUDModeText;
                if (DataResultTypeInvalidToken == result) {
                    progress.label.text = @"账号已过期，请重新登录！";
                } else {
                    progress.label.text = @"账号异常，请重新登录！";
                }
                progress.margin = 10.0f;
                progress.removeFromSuperViewOnHide = YES;
                [progress hideAnimated:YES afterDelay:3];

                [self performSegueWithIdentifier:@"login" sender:self];
            }
        }];
    } else {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
#else
    [self performSegueWithIdentifier:@"message" sender:self];
#endif
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self performSegueWithIdentifier:@"search" sender:self];
    return NO;
}

-(void)updateCollectionData {
    UICollectionView* collectionView = [self.view viewWithTag:UI_MV_COLLECTV_TAG];
    
    if (nil != collectionView && collectionView.refreshControl.refreshing) {
        [collectionView.refreshControl endRefreshing];
        CustomNavModel* navMode = [CustomNavModel sharedModel];
        navMode.hotOffset = navMode.hotOffset == 0 ? 1 : 0;
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:UI_MV_CLT_ID_HOT]];
    }
}

- (void)dragDownToUpdate:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval:UI_TIMER_CLT_REFRESH_DURATION target:self selector:@selector(updateCollectionData) userInfo:nil repeats:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* newViewController = [[UIViewController alloc] init];
    NSArray* bgColor = @[[UIColor whiteColor], [UIColor grayColor], [UIColor lightGrayColor],
                         [UIColor blueColor], [UIColor blueColor], [UIColor greenColor],
                         [UIColor redColor], [UIColor blackColor], [UIColor brownColor],
                         [UIColor cyanColor], [UIColor orangeColor], [UIColor purpleColor],
                         [UIColor yellowColor], [UIColor magentaColor]];
    
    newViewController.view.frame = self.view.frame;
    newViewController.view.backgroundColor = bgColor[arc4random() % bgColor.count];
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize;
    CustomNavModel* navModel = [CustomNavModel sharedModel];
    CGFloat screenWidth = self.view.bounds.size.width;
    switch (indexPath.section) {
//        case 0:
//            cellSize = CGSizeMake(self.view.bounds.size.width,
//                                  UI_MV_CLT_SCRO_HEIGHT);
//            break;
        case 0:
            cellSize = CGSizeMake(screenWidth / UI_MV_CLT_CAT_COLUMN,
                                  UI_MV_CLT_CAT_HEIGHT / UI_MV_CLT_CAT_ROW);
            break;
            
        case 1:
            cellSize = CGSizeMake(screenWidth / UI_MV_CLT_HOT_COLUMN,
                                  UI_MV_CLT_HOT_HEIGHT / UI_MV_CLT_HOT_ROW);
            break;
            
        case 2: {
            CheepGoods* cheepGoods = navModel.cheepGoods[indexPath.row];
            
            if (CheepGoodsTypeBig == cheepGoods.type) {
                cellSize = CGSizeMake(screenWidth / (UI_MV_CLT_CHP_COLUMN + 1) * UI_MV_CLT_CHP_WIDE_CELL,
                                      UI_MV_CLT_CHP_HEIGHT / UI_MV_CLT_CHP_ROW);
            } else {
                cellSize = CGSizeMake(screenWidth / (UI_MV_CLT_CHP_COLUMN + 1),
                                      UI_MV_CLT_CHP_HEIGHT / UI_MV_CLT_CHP_ROW);
            }
        }
            break;
            
        default:
            cellSize = CGSizeZero;
            break;
    }
    return cellSize;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets;

    switch (section) {
        case 0:
        case 2:
            edgeInsets = UIEdgeInsetsZero;
            break;

        default:
            edgeInsets = UIEdgeInsetsMake(2, 0, 2, 0);
            break;
    }
    return edgeInsets;
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
