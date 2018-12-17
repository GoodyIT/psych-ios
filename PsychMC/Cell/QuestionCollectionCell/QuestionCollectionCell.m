//
//  QuestionCollectionCell.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-12.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "QuestionCollectionCell.h"

@implementation QuestionCollectionCell

-  (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    
    if (self)
    {
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.cellWidthConstraint = [self.contentView.widthAnchor constraintEqualToConstant:0.f];
    }
    
    return self;
}

- (void)setCellWidth:(CGFloat) width {
    self.cellWidthConstraint.constant = width;
    self.cellWidthConstraint.active = YES;
}

@end
