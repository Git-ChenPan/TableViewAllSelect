//
//  MyTableViewCell.h
//  TableViewAllSelectDemo
//
//  Created by ChenPan on 2019/4/12.
//  Copyright © 2019 ChenPan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"
#import "MySonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)MySonModel *model;
@property(nonatomic, strong) void(^btnClick)(NSIndexPath *);
@end

NS_ASSUME_NONNULL_END
