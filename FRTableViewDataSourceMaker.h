//
//  FRTableViewDataSourceMaker.h
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/11/1.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRTableViewSectionMaker;

@interface FRTableViewDataSourceMaker : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView;

- (FRTableViewDataSourceMaker *)makeSection:(void (^)(FRTableViewSectionMaker * section))block;

@property(nonatomic, weak) UITableView * tableView;
@property(nonatomic, strong) NSMutableArray * sections;

- (FRTableViewDataSourceMaker * (^)(CGFloat))rowHeight;
- (FRTableViewDataSourceMaker * (^)(UIView * (^)()))tableHeaderView;
- (FRTableViewDataSourceMaker * (^)(UIView * (^)()))tableFooterView;

//- (FRTableViewDataSourceMaker * (^)(UITableView *tableView,UITableViewCell *willDisplayCell,NSIndexPath *indexPath))cellWillDisplay;
//- (FRTableViewDataSourceMaker * (^)(UITableView * tableView,UITableViewCellEditingStyle * editingStyle,NSIndexPath * indexPath))commitEditing;
//- (FRTableViewDataSourceMaker * (^)(UIScrollView *scrollView))scrollViewDidScroll;

- (void)commitEditing:(void(^)(UITableView * tableView,UITableViewCellEditingStyle * editingStyle,NSIndexPath * indexPath))block;
- (void)scrollViewDidScroll:(void(^)(UIScrollView *scrollView))block;

@property(nonatomic, copy) void(^commitEditingBlock)(UITableView * tableView,UITableViewCellEditingStyle * editingStyle,NSIndexPath * indexPath);
@property(nonatomic, copy) void(^scrollViewDidScrollBlock)(UIScrollView *scrollView);

@end
