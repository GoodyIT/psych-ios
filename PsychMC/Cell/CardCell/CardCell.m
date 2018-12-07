//
//  CardCell.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "CardCell.h"
//#import "MaterialShadowLayer.h"

@implementation CardCell
//
//+ (Class)layerClass {
//    return [MDCShadowLayer class];
//}
//
//- (MDCShadowLayer *)shadowLayer {
//    return (MDCShadowLayer *)self.layer;
//}
//
//- (void)setDefaultElevation {
//    self.shadowLayer.elevation = MDCShadowElevationCardResting;
//}
//
//- (void) layoutSubviews
//{
//    [super layoutSubviews];
//    [self.contentView setFrame:UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(0, 26, 0, 26))];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self setDefaultElevation];
    self.card.cornerRadius = 8.0f;
    self.successText.lineBreakMode = NSLineBreakByWordWrapping;
    self.successText.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateText: (Question*) question
{
    if (question.isAnsweredCorrectly) {
        self.successText.text = @"That's Correct";
    } else {
        self.successText.text = @"That is not correct.";
    }
    self.explanation.text = question.explanation;
}

@end
