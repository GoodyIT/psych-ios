//
//  ActionCell.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-06.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "ActionCell.h"

@implementation ActionCell

static UIColor *ColorFromRGB(uint32_t colorValue) {
    return [[UIColor alloc] initWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                                  green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                                   blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
    MDCSemanticColorScheme *colorSchema = [[MDCSemanticColorScheme alloc] init];
  
    colorSchema.primaryColor = ColorFromRGB(0x212121);
    colorSchema.primaryColorVariant = ColorFromRGB(0x444444);
    colorSchema.backgroundColor = colorSchema.onPrimaryColor = colorSchema.surfaceColor = ColorFromRGB(0x212121);

//    [MDCTextButtonThemer applyScheme:buttonScheme toButton:self.checkBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapCheck:(id)sender {
    if (self.checkHandler) {
        self.checkHandler();
    }
}

- (IBAction)didTapHelp:(id)sender {
}

@end
