//
//  UITableView+FRTableViewDataSource.m
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/11/1.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import "UITableView+FRTableViewDataSource.h"

#import <objc/runtime.h>
#import "FRBaseTableViewDataSource.h"
#import "FRTableViewDataSourceMaker.h"
#import "FRTableViewSectionMaker.h"
#import "FRDataSourceSection.h"

static NSString * getIdentifier (){
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString * retStr = (__bridge NSString *) uuidStrRef;
    CFRelease(uuidStrRef);
    return retStr;
}

@implementation UITableView (FRTableViewDataSource)

- (FRBaseTableViewDataSource *)frTableViewDataSource {
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setFrTableViewDataSource:(FRBaseTableViewDataSource *)frTableViewDataSource {
    objc_setAssociatedObject(self,@selector(frTableViewDataSource),frTableViewDataSource,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)fr_makeDataSource:(void(^)(FRTableViewDataSourceMaker * make))maker {
    FRTableViewDataSourceMaker * make = [[FRTableViewDataSourceMaker alloc] initWithTableView:self];
    maker(make);
    Class DataSourceClass = [FRBaseTableViewDataSource class];
    NSMutableDictionary * delegates = [[NSMutableDictionary alloc] init];
    if(make.commitEditingBlock||make.scrollViewDidScrollBlock) {
        DataSourceClass = objc_allocateClassPair([FRBaseTableViewDataSource class], [getIdentifier() UTF8String],0);
        if(make.commitEditingBlock) {
            class_addMethod(DataSourceClass,NSSelectorFromString(@"tableView:commitEditingStyle:forRowAtIndexPath:"),(IMP)commitEditing,"v@:@@@");
            delegates[@"tableView:commitEditingStyle:forRowAtIndexPath:"] = make.commitEditingBlock;
        }
        if(make.scrollViewDidScrollBlock) {
            class_addMethod(DataSourceClass,NSSelectorFromString(@"scrollViewDidScroll:"),(IMP)scrollViewDidScroll,"v@:@");
            delegates[@"scrollViewDidScroll:"] = make.scrollViewDidScrollBlock;
        }
    }
    
    if(!self.tableFooterView) {
        self.tableFooterView = [UIView new];
    }
    
    id<FRBaseTableViewDataSourceProtocol> ds = (id<FRBaseTableViewDataSourceProtocol>) [DataSourceClass  new];
    ds.sections = make.sections;
    ds.delegates = delegates;
    self.frTableViewDataSource = ds;
    self.dataSource = ds;
    self.delegate = ds;
}

- (void)fr_makeSectionWithDatas:(NSArray *)datas {
    
    NSMutableDictionary * delegates = [[NSMutableDictionary alloc] init];
    FRTableViewSectionMaker * make = [FRTableViewSectionMaker new];
    make.datas(datas);
    make.cell([UITableViewCell class]);
    [self registerClass:make.section.cell forCellReuseIdentifier:make.section.identifier];
    
    make.section.tableViewCellStyle = UITableViewCellStyleDefault;
    for(NSUInteger i = 0; i<datas.count; i++) {
        if(datas[i][@"detail"]) {
            make.section.tableViewCellStyle = UITableViewCellStyleSubtitle;
            break;
        }
        if(datas[i][@"value"]) {
            make.section.tableViewCellStyle = UITableViewCellStyleValue1;
            break;
        }
    }
    id<FRBaseTableViewDataSourceProtocol> ds = (id<FRBaseTableViewDataSourceProtocol>) [FRSampleTableViewDataSource  new];
    
    if(!self.tableFooterView) {
        self.tableFooterView = [UIView new];
    }
    
    ds.sections = [@[make.section] mutableCopy];
    ds.delegates = delegates;
    self.frTableViewDataSource = ds;
    self.dataSource = ds;
    self.delegate = ds;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)fr_makeSectionWithDatas:(NSArray *)datas andCellClass:(Class)cellClass {
    [self fr_makeDataSource:^(FRTableViewDataSourceMaker * make) {
        [make makeSection:^(FRTableViewSectionMaker * section) {
            section.datas(datas);
            section.cell(cellClass);
            section.adapter(^(id cell,NSDictionary * row,NSUInteger index) {
                if([cell respondsToSelector:NSSelectorFromString(@"configure:")]) {
                    [cell performSelector:NSSelectorFromString(@"configure:") withObject:row];
                } else if([cell respondsToSelector:NSSelectorFromString(@"configure:index:")]) {
                    [cell performSelector:NSSelectorFromString(@"configure:index:") withObject:row withObject:@(index)];
                }
            });
            section.autoHeight();
        }];
    }];
}
#pragma clang diagnostic pop


@end

static void commitEditing(id self, SEL cmd, UITableView *tableView,UITableViewCellEditingStyle editingStyle,NSIndexPath * indexPath)
{
    FRBaseTableViewDataSource * ds = self;
    void(^block)(UITableView *,UITableViewCellEditingStyle ,NSIndexPath * ) = ds.delegates[NSStringFromSelector(cmd)];
    if(block) {
        block(tableView,editingStyle,indexPath);
    }
}

static void scrollViewDidScroll(id self, SEL cmd, UIScrollView * scrollView) {
    FRBaseTableViewDataSource * ds = self;
    void(^block)(UIScrollView *) = ds.delegates[NSStringFromSelector(cmd)];
    if(block) {
        block(scrollView);
    }
};

