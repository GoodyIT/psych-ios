//
//  QuestionViewController.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionViewController : UITableViewController

@property (strong, nonatomic) NSString* isFirstQuestion;
@property (strong, nonatomic) Work *work;

@end

NS_ASSUME_NONNULL_END
