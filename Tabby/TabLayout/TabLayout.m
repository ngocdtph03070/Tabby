//
//  TabLayout.m
//  Tabby
//
//  Created by Đỗ Tiến Ngọc on 7/15/16.
//  Copyright © 2016 Đỗ Tiến Ngọc. All rights reserved.
//

#import "TabLayout.h"
#import "UIImage+Utils.h"
#define frameWidth(view)    view.frame.size.width
#define frameHeight(view)   view.frame.size.height
#define selfWidth           self.frame.size.width
#define selfHeight          self.frame.size.height

@interface TabLayout(){
    UIView *speractorLine;
    UIButton *buttonTab;
    NSArray *arrTabView;
    UIView *supperView;
    UIViewController *mainViewController;
    int position;
}
@end
@implementation TabLayout
@synthesize scrollTabView,scrollContentView,viewHeight,viewWidth;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame inViewController:(UIViewController *) viewController tabBackground:(UIColor *) color{
    self  = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color;
        scrollTabView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight)];
        scrollContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth,frameHeight(viewController.view) - selfHeight)];
        scrollContentView.delegate = self;
        [self addSubview:scrollTabView];
        [viewController.view addSubview:scrollContentView];
        scrollContentView.pagingEnabled = YES;
        scrollContentView.alwaysBounceHorizontal = YES;
        scrollContentView.showsVerticalScrollIndicator = NO;
        scrollContentView.showsHorizontalScrollIndicator = NO;
        supperView = viewController.view;
        mainViewController =viewController;
    }
    return self;
}

-(void) addTabArray:(NSArray *) arrayTab withStyle:(TabLayoutStyle) style {
    arrTabView = arrayTab;
    switch (style) {
        case TabLayoutIcon:
            for (int i = 0; i < arrayTab.count; i++) {
                
                buttonTab  =[[UIButton alloc] initWithFrame:CGRectMake(i * selfWidth/arrayTab.count,0, selfWidth/arrayTab.count, selfHeight -2)];
                UIViewController *viewController  = arrayTab[i];
                [buttonTab setImage:viewController.tabBarItem.image forState:UIControlStateNormal];
                [buttonTab setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
                buttonTab.tag = i;
                if (i == 0) {
                    [self.delegate tapLayoutForViewController:viewController index:i];
                }
                speractorLine=[[UIView alloc] initWithFrame:CGRectMake(0,frameHeight(buttonTab), frameWidth(buttonTab), selfHeight -frameHeight(buttonTab))];
//                [speractorLine setBackgroundColor:[UIColor whiteColor]];
                [self.delegate buttonStyle:buttonTab andSperactorStyle:speractorLine];

                [buttonTab addTarget:self action:@selector(actionIconTap:) forControlEvents:UIControlEventTouchUpInside];
                [scrollTabView addSubview:buttonTab];
                //
                viewController.view.frame =CGRectMake(i * selfWidth, 0, frameWidth(supperView), frameHeight(supperView) - selfHeight);
                
                scrollContentView.contentSize = CGSizeMake(frameWidth(viewController.view) * arrayTab.count, 1);
                
                viewController.view.tag = i;
                [mainViewController addChildViewController:viewController];
                [scrollContentView addSubview:viewController.view];
                [viewController didMoveToParentViewController:mainViewController];
                [viewController willMoveToParentViewController:mainViewController];
            }

            [scrollTabView addSubview:speractorLine];
            
            break;
        case TabLayoutTitle:
            for (int i = 0; i < arrayTab.count; i++) {
                
                buttonTab  =[[UIButton alloc] initWithFrame:CGRectMake(i * selfWidth/arrayTab.count,0, selfWidth/arrayTab.count, selfHeight -2)];
                UIViewController *viewController  = arrayTab[i];
                [buttonTab setTitle:viewController.title forState:UIControlStateNormal];
                buttonTab.tag = i;
                if (i == 0) {
                    [self.delegate tapLayoutForViewController:viewController index:i];
                }
                speractorLine=[[UIView alloc] initWithFrame:CGRectMake(0,frameHeight(buttonTab), frameWidth(buttonTab), selfHeight -frameHeight(buttonTab))];
//                [speractorLine setBackgroundColor:[UIColor whiteColor]];

                [self.delegate buttonStyle:buttonTab andSperactorStyle:speractorLine];

                [buttonTab addTarget:self action:@selector(actionIconTap:) forControlEvents:UIControlEventTouchUpInside];
                [scrollTabView addSubview:buttonTab];
                //
                viewController.view.frame =CGRectMake(i * selfWidth, 0, frameWidth(supperView), frameHeight(supperView) - selfHeight);
                
                scrollContentView.contentSize = CGSizeMake(frameWidth(viewController.view) * arrayTab.count, 1);
                
                viewController.view.tag =i;
                
                [mainViewController addChildViewController:viewController];
                [scrollContentView addSubview:viewController.view];
                [viewController didMoveToParentViewController:mainViewController];
                [viewController willMoveToParentViewController:mainViewController];
            }
            
            [scrollTabView addSubview:speractorLine];
            
            
            break;
    }
    
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    for (UIView *view in scrollView.subviews) {
        if (view.frame.origin.x == targetContentOffset->x) {
            CGRect newFrame=CGRectMake(view.tag * frameWidth(buttonTab), frameHeight(buttonTab), frameWidth(buttonTab), frameHeight(buttonTab));
            [self.delegate tapLayoutForViewController:arrTabView[view.tag] index:view.tag];
            [self.delegate tapLayoutForViewController:arrTabView[view.tag]];
            [UIView animateWithDuration:0.2 delay:.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                speractorLine.frame = newFrame;
            } completion:nil];
        }
    }
    
}
-(void)actionIconTap:(UIButton *) iconTap{
    CGRect newFrame=CGRectMake(iconTap.frame.origin.x, frameHeight(iconTap), frameWidth(iconTap), frameWidth(iconTap));
    [self.delegate tapLayoutForViewController:arrTabView[iconTap.tag] index:iconTap.tag];
    [self.delegate tapLayoutForViewController:arrTabView[iconTap.tag]];
    
    [UIView animateWithDuration:0.2 delay:.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
        scrollContentView.contentOffset = CGPointMake(iconTap.tag * frameWidth(supperView), 1);
        speractorLine.frame = newFrame;
    } completion:nil];
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [self.layer setShadowOffset:CGSizeMake(0, 1.0f/UIScreen.mainScreen.scale)];
    [self.layer setShadowRadius:0];
    
    // UINavigationBar's hairline is adaptive, its properties change with
    // the contents it overlies.  You may need to experiment with these
    // values to best match your content.
    //    self.backgroundColor =[UIColor colorWithRed:59/255.f green:89/255.f blue:152/255.f alpha:1.0];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.25f];
}
@end
