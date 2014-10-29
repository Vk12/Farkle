//
//  ViewController.m
//  Farkle
//
//  Created by Vala Kohnechi on 10/29/14.
//  Copyright (c) 2014 Vala Kohnechi. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"
@interface RootViewController () <DieLabelDelegate>
@property (strong, nonatomic) IBOutlet DieLabel *die0;
@property (strong, nonatomic) IBOutlet DieLabel *die1;
@property (strong, nonatomic) IBOutlet DieLabel *die2;
@property (strong, nonatomic) IBOutlet DieLabel *die3;
@property (strong, nonatomic) IBOutlet DieLabel *die4;
@property (strong, nonatomic) IBOutlet DieLabel *die5;

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabelCollection;
@property NSMutableArray *dice;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (DieLabel *die in self.dieLabelCollection)
    {
        die.delegate = self;
        
    }
    self.dice = [@[] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    for (DieLabel *die in self.dieLabelCollection)
    {
        [die roll];
    }
}

-(void)dieHold:(UILabel *)tappedLabel
{
    [self.dice addObject:tappedLabel];
}







@end
