//
//  Question.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype) init
{
    self = [super init];
    
    [self initData];
   
    return self;
}

- (void) initData
{
    _selected = [NSMutableArray new];
    _numberOfTry = 0;
    _isAnsweredCorrectly = NO;
    _isAnswerChecked = NO;
}

- (void) checkAnswer
{
    __block NSInteger countOfCorrects = 0;
    if (_selected.count == 0) {
        _isAnsweredCorrectly = NO;
    } else {
        [_selected enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* answer = [[obj componentsSeparatedByString:@"."][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([self->_corrects containsString:answer]) {
                countOfCorrects++;
            }
        }];
    }
    
    if (countOfCorrects > 0 && countOfCorrects == [[self getCorrects] count]) {
        _isAnsweredCorrectly = YES;
    }
    
    _isAnswerChecked = YES;
//    _isAnsweredCorrectly = isCorrect;
}

- (NSArray*) getCorrects
{
    return [_corrects componentsSeparatedByString:@"#*#"];
}

@end
