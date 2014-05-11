//
//  ViewController.m
//  BaiduImage
//
//  Created by ccnyou on 14-5-10.
//  Copyright (c) 2014年 ccnyou. All rights reserved.
//

#import "ViewController.h"
#import "PullingRefreshTableView.h"
#import "SDWebImageDataSource.h"
#import "MJRefresh.h"

@interface ViewController ()<MJRefreshBaseViewDelegate>

@property (nonatomic, strong) SDWebImageDataSource *images;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) MJRefreshFooterView* footer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.title = @"WebImage";
    _images = [[SDWebImageDataSource alloc] init];
    [self setDataSource:_images];
    
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = self.scrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%s line:%d", __FUNCTION__, __LINE__);
}



#pragma mark - Activity Indicator

- (UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicatorView) {
        return _activityIndicatorView;
    }
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGPoint center = [[self view] center];
    [_activityIndicatorView setCenter:center];
    [_activityIndicatorView setHidesWhenStopped:YES];
    [_activityIndicatorView startAnimating];
    [[self view] addSubview:_activityIndicatorView];
    
    return _activityIndicatorView;
}

- (void)showActivityIndicator
{
    [[self activityIndicator] startAnimating];
}

- (void)hideActivityIndicator
{
    [[self activityIndicator] stopAnimating];
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    [self.images again];
    [refreshView endRefreshing];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

@end
