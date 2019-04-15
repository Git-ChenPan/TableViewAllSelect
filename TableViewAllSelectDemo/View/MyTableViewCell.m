//
//  MyTableViewCell.m
//  TableViewAllSelectDemo
//
//  Created by ChenPan on 2019/4/12.
//  Copyright © 2019 ChenPan. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 7.5, 30, 30)];
        [_btn setImage:[UIImage imageNamed:@"choice_img_default"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"choice_img_selected"] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 7.5, 200, 30)];
        _lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        _lab.textColor = [UIColor colorWithRed:73/255.0 green:81/255.0 blue:79/255.0 alpha:1.0];
        [self.contentView addSubview:_lab];
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

- (void)setModel:(MySonModel *)model
{
    _model = model;
    self.btn.selected = model.isSubDisplay;
    self.lab.text = model.TASK_NAME;
    
}


- (void)btnClicked{
    _btn.selected = !_btn.selected;
    self.model.isSubDisplay = _btn.selected;
    if (self.btnClick) {
        self.btnClick(self.indexPath);
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
