//
//  ViewController.m
//  Farkle
//
//  Created by Vala Kohnechi on 10/29/14.
//  Copyright (c) 2014 Vala Kohnechi. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"
#define kScoreFor1s 1000

@interface RootViewController () <DieLabelDelegate>
@property (strong, nonatomic) IBOutlet DieLabel *die0;
@property (strong, nonatomic) IBOutlet DieLabel *die1;
@property (strong, nonatomic) IBOutlet DieLabel *die2;
@property (strong, nonatomic) IBOutlet DieLabel *die3;
@property (strong, nonatomic) IBOutlet DieLabel *die4;
@property (strong, nonatomic) IBOutlet DieLabel *die5;
@property (strong, nonatomic) IBOutlet UILabel *userScore;
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *allDiceArray;
@property NSMutableArray *heldDice;
@property NSInteger totalScore;
@property UIColor *dieColor;

@end

@implementation RootViewController
#pragma mark - ViewController View Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    for (DieLabel *die in self.allDiceArray)
    {
        die.delegate = self;
    }
    self.heldDice = [@[] mutableCopy];
    self.dieColor = self.die1.backgroundColor;
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
    
    // Roll unheld dice
    NSMutableArray *unheldDice = [NSMutableArray arrayWithArray:self.allDiceArray];
    for (DieLabel *heldDie in self.heldDice)
    {
        [unheldDice removeObject:heldDie];
    }
    
    for (DieLabel *die in unheldDice)
    {
        [die roll];
    }
    
    
}


- (IBAction)onBankTap:(UIButton *)sender
{
    // add turn score to total score and update score label
    NSInteger turnScore = [self getScore];
    self.totalScore = self.totalScore + turnScore;
    self.userScore.text = [NSString stringWithFormat:@"%li",(long)self.totalScore];
    
    // clear board
    [self.heldDice removeAllObjects];
    
    for (UILabel *heldDie in self.allDiceArray)
    {
        heldDie.backgroundColor = self.dieColor;
        heldDie.text = @"--";
    }
}

#pragma mark - Helper Methods

- (NSInteger)getScore
{
    NSInteger turnScore = 0;
    int numberof1s = 0;
    
    // count number of each number
    for (DieLabel *heldDie in self.heldDice)
    {
        if ([heldDie.text isEqualToString:@"1"])
        {
            numberof1s++;
        }
    }
    
    // scoring
    if (numberof1s == 3)
    {
        turnScore = turnScore + kScoreFor1s;
    }
    if (numberof1s == 6) {
        turnScore = turnScore + (2 * kScoreFor1s);
    }
    
    return turnScore;
}











@end
