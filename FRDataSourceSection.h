//
//  FRDataSourceSection.h
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/10/31.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import "FRBaseTableViewDataSource.h"

@interface FRDataSourceSection : NSObject

@property(nonatomic, copy) AdapterBlock adapter;
@property(nonatomic, copy) EventBlock event;

@property(nonatomic, strong) Class cell;
@property(nonatomic, copy) NSArray *datas;
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *headerTitle;
@property(nonatomic, copy) NSString *footerTitle;
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) UIView *footerView;
@property(nonatomic, assign, getter=isAutoHeight) BOOL autoHeight;
@property(nonatomic, assign) CGFloat staticHeight;

@property(nonatomic, assign) UITableViewCellStyle tableViewCellStyle;

@end
