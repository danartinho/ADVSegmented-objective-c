//
//  ADVSegmentedControl.h
//  ADVSegmented
//
//  Created by feni fa on 3/4/16.
//  Copyright © 2016 qajoo. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ADVSegmentedControl : UIControl {
@private NSMutableArray *buttons;
}

@property UIView *thumbview;
@property NSArray *items;
@property NSInteger selectedIndex;
@property IBInspectable UIColor *selectedLabelColor;
@property IBInspectable UIColor *unselectedLabelColor;
@property IBInspectable UIColor *thumbColor;
@property IBInspectable UIColor *borderColor;

- (void)setupView;

@end
