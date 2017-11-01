//
//  FRTableViewSectionMaker.h
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/11/1.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRDataSourceSection;

@interface FRTableViewSectionMaker : NSObject

- (FRTableViewSectionMaker * (^)(Class))cell;

- (FRTableViewSectionMaker * (^)(NSArray *))datas;

- (FRTableViewSectionMaker * (^)(void(^)(id cell, id data, NSUInteger index)))adapter;

- (FRTableViewSectionMaker * (^)(CGFloat))height;

- (FRTableViewSectionMaker * (^)())autoHeight;

- (FRTableViewSectionMaker * (^)(void(^)(NSUInteger index, id data)))event;

- (FRTableViewSectionMaker * (^)(NSString *))headerTitle;
- (FRTableViewSectionMaker * (^)(NSString *))footerTitle;

- (FRTableViewSectionMaker * (^)(UIView * (^)()))headerView;
- (FRTableViewSectionMaker * (^)(UIView * (^)()))footerView;

@property(nonatomic, strong) FRDataSourceSection * section;

@end
