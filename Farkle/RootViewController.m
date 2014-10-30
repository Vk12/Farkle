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
@property (strong, nonatomic) IBOutlet UILabel *userScore;

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabelCollection;
@property NSMutableArray *heldDice;

@end

@implementation RootViewController
#pragma mark - ViewController View Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    for (DieLabel *die in self.dieLabelCollection)
    {
        die.delegate = self;
        
    }
    self.heldDice = [@[] mutableCopy];
}

#pragma mark - Die Label Delegation
-(void)dieHold:(UILabel *)tappedLabel
{
    tappedLabel.backgroundColor = [UIColor lightGrayColor];
    [self.heldDice addObject:tappedLabel];
}

#pragma mark - Button Presses

- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    NSMutableArray *dieLabelCollectionCopy = [NSMutableArray arrayWithArray:self.dieLabelCollection];
    for (DieLabel *heldDie in self.heldDice)
    {
        [dieLabelCollectionCopy removeObject:heldDie];
    }
    
    for (DieLabel *die in dieLabelCollectionCopy)
    {
        [die roll];
    }
}


- (IBAction)onBankTap:(UIButton *)sender
{
    NSInteger score = [self getScore];
    self.userScore.text = [NSString stringWithFormat:@"%li",(long)score];
}

#pragma mark - Helper Methods

- (NSInteger)getScore
{
    return 4;
}











@end
