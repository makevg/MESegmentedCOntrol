//
//  MESegmentedControl.h
//  CustomSegmentedControl
//
//  Created by Максимычев Е.О. on 23.06.16.
//  Copyright © 2016 maximychev. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface MESegmentedControl : UIControl

@property (nonatomic) NSArray<NSString *> *items;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic) IBInspectable UIColor *selectedLabelColor;
@property (nonatomic) IBInspectable UIColor *unselectedLabelColor;
@property (nonatomic) IBInspectable UIColor *thumbColor;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable UIFont *font;

- (NSString *)titleBySelectedIndex:(NSUInteger)selectedIndex;

@end
