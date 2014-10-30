//
//  ViewController.m
//  Farkle
//
//  Created by Vala Kohnechi on 10/29/14.
//  Copyright (c) 2014 Vala Kohnechi. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"
#define kScoreFor1 100
#define kScoreFor1s 1000
#define kScoreFor2s 200
#define kScoreFor3s 300
#define kScoreFor4s 400
#define kScoreFor5 50
#define kScoreFor5s 500
#define kScoreFor6s 600

@interface RootViewController () <DieLabelDelegate>
@property (strong, nonatomic) IBOutlet DieLabel *die0;
@property (strong, nonatomic) IBOutlet DieLabel *die1;
@property (strong, nonatomic) IBOutlet DieLabel *die2;
@property (strong, nonatomic) IBOutlet DieLabel *die3;
@property (strong, nonatomic) IBOutlet DieLabel *die4;
@property (strong, nonatomic) IBOutlet DieLabel *die5;
@property (strong, nonatomic) IBOutlet UILabel *turnLabel;
@property (strong, nonatomic) IBOutlet UILabel *player1Score;
@property (strong, nonatomic) IBOutlet UILabel *player2Score;
@property (strong, nonatomic) IBOutlet UIButton *bankButton;
@property (strong, nonatomic) IBOutlet UIButton *rollButton;
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *allDiceArray;
@property NSMutableArray *heldDice;
@property NSMutableArray *unheldDice;
@property NSInteger turnScore;
@property UIColor *dieColor;
@property NSInteger player1TotalScore;
@property NSInteger player2TotalScore;
@property BOOL isPlayer1;
@property NSString *playerString;

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
    self.isPlayer1 = YES;
    self.dieColor = self.die1.backgroundColor;
    self.unheldDice = [NSMutableArray arrayWithArray:self.allDiceArray];
    self.bankButton.enabled = NO;
}

#pragma mark - Die Label Delegation
-(void)dieHold:(UILabel *)tappedDie
{
    for (DieLabel *die in self.unheldDice)
    {
        if (tappedDie == die)
        {
            tappedDie.backgroundColor = [UIColor lightGrayColor];
            [self.heldDice addObject:tappedDie];
        }
    }
    [self.unheldDice removeObject:tappedDie];
}

#pragma mark - Button Presses

- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    // Roll unheld dice
    
    for (DieLabel *die in self.unheldDice)
    {
        [die roll];
    }
    
    NSInteger rollScore = [self getScore];
    self.turnScore = self.turnScore + rollScore;
    [self.heldDice removeAllObjects];
    self.bankButton.enabled = YES;
    
    // Check for Farkle
    [self checkFarkle];
    
}


- (IBAction)onBankTap:(UIButton *)sender
{
    // add turn score to total score and update score label
    NSInteger rollScore = [self getScore];
    self.turnScore = self.turnScore + rollScore;
    if (self.isPlayer1 == YES)
    {
        self.player1TotalScore = self.player1TotalScore + self.turnScore;
        self.player1Score.text = [NSString stringWithFormat:@"%li",(long)self.player1TotalScore];
    }
    else
    {
        self.player2TotalScore = self.player2TotalScore + self.turnScore;
        self.player2Score.text = [NSString stringWithFormat:@"%li",(long)self.player2TotalScore];
    }
    
    [self endTurn];

}

#pragma mark - Helper Methods

- (NSInteger)getScore
{
    NSInteger turnScore = 0;
    NSInteger numberof1s = 0;
    NSInteger numberof2s = 0;
    NSInteger numberof3s = 0;
    NSInteger numberof4s = 0;
    NSInteger numberof5s = 0;
    NSInteger numberof6s = 0;
    
    // count number of each number held
    
    for (DieLabel *heldDie in self.heldDice)
    {
        if ([heldDie.text isEqualToString:@"1"])
        {
            numberof1s++;
        }
        if ([heldDie.text isEqualToString:@"2"]) {
            numberof2s++;
        }
        if ([heldDie.text isEqualToString:@"3"]) {
            numberof3s++;
        }
        if ([heldDie.text isEqualToString:@"4"]) {
            numberof4s++;
        }
        if ([heldDie.text isEqualToString:@"5"]) {
            numberof5s++;
        }
        if ([heldDie.text isEqualToString:@"6"]) {
            numberof6s++;
        }
    }
    
    // genius scoring algorithm by Jon Chou
    
    turnScore = turnScore + ((numberof1s % 3) * kScoreFor1);
    turnScore = turnScore + ((numberof1s / 3) * kScoreFor1s);
    turnScore = turnScore + ((numberof2s / 3) * kScoreFor2s);
    turnScore = turnScore + ((numberof3s / 3) * kScoreFor3s);
    turnScore = turnScore + ((numberof4s / 3) * kScoreFor4s);
    turnScore = turnScore + ((numberof5s % 3) * kScoreFor5);
    turnScore = turnScore + ((numberof5s / 3) * kScoreFor5s);
    turnScore = turnScore + ((numberof6s / 3) * kScoreFor6s);
    
    return turnScore;
}

- (void)checkFarkle
{
    NSInteger numberof1s = 0;
    NSInteger numberof2s = 0;
    NSInteger numberof3s = 0;
    NSInteger numberof4s = 0;
    NSInteger numberof5s = 0;
    NSInteger numberof6s = 0;
    
    // count number of each number unheld
    
    for (DieLabel *heldDie in self.unheldDice)
    {
        if ([heldDie.text isEqualToString:@"1"])
        {
            numberof1s++;
        }
        if ([heldDie.text isEqualToString:@"2"]) {
            numberof2s++;
        }
        if ([heldDie.text isEqualToString:@"3"]) {
            numberof3s++;
        }
        if ([heldDie.text isEqualToString:@"4"]) {
            numberof4s++;
        }
        if ([heldDie.text isEqualToString:@"5"]) {
            numberof5s++;
        }
        if ([heldDie.text isEqualToString:@"6"]) {
            numberof6s++;
        }
    }
    
    if (numberof1s == 0)
    {
        <#statements#>
    }
    else if (numberof2s)
    {
        <#statements#>
    }
    
}

- (void)endTurn
{
    // reset board and score arrays
    
    for (UILabel *heldDie in self.allDiceArray)
    {
        heldDie.backgroundColor = self.dieColor;
        heldDie.text = @"--";
    }
    
    self.turnScore = 0;
    [self.heldDice removeAllObjects];
    self.unheldDice = [NSMutableArray arrayWithArray:self.allDiceArray];
    self.bankButton.enabled = NO;
   
    // change players
    
    self.isPlayer1 = !self.isPlayer1;
    if (self.isPlayer1)
    {
        self.playerString = @"Player One";
    }
    else
    {
        self.playerString = @"Player Two";
    }
    self.turnLabel.text = self.playerString;
    
    // end turn alert
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@'s turn", self.playerString] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
