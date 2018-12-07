//
//  CardCell.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialCards.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MDCCard *card;
@property (weak, nonatomic) IBOutlet UILabel *explanation;
@property (weak, nonatomic) IBOutlet UILabel *successText;

- (void) updateText: (Question*) question;

@end

NS_ASSUME_NONNULL_END
