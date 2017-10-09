//
//  CatCollectionViewHeader.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/23.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "CatCollectionViewHeader.h"

@implementation CatCollectionViewHeader
{
    NSTimer* _autoScrollTimer;
    UIScrollView* _scrollView;
    UIPageControl* _pageCtrl;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initScollView];
        [self initPageControl];
        _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:UI_TIMER_CLT_HEADER_DURATION target:self selector:@selector(autoUpdateHeaderImage:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)initScollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:
                                CGRectMake(UI_MV_CLT_SCRO_X,
                                           UI_MV_CLT_SCRO_Y,
                                           self.bounds.size.width,
                                           UI_MV_CLT_SCRO_HEIGHT)];
    
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * UI_MV_CLT_SCRO_VCOUNT, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.tag = UI_MV_SCOLLV_TAG;
    _scrollView.delegate = self;
    
    for (int i = 0; i < UI_MV_CLT_SCRO_VCOUNT; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, UI_MV_CLT_SCRO_HEIGHT)];
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"ScrollImage_%d.jpg", i + 1]];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    }
    [self addSubview:_scrollView];
}

- (void)initPageControl {
    _pageCtrl = [[UIPageControl alloc] initWithFrame:
                               CGRectMake(UI_MV_CLT_PCTRL_X,
                                          UI_MV_CLT_PCTRL_Y,
                                          self.bounds.size.width,
                                          UI_MV_CLT_PCTRL_HEIGHT)];
    
    _pageCtrl.numberOfPages = UI_MV_CLT_PCTRL_COUNT;
    _pageCtrl.hidesForSinglePage = YES;
    _pageCtrl.tag = UI_MV_PAGECTRL_TAG;
    [self addSubview:_pageCtrl];
}

- (void)autoUpdateHeaderImage:(NSTimer*)timer {
    _pageCtrl.currentPage = _pageCtrl.currentPage + 1 == UI_MV_CLT_PCTRL_COUNT ? 0 : _pageCtrl.currentPage + 1;
    [_scrollView setContentOffset:CGPointMake(_pageCtrl.currentPage * self.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:UI_TIMER_CLT_HEADER_DURATION target:self selector:@selector(autoUpdateHeaderImage:) userInfo:nil repeats:YES];
    
    int current = scrollView.contentOffset.x / self.bounds.size.width;
    UIPageControl* pageCtrl = (UIPageControl*)[self viewWithTag:UI_MV_PAGECTRL_TAG];
    
    pageCtrl.currentPage = current;
}

@end
