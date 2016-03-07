//
//  ADVSegmentedControl.m
//  ADVSegmented
//
//  Created by feni fa on 3/4/16.
//  Copyright © 2016 qajoo. All rights reserved.
//

#import "ADVSegmentedControl.h"
#import "UIImage+Extension.h"

@implementation ADVSegmentedControl

- (id)init {
    self = [super init];
    _thumbview = [[UIView alloc] init];
    _items = @[@"Item 1", @"Item 2", @"Item 3"];
    _selectedIndex = 0;
    _selectedLabelColor = [UIColor blackColor];
    _unselectedLabelColor = [UIColor whiteColor];
    _thumbColor = [UIColor whiteColor];
    _borderColor = [UIColor whiteColor];
    [self setupView];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    _thumbview = [[UIView alloc] init];
    _items = @[@"Item 1", @"Item 2", @"Item 3"];
    _selectedIndex = 0;
    _selectedLabelColor = [UIColor blackColor];
    _unselectedLabelColor = [UIColor whiteColor];
    _thumbColor = [UIColor whiteColor];
    _borderColor = [UIColor whiteColor];
    [self setupView];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _thumbview = [[UIView alloc] init];
    _items = @[@"Item 1", @"Item 2", @"Item 3"];
    _selectedIndex = 0;
    _selectedLabelColor = [UIColor blackColor];
    _unselectedLabelColor = [UIColor whiteColor];
    _thumbColor = [UIColor whiteColor];
    _borderColor = [UIColor whiteColor];
    [self setupView];
    return self;
}

- (void)setupView {
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderColor = [[UIColor colorWithWhite:1.0 alpha:0.5] CGColor];
    self.layer.borderWidth = 2.0f;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self setupLabels];
    
    [self addIndividualItemConstraints:buttons mainView:self padding:0.0f];
    
    [self insertSubview:_thumbview atIndex:0];
}

- (void)setupLabels {
    
    for (UIButton *button in buttons) {
        [button removeFromSuperview];
    }
    
    [buttons removeAllObjects];
    buttons = [NSMutableArray arrayWithCapacity:_items.count];
    
    for (int i = 1; i <= [_items count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 40, 40);
        button.backgroundColor = [UIColor clearColor];
        
        if ([_items[i - 1] isKindOfClass:[UIImage class]]) {
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setImage:_items[i - 1] forState:UIControlStateNormal];
        } else {
            UIImage *image = [UIImage imageNamed:_items[i - 1]];
            if(image != nil) {
                [button setTitle:@"" forState:UIControlStateNormal];
                [button setImage:image forState:UIControlStateNormal];
            } else {
                [button setTitle:_items[i - 1] forState:UIControlStateNormal];
            }
        }
        
        button.titleLabel.textColor = (i == 1)?_selectedLabelColor:_unselectedLabelColor;
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.tag = i - 1;
        [button addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [buttons addObject:button];
    }
    
    [self addIndividualItemConstraints:buttons mainView:self padding:0.0f];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    for (UIButton *item in buttons) {
        item.frame = CGRectMake(item.frame.origin.x, item.frame.origin.y, height, height);
    }
    
    CGRect selectFrame = self.bounds;
    CGFloat newWidth = CGRectGetWidth(selectFrame) / (_items.count);
    selectFrame.size.width = newWidth;
    _thumbview.frame = selectFrame;
    _thumbview.backgroundColor = _thumbColor;
    _thumbview.layer.cornerRadius = _thumbview.frame.size.height / 2;
    
    [self displayNewSelectedIndex];
}

- (IBAction)buttonActions:(id)sender {
    UIButton *button = (UIButton *)sender;
    _selectedIndex = button.tag;
    [self displayNewSelectedIndex];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)displayNewSelectedIndex {
    for (UIButton *button in buttons) {
        button.titleLabel.textColor = _unselectedLabelColor;
    }
    
    UIButton *selectedButton = buttons[_selectedIndex];
    selectedButton.titleLabel.textColor = _selectedLabelColor;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionTransitionNone animations:^{
        self.thumbview.frame = selectedButton.frame;
    } completion:nil];
    
//    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
//        
//        self.thumbView.frame = label.frame
//        
//    }, completion: nil)
}

- (void)addIndividualItemConstraints:(NSArray *)items mainView:(UIView *)mainView padding:(CGFloat)padding {
//    let constraints = mainView.constraints;
    
    for (int index = 0; index < items.count; index++) {
        UIButton *button = (UIButton *)items[index];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        
        NSLayoutConstraint *rightConstraint = nil;
        if (index == items.count - 1) {
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-padding];
        }else{
            UIButton *nextButton = (UIButton *)items[index+1];
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nextButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-padding];
        }
        
        NSLayoutConstraint *leftConstraint = nil;
        
        if (index == 0) {
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:padding];
        }else{
            UIButton *prevButton = (UIButton *)items[index-1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prevButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:padding];

            UIButton *firstItem = (UIButton *)items[0];
            
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:firstItem attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
            [mainView addConstraint:widthConstraint];
        }
        
        [mainView addConstraints:@[topConstraint,bottomConstraint,rightConstraint,leftConstraint]];
    }
}


- (void)setSelectedColors {
    for (UIButton *item in buttons) {
        item.titleLabel.textColor = _unselectedLabelColor;
    }
    
    if (buttons.count > 0) {
        UIButton *firstButton = (UIButton *)buttons[0];
        firstButton.titleLabel.textColor = _selectedLabelColor;
    }
    
    _thumbview.backgroundColor = _thumbColor;
}

@end
