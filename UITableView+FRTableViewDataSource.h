//
//  UITableView+FRTableViewDataSource.h
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/11/1.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRBaseTableViewDataSource;
@class FRTableViewDataSourceMaker;

@interface UITableView (FRTableViewDataSource)

@property(nonatomic, strong) FRBaseTableViewDataSource *frTableViewDataSource;

- (void)fr_makeDataSource:(void (^)(FRTableViewDataSourceMaker * make))maker;
- (void)fr_makeSectionWithDatas:(NSArray *)datas;
- (void)fr_makeSectionWithDatas:(NSArray *)datas andCellClass:(Class)cellClass;

@end

__attribute__((unused)) static void commitEditing(id self, SEL cmd, UITableView * tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath * indexPath);

__attribute__((unused)) static void scrollViewDidScroll(id self, SEL cmd, UIScrollView * scrollView);
