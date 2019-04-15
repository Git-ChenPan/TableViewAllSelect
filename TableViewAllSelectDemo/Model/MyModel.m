//
//  MyModel.m
//  TableViewAllSelectDemo
//
//  Created by ChenPan on 2019/4/12.
//  Copyright © 2019 ChenPan. All rights reserved.
//

#import "MyModel.h"
#import "MJExtension.h"

@implementation MyModel

+(NSDictionary *)mj_objectClassInArray {
    return @{
        @"TaskList":@"MySonModel"
        };
}
- (instancetype)init {
    self = [super init];
    if (self)
    {
        _isDisplay = NO;
        _isAllSel = NO;
    }
    return self;
}


@end
