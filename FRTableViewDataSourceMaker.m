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

- (FRTableViewDataSourceMaker * (^)(UIView * (^)()))headerView {
    return ^FRTableViewDataSourceMaker *(UIView * (^view)()) {
        UIView * headerView =  view();
        [self.tableView.tableHeaderView layoutIfNeeded];
        self.tableView.tableHeaderView = headerView;
        return self;
    };
}

- (FRTableViewDataSourceMaker * (^)(UIView * (^)()))footerView {
    return ^FRTableViewDataSourceMaker *(UIView * (^view)()) {
        UIView * footerView = view();
        [self.tableView.tableFooterView layoutIfNeeded];
        self.tableView.tableFooterView = footerView;
        return self;
    };
}

- (FRTableViewDataSourceMaker * (^)(CGFloat))height {
    return ^FRTableViewDataSourceMaker *(CGFloat height) {
        self.tableView.rowHeight = height;
        return self;
    };
}

- (void)commitEditing:(void (^)(UITableView * tableView,UITableViewCellEditingStyle * editingStyle, NSIndexPath * indexPath))block {
    self.commitEditingBlock = block;
}

- (void)scrollViewDidScroll:(void (^)(UIScrollView * scrollView))block {
    self.scrollViewDidScrollBlock = block;
}


- (void)makeSection:(void (^)(FRTableViewSectionMaker * section))block {
    FRTableViewSectionMaker * sectionMaker = [FRTableViewSectionMaker new];
    block(sectionMaker);
    if (sectionMaker.section.cell) {
        [self.tableView registerClass:sectionMaker.section.cell forCellReuseIdentifier:sectionMaker.section.identifier];
    }
    [self.sections addObject:sectionMaker.section];
}

- (NSMutableArray *)sections {
    if (! _sections) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}

@end
