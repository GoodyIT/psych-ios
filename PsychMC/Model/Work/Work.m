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
    _totalTime = _elapsedTime = 0;
    return self;
}

- (void) updateWrongQuestions: (NSInteger) ID
{
    NSMutableArray* wrongQuestionsAsArray = [[_wrongQuestions componentsSeparatedByString:@","] mutableCopy];
    NSString* IDString = [NSString stringWithFormat:@"%ld", (long)ID];
    if (![wrongQuestionsAsArray containsObject:IDString]) {
        [wrongQuestionsAsArray addObject:IDString];
    }
    _wrongQuestions = [wrongQuestionsAsArray componentsJoinedByString:@","];
}

- (void) updateMissedQuestions: (NSInteger) ID
{
    NSMutableArray* missedQuestionsAsArray = [[_missedQuestions componentsSeparatedByString:@","] mutableCopy];
    NSString* IDString = [NSString stringWithFormat:@"%ld", (long)ID];
    if (![missedQuestionsAsArray containsObject:IDString]) {
        [missedQuestionsAsArray addObject:IDString];
    }
    _missedQuestions = [missedQuestionsAsArray componentsJoinedByString:@","];
}

- (void) updateFlaggedQuestions: (Question*) curQuestion
{
    NSMutableArray* flaggedQuestionsAsArray = [[_flaggedQuestions componentsSeparatedByString:@","] mutableCopy];
    NSString* IDString = [NSString stringWithFormat:@"%ld", (long)curQuestion.ID];
    if (curQuestion.isFlagged && ![flaggedQuestionsAsArray containsObject:IDString]) {
        [flaggedQuestionsAsArray addObject:IDString];
    } else if (!curQuestion.isFlagged){
        [flaggedQuestionsAsArray removeObject:IDString];
    }
    _flaggedQuestions = [flaggedQuestionsAsArray componentsJoinedByString:@","];
}

- (NSInteger) numberOfMissedQuestions;
{
    if ([_missedQuestions isEqualToString:@""]) {
        return 0;
    }
   return [[_missedQuestions componentsSeparatedByString:@","] count]-1;
}

- (NSInteger) numberOfWrongQuestions
{
    if ([_wrongQuestions isEqualToString:@""]) {
        return 0;
    }
     return [[_wrongQuestions componentsSeparatedByString:@","] count] - 1;
}

- (NSInteger) numberOfFlaggedQuestions
{
    if ([_flaggedQuestions isEqualToString:@""]) {
        return 0;
    }
     return [[_flaggedQuestions componentsSeparatedByString:@","] count] - 1;
}
@end
