//
//  SUTableView.m
//  GoldPigApp
//
//  Created by Office on 2018/4/3.
//  Copyright © 2018年 MiYIN.COM. All rights reserved.
//

#import "SUTableView.h"

@implementation SUTableView

- (void)layoutSubviews { [self resetContentOffsetIfNeeded]; [super layoutSubviews]; } - (void)resetContentOffsetIfNeeded { CGPoint contentOffset = self.contentOffset; //头部
    if (contentOffset.y < 0.0) { contentOffset.y = self.contentSize.height / 3.0; }
    //尾部
    else if (contentOffset.y >= (self.contentSize.height - self.bounds.size.height)) { contentOffset.y = self.contentSize.height / 3.0 - self.bounds.size.height; } [self setContentOffset: contentOffset];
    
}
- (void)setDataSource:(id<UITableViewDataSource>)dataSource { self.dataSourceInterceptor.receiver = dataSource; [super setDataSource:(id<UITableViewDataSource>)self.dataSourceInterceptor];
    
}
- (SUTableViewInterceptor *)dataSourceInterceptor {
    if (!_dataSourceInterceptor) {
        _dataSourceInterceptor = [[SUTableViewInterceptor alloc]init]; _dataSourceInterceptor.middleMan = self;
    }
    return _dataSourceInterceptor;
    
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    self.actualRows = [self.dataSourceInterceptor.receiver tableView:tableView numberOfRowsInSection:section];
    return self.actualRows * 3;
    
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * actualIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    return [self.dataSourceInterceptor.receiver tableView:tableView cellForRowAtIndexPath:actualIndexPath];
    
}


@end
