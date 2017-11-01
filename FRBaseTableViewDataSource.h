//
//  FRBaseTableViewDataSource.h
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/10/31.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import <UIKit/UIkit.h>

@class FRDataSourceSection;

@protocol FRBaseTableViewDataSourceProtocol <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray<FRDataSourceSection *> *sections;
@property(nonatomic, strong) NSMutableDictionary *delegates;

@end

typedef void (^AdapterBlock)(id cell,id data,NSUInteger index);
typedef void (^EventBlock)(NSUInteger index,id data);

@interface FRBaseTableViewDataSource : NSObject <FRBaseTableViewDataSourceProtocol>

@property(nonatomic, strong) NSMutableArray<FRDataSourceSection *> *sections;

@end

@interface FRSampleTableViewDataSource: FRBaseTableViewDataSource

@end
