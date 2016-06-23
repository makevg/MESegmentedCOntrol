//
//  MESegmentedControl.m
//  CustomSegmentedControl
//
//  Created by Максимычев Е.О. on 23.06.16.
//  Copyright © 2016 maximychev. All rights reserved.
//

#import "MESegmentedControl.h"

@interface MESegmentedControl ()
@property (nonatomic) UIView *thumbView;
@property (nonatomic) NSMutableArray<UILabel *> *labels;
@end

@implementation MESegmentedControl

#pragma mark - Lazy init

- (UIView *)thumbView {
    if (!_thumbView) {
        _thumbView = [UIView new];
    }
    return _thumbView;
}

- (NSMutableArray<UILabel *> *)labels {
    if (!_labels) {
        _labels = [NSMutableArray<UILabel *> new];
    }
    return _labels;
}

- (void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    [self setupLabels];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self displayNewSelectedIndex];
}

- (void)setSelectedLabelColor:(UIColor *)selectedLabelColor {
    _selectedLabelColor = selectedLabelColor;
    [self setSelectedColors];
}

- (void)setUnselectedLabelColor:(UIColor *)unselectedLabelColor {
    _unselectedLabelColor = unselectedLabelColor;
    [self setSelectedColors];
}

- (void)setThumbColor:(UIColor *)thumbColor {
    _thumbColor = thumbColor;
    [self setSelectedColors];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = self.borderColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self setFont];
}

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Super

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect selectFrame = self.bounds;
    CGFloat newWidth = CGRectGetWidth(selectFrame) / [self.items count];
    selectFrame.size.width = newWidth;
    self.thumbView.frame = selectFrame;
    self.thumbView.backgroundColor = self.thumbColor;
    self.thumbView.layer.cornerRadius =  CGRectGetHeight(self.thumbView.frame) / 2.f;
    
    CGFloat newHeight = CGRectGetHeight(self.frame);
    for (UILabel *label in self.labels) {
        NSUInteger index = [self.labels indexOfObject:label];
        label.frame = CGRectMake(index * newWidth, self.bounds.origin.y, newWidth, newHeight);
    }
    
    [self displayNewSelectedIndex];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:self];

    NSUInteger calculatedIndex = 0;

    for (NSUInteger index = 0; index < [self.labels count]; index++) {
        UILabel *label = self.labels[index];
        if (CGRectContainsPoint(label.frame, location)) {
            calculatedIndex = index;
        }
    }

    self.selectedIndex = calculatedIndex;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return NO;
}

#pragma mark - Public

- (NSString *)titleBySelectedIndex:(NSUInteger)selectedIndex {
    return self.items[selectedIndex];
}

#pragma mark - Private

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2.f;
    self.layer.borderColor = [UIColor colorWithWhite:1.f alpha:0.5f].CGColor;
    self.layer.borderWidth = 2.f;

    self.items = @[@"item 1", @"item 2", @"item 3"];
    self.selectedLabelColor = [UIColor blackColor];
    self.unselectedLabelColor = [UIColor whiteColor];
    self.thumbColor = [UIColor whiteColor];
    self.borderColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:12.f];
    
    [self setupLabels];

    [self insertSubview:self.thumbView atIndex:0];
}

- (void)setupLabels {
    for (UILabel *label in self.labels) {
        [label removeFromSuperview];
    }

    [self.labels removeAllObjects];

    for (NSString *item in self.items) {
        NSUInteger index = [self.items indexOfObject:item];
        UILabel *label = [UILabel new];
        label.text = self.items[index];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12.f];
        label.textColor = index == 0 ? self.selectedLabelColor : self.unselectedLabelColor;
        label.layer.cornerRadius = CGRectGetWidth(label.frame)/2.f;
        label.userInteractionEnabled = NO;
        [self addSubview:label];
        [self.labels addObject:label];
    }
}

- (void)setSelectedColors {
    for (UILabel *label in self.labels) {
        label.textColor = self.unselectedLabelColor;
    }

    if ([self.labels count] > 0) {
        self.labels[0].textColor = self.selectedLabelColor;
    }

    self.thumbView.backgroundColor = self.thumbColor;
}

- (void)setFont {
    for (UILabel *label in self.labels  ) {
        label.font = self.font;
    }
}

- (void)displayNewSelectedIndex {
    for (NSUInteger index = 0; index < [self.labels count]; index++) {
        UILabel *item = self.labels[index];
        item.textColor = self.unselectedLabelColor;
    }
    
    if ([self.labels count] > 0) {
        UILabel *label = self.labels[self.selectedIndex];
        label.textColor = self.selectedLabelColor;
        
        __weak __typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5f
                              delay:0.f
             usingSpringWithDamping:0.5f
              initialSpringVelocity:0.8f
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             weakSelf.thumbView.frame = label.frame;
                         }
                         completion:nil];
    }
}

@end
