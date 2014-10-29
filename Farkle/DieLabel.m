//
//  DieLabel.m
//  Farkle
//
//  Created by Vala Kohnechi on 10/29/14.
//  Copyright (c) 2014 Vala Kohnechi. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

- (void)roll
{
    
    int randomNumber = arc4random_uniform(6)+1;
    self.text = [NSString stringWithFormat:@"%i",randomNumber];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        int randomNumber = arc4random_uniform(6)+1;
    
}

- (IBAction)onTapped:(UIGestureRecognizer *)sender
{
    [self.delegate dieHold:self];
}

@end
