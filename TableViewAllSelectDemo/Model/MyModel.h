//
//  MyModel.h
//  TableViewAllSelectDemo
//
//  Created by ChenPan on 2019/4/12.
//  Copyright © 2019 ChenPan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyModel : NSObject
@property (nonatomic,copy)NSString *PROJECT_NAME;
@property (nonatomic,strong)NSMutableArray *TaskList;
@property(nonatomic,assign)BOOL isDisplay;
@property(nonatomic,assign)BOOL isAllSel;

@end

NS_ASSUME_NONNULL_END
