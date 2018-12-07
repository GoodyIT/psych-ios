//
//  ActionCell.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-06.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MDCButton *checkBtn;
@property (strong, nonatomic)  CompletionHandler checkHandler;
@end

NS_ASSUME_NONNULL_END
