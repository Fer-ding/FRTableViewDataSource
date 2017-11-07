//
//  FRTableViewSectionMaker.m
//  FRTableViewDataSourceDemo
//
//  Created by YueHui on 2017/11/1.
//  Copyright © 2017年 Cocbin. All rights reserved.
//

#import "FRTableViewSectionMaker.h"
#import "FRDataSourceSection.h"

@implementation FRTableViewSectionMaker

- (FRTableViewSectionMaker * (^)(Class))cell {
    return ^FRTableViewSectionMaker *(Class cell) {
        self.section.cell = cell;
        if (! self.section.identifier) {
            self.section.identifier = [self getIdentifier];
        }
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(NSArray *))datas {
    return ^FRTableViewSectionMaker *(NSArray * datas) {
        self.section.datas = datas;
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(AdapterBlock))adapter {
    return ^FRTableViewSectionMaker *(AdapterBlock adapterBlock) {
        self.section.adapter = adapterBlock;
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(CGFloat))rowHeight {
    return ^FRTableViewSectionMaker *(CGFloat rowHeight) {
        self.section.rowHeight = rowHeight;
        return self;
    };
}

- (FRTableViewSectionMaker *(^)(CGFloat))headerHeight {
    return ^FRTableViewSectionMaker *(CGFloat headerHeight) {
        self.section.headerHeight = headerHeight;
        return self;
    };
}

- (FRTableViewSectionMaker *(^)(CGFloat))footerHeight {
    return ^FRTableViewSectionMaker *(CGFloat footerHeight) {
        self.section.footerHeight = footerHeight;
        return self;
    };
}

- (FRTableViewSectionMaker * (^)())autoHeight {
    return ^FRTableViewSectionMaker * {
        self.section.autoHeight = YES;
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(EventBlock))event {
    return ^FRTableViewSectionMaker *(EventBlock event) {
        self.section.event = event;
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(NSString *))headerTitle {
    return ^FRTableViewSectionMaker *(NSString * title) {
        self.section.headerTitle = title;
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(NSString *))footerTitle {
    return ^FRTableViewSectionMaker *(NSString * title) {
        self.section.footerTitle = title;
        return self;
    };
}

- (FRDataSourceSection *)section {
    if (! _section) {
        _section = [FRDataSourceSection new];
    }
    return _section;
}


- (NSString *)getIdentifier {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString * retStr = (__bridge NSString *) uuidStrRef;
    CFRelease(uuidStrRef);
    return retStr;
}

- (FRTableViewSectionMaker * (^)(UIView * (^)()))headerView {
    return ^FRTableViewSectionMaker *(UIView * (^view)()) {
        self.section.headerView = view();
        return self;
    };
}

- (FRTableViewSectionMaker * (^)(UIView * (^)()))footerView {
    return ^FRTableViewSectionMaker *(UIView * (^view)()) {
        self.section.footerView = view();
        return self;
    };
}

@end
