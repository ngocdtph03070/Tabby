//
//  ContentViewController.h
//  Tabby
//
//  Created by Đỗ Tiến Ngọc on 7/16/16.
//  Copyright © 2016 Đỗ Tiến Ngọc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface ContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbContentView;

@end
