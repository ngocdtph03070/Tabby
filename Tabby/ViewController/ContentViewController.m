//
//  ContentViewController.m
//  Tabby
//
//  Created by Đỗ Tiến Ngọc on 7/16/16.
//  Copyright © 2016 Đỗ Tiến Ngọc. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = false;
    [self loadData];
}
- (void)loadData
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    ///    [header beginRefreshing];
    
    self.tbContentView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer= [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden =YES;
    //    [footer beginRefreshing];
    self.tbContentView.mj_footer = footer;
}
-(void) loadNewData{
    [self.tbContentView.mj_header endRefreshing];
    [self.tbContentView.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"Home";
    return cell;
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Did");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
