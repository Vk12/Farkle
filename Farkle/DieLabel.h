//
//  DieLabel.h
//  Farkle
//
//  Created by Vala Kohnechi on 10/29/14.
//  Copyright (c) 2014 Vala Kohnechi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DieLabelDelegate <NSObject>
- (void)dieHold:(UILabel *)tappedDie;

@end


@interface DieLabel : UILabel
@property id <DieLabelDelegate> delegate;

- (void)roll;

@end
