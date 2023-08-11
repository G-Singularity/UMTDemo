//
//  RefreshFooter.m
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

#import "RefreshFooter.h"

@implementation RefreshFooter

- (void)prepare {
    [super prepare];
    
    // self.stateLabel.textColor = [UIColor redColor];
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"没有更多" forState:MJRefreshStateNoMoreData];
    // 刷新控件出现一半就会进入刷新状态
    self.triggerAutomaticallyRefreshPercent = 0.5;
    // 不要自动刷新
    //    self.automaticallyRefresh = NO;
}

@end
