//
//  TabLayout.h
//  Tabby
//
//  Created by Đỗ Tiến Ngọc on 7/15/16.
//  Copyright © 2016 Đỗ Tiến Ngọc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,TabLayoutStyle){
    TabLayoutIcon,
    TabLayoutTitle
};

typedef NS_ENUM(NSUInteger,TabLayoutPosition){
    TabLayoutPositionTop,
    TabLayoutPositionBottom
};
@protocol TabLayoutDelegate <NSObject>
@required
-(void) tapLayoutForViewController:(UIViewController *)viewController;
-(void) tapLayoutForViewController:(UIViewController *) viewController index:(NSInteger) index;
@optional
-(NSArray<UIView *> *)buttonStyle:(UIButton *)buttonTab andSperactorStyle:(UIView *) speractorLine;
@end

@interface TabLayout : UIView<UIScrollViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame inViewController:(UIViewController *) viewController tabBackground:(UIColor *) color;
@property  UIScrollView *scrollTabView,*scrollContentView;;
@property  NSInteger viewHeight,viewWidth;
@property id<TabLayoutDelegate> delegate;
-(void) addTabArray:(NSArray *) arrayTab withStyle:(TabLayoutStyle) style;
@end
