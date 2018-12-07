//
//  Work.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-06.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Work : FCModel

@property NSInteger ID;
@property (nonatomic, copy) NSString* historyIDs;
@property (nonatomic, assign) NSInteger numberOfQuestions;
@property (nonatomic, copy) NSString *wrongQuestions;
@property (nonatomic, copy) NSString *flaggedQuestions;
@property (nonatomic, copy) NSString *missedQuestions;
@property (nonatomic, copy) NSString* mode; // test: user has to complete certan number of questions in certain amount of time, normal: just normal Q & A
@property (nonatomic, assign) int64_t totalTime;
@property (nonatomic, assign) int64_t elapsedTime;

@property (nonatomic, copy) NSString* createdAt;

// temporary value
@property (nonatomic) NSInteger curQuestionIndex;

// Function
- (void) updateWrongQuestions: (NSInteger) ID;
- (void) updateMissedQuestions: (NSInteger) ID;
- (void) updateFlaggedQuestions: (Question*) curQuestion;

@end

NS_ASSUME_NONNULL_END
