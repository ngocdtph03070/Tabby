//
//  ViewController.m
//  Tabby
//
//  Created by Đỗ Tiến Ngọc on 7/15/16.
//  Copyright © 2016 Đỗ Tiến Ngọc. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"
#import "StarViewController.h"
#import "NotifyCationViewController.h"
@interface ViewController (){
    NSArray *arrVC,*arrVCTitle;
    UILabel *titleLabel;
    NSInteger oldIndex;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initNavigaiton];
    [self initTabLayout:1];
  
}
-(void) initNavigaiton{
    [self.navigationController.navigationBar setTranslucent:false];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font =[UIFont boldSystemFontOfSize:18];
    UIBarButtonItem *itemTitle =[[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    self.navigationItem.leftBarButtonItem = itemTitle;
    titleLabel.text = @"Tabby";
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    [self initTabLayout:1];


//    [self initTabLayout:2];
}
-(void) initTabLayout:(int) type{
    ContentViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    homeVC.title = @"Trang chủ";
    homeVC.tabBarItem.image =[UIImage imageNamed:@"home"];
  
    
    StarViewController *starVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StarViewController"];
    starVC.title = @"Ngôi sao";
    starVC.tabBarItem.image =[UIImage imageNamed:@"star"];
    
    NotifyCationViewController *notifyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotifyCationViewController"];
    notifyVC.title =@"Thông báo";
    notifyVC.tabBarItem.image =[UIImage imageNamed:@"alarm"];
    
    NotifyCationViewController *hotVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotifyCationViewController"];
    hotVC.title =@"Nóng";
    hotVC.tabBarItem.image =[UIImage imageNamed:@"fire"];
    
    NotifyCationViewController *wirelessVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotifyCationViewController"];
    wirelessVC.title =@"Quanh đây";
    wirelessVC.tabBarItem.image =[UIImage imageNamed:@"wireless"];
  
    arrVC=@[homeVC,starVC,notifyVC,hotVC,wirelessVC];
    arrVCTitle=@[homeVC,starVC,notifyVC];
    TabLayout *tabLayout =[[TabLayout alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,50)inViewController:self tabBackground:[UIColor colorWithRed:0/255.f green:175/255.f blue:240/255.f alpha:1.0]];
    tabLayout.delegate = self;

    if (type == 1) {
        [tabLayout addTabArray:arrVC withStyle:TabLayoutIcon];
    }else{
        [tabLayout addTabArray:arrVCTitle withStyle:TabLayoutTitle];
    }
    [self.view addSubview:tabLayout];
}

//Delegate TapLayout
-(void)tapLayoutForViewController:(UIViewController *)viewController index:(NSInteger)index{
//    titleLabel.text = viewController.title;
    self.navigationItem.rightBarButtonItem = nil;
    if ([viewController isKindOfClass:[ContentViewController class]]) {
        UIBarButtonItem *itemMore =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:nil];
        UIBarButtonItem *itemSearch =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItems =@[itemMore,itemSearch];

    }else if([viewController isKindOfClass:[StarViewController class]]){
        UIBarButtonItem *itemTitle =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItem = itemTitle;
    }else if ([viewController isKindOfClass:[NotifyCationViewController class]]){
        UIBarButtonItem *itemTitle =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItem = itemTitle;
    }else{
        UIBarButtonItem *itemTitle =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItem = itemTitle;
    }
}
-(NSArray<UIView *> *)buttonStyle:(UIButton *)buttonTab andSperactorStyle:(UIView *) speractorLine {
    buttonTab.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    speractorLine.backgroundColor =[UIColor whiteColor];
    return @[buttonTab,speractorLine];
}
-(void)tapLayoutForViewController:(UIViewController *)viewController{

    [viewController viewWillAppear:YES];
    [viewController viewDidAppear:YES];
//    [viewController willMoveToParentViewController:self];
//    [viewController didMoveToParentViewController:self];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}
- (void)removeAtIndex:(NSInteger)index
{
    UIViewController *oldVC = arrVC[index];
    
    [oldVC willMoveToParentViewController:nil];
    
    [oldVC.view removeFromSuperview];
    [oldVC removeFromParentViewController];
    
    [oldVC didMoveToParentViewController:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
