//
//  FRTableViewDataSourceMaker.m
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/11/1.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import "FRTableViewDataSourceMaker.h"

#import "FRTableViewSectionMaker.h"
#import "FRDataSourceSection.h"

@implementation FRTableViewDataSourceMaker

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

- (FRTableViewDataSourceMaker * (^)(UIView * (^)()))tableHeaderView {
    return ^FRTableViewDataSourceMaker *(UIView * (^view)()) {
        UIView * tableHeaderView =  view();
        [self.tableView.tableHeaderView layoutIfNeeded];
        self.tableView.tableHeaderView = tableHeaderView;
        return self;
    };
}

- (FRTableViewDataSourceMaker * (^)(UIView * (^)()))tableFooterView {
    return ^FRTableViewDataSourceMaker *(UIView * (^view)()) {
        UIView * tableFooterView = view();
        [self.tableView.tableFooterView layoutIfNeeded];
        self.tableView.tableFooterView = tableFooterView;
        return self;
    };
}

- (FRTableViewDataSourceMaker * (^)(CGFloat))rowHeight {
    return ^FRTableViewDataSourceMaker *(CGFloat rowHeight) {
        self.tableView.rowHeight = rowHeight;
        return self;
    };
}

- (void)commitEditing:(void (^)(UITableView * tableView,UITableViewCellEditingStyle * editingStyle, NSIndexPath * indexPath))block {
    self.commitEditingBlock = block;
}

- (void)scrollViewDidScroll:(void (^)(UIScrollView * scrollView))block {
    self.scrollViewDidScrollBlock = block;
}

- (FRTableViewDataSourceMaker *)makeSection:(void (^)(FRTableViewSectionMaker * section))block {
    FRTableViewSectionMaker * sectionMaker = [FRTableViewSectionMaker new];
    block(sectionMaker);
    if (sectionMaker.section.cell) {
        [self.tableView registerClass:sectionMaker.section.cell forCellReuseIdentifier:sectionMaker.section.identifier];
    }
    [self.sections addObject:sectionMaker.section];
    return self;
}

- (NSMutableArray *)sections {
    if (! _sections) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}

@end
