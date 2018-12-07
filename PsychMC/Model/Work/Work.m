//
//  Work.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-06.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "Work.h"

@implementation Work

//+ (NSString *)primaryKey {
//    return @"ID";
//}

- (instancetype) init
{
    self = [super init];
    _wrongQuestions = _flaggedQuestions = _missedQuestions = @"";
    _mode = @"normal";
     _createdAt = [Util getToday];
    _curQuestionIndex = 0;
    _numberOfQuestions = MIN([[Question allInstances] count], [Setting getNumberOfQuestions]);
    
    return self;
}

- (void) updateWrongQuestions: (NSInteger) ID
{
    NSMutableArray* wrongQuestionsAsArray = [[_wrongQuestions componentsSeparatedByString:@","] mutableCopy];
    NSString* IDString = [NSString stringWithFormat:@"%ld", (long)_ID];
    if (![wrongQuestionsAsArray containsObject:IDString]) {
        [wrongQuestionsAsArray addObject:IDString];
    }
    _wrongQuestions = [wrongQuestionsAsArray componentsJoinedByString:@","];
}

- (void) updateMissedQuestions: (NSInteger) ID
{
    NSMutableArray* missedQuestionsAsArray = [[_missedQuestions componentsSeparatedByString:@","] mutableCopy];
    NSString* IDString = [NSString stringWithFormat:@"%ld", (long)_ID];
    if (![missedQuestionsAsArray containsObject:IDString]) {
        [missedQuestionsAsArray addObject:IDString];
    }
    _missedQuestions = [missedQuestionsAsArray componentsJoinedByString:@","];
}

- (void) updateFlaggedQuestions: (Question*) curQuestion
{
    NSMutableArray* flaggedQuestionsAsArray = [[_flaggedQuestions componentsSeparatedByString:@","] mutableCopy];
    NSString* IDString = [NSString stringWithFormat:@"%ld", (long)_ID];
    if (curQuestion.isFlagged) {
        [flaggedQuestionsAsArray addObject:IDString];
    } else {
        [flaggedQuestionsAsArray removeObject:IDString];
    }
    _flaggedQuestions = [flaggedQuestionsAsArray componentsJoinedByString:@","];
}
@end
