//
//  ViewController.m
//  TableViewAllSelectDemo
//
//  Created by ChenPan on 2019/4/12.
//  Copyright © 2019 ChenPan. All rights reserved.
//

#import "ViewController.h"
#import "MyModel.h"
#import "MySonModel.h"
#import "MyTableViewCell.h"
#import "MJExtension.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView      *tabelView;
@property(nonatomic, strong)NSMutableArray   *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多选反选，展开折叠";
    [self buildUi];
}

- (void)buildUi {
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.backgroundColor = [UIColor lightGrayColor];
    self.tabelView.tableFooterView  = [[UIView alloc]init];
    self.tabelView.rowHeight = 45;
    [self.view addSubview:self.tabelView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyModel *model = self.dataArr[section];
    return  model.isDisplay ?model.TaskList.count : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    vie.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    line.backgroundColor = [UIColor lightGrayColor];
    [vie addSubview:line];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 100, 40)];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
    MyModel *model = self.dataArr[section];
    lab.text = model.PROJECT_NAME;
    [vie addSubview:lab];
    
    //全选button
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 140, 20, 60, 30)];
    btn.tag = section + 100;
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btn setImage:[UIImage imageNamed:@"choice_img_default"] forState:UIControlStateNormal];
    [btn setTitle:@"全选" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithRed:30/255.0 green:163/255.0 blue:148/255.0 alpha:1.0] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"choice_img_selected"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = [self.dataArr[section] isAllSel];
    [vie addSubview:btn];
    
    //展开button
    UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 20, 60, 30)];
    openBtn.tag = section + 1000;
    openBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [openBtn setImage:[UIImage imageNamed:@"choice_img_default"] forState:UIControlStateNormal];
    [openBtn setImage:[UIImage imageNamed:@"choice_img_selected"] forState:UIControlStateSelected];
    [openBtn setTitle:@"展开" forState:UIControlStateNormal];
    [openBtn setTitle:@"折叠" forState:UIControlStateSelected];
    [openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor colorWithRed:30/255.0 green:163/255.0 blue:148/255.0 alpha:1.0] forState:UIControlStateSelected];
    [openBtn addTarget:self action:@selector(openBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    openBtn.selected = [self.dataArr[section] isDisplay];
    [vie addSubview:openBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 59, [UIScreen mainScreen].bounds.size.width, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [vie addSubview:line1];
    
    return vie;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.indexPath = indexPath;
    cell.model = [self.dataArr[indexPath.section] TaskList][indexPath.row];
    cell.btnClick = ^(NSIndexPath * index) {
        //点击一个cell选中;
        UIButton *button = [self.view viewWithTag:index.section + 100];
        MyModel *model = self.dataArr[index.section];
        NSMutableArray *boolAry = [NSMutableArray array];
        for (MySonModel *sonModel in [self.dataArr[index.section] TaskList]) {
            [boolAry addObject:[NSString stringWithFormat:@"%d", sonModel.isSubDisplay]];
        }
        if ([boolAry containsObject:@"1"]) {
            button.selected = YES;
            model.isAllSel = YES;
            
        }else{
            button.selected = NO;
            model.isAllSel = NO;
        }
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

//头视图button全选
-(void)btnAction:(UIButton *)btn{
    MyModel *model = self.dataArr[btn.tag - 100];
    btn.selected = !btn.selected;
    model.isAllSel = btn.selected;
    for (MySonModel *sonModel in model.TaskList) {
        sonModel.isSubDisplay = model.isAllSel;
    }
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:btn.tag-100];
    [self.tabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

//头视图按钮事件展开
-(void)openBtnClicked:(UIButton *)btn{
    MyModel *model = self.dataArr[btn.tag - 1000];
    btn.selected = !btn.selected;
    model.isDisplay = btn.selected;
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:btn.tag-1000];
    [self.tabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
         NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        //使用MJExtension字典转模型
        _dataArr = [MyModel mj_objectArrayWithKeyValuesArray:jsonDict[@"data"]];
    }
    return _dataArr;
}

@end
