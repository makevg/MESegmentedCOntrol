//
//  ViewController.m
//  CustomSegmentedControl
//
//  Created by Максимычев Е.О. on 23.06.16.
//  Copyright © 2016 maximychev. All rights reserved.
//

#import "ViewController.h"
#import "MESegmentedControl.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MESegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *selectedIndexLabel;
@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl.items = @[@"2 дня", @"3 дня", @"4 дня"];
}

#pragma mark - Actions

- (IBAction)segmentedControlValueChanged:(id)sender {
    self.selectedIndexLabel.text = [self.segmentedControl titleBySelectedIndex:self.segmentedControl.selectedIndex];
}

@end
