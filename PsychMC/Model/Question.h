//
//  Question.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface Question : FCModel

@property (nonatomic, assign) int64_t ID; // 0
@property (nonatomic, copy) NSString* question;
@property (nonatomic, copy) NSString* answers; // Array of Answers, Seporator: #*#;
@property (nonatomic, copy) NSString* type; // multiple Or single
@property (nonatomic, copy) NSString* corrects; // Array of indexes of correct answers, Seporator: #*#;
@property (nonatomic, assign) int64_t isFree;
@property (nonatomic, assign) int64_t hasPrev; // 1: if have
@property (nonatomic, assign) int64_t nextID; // 1 if have // If nextID is -1, standalone question, else group question.
//@property (nonatomic, copy) NSString* prevAnswer; // If prevAnswer is not nil, it must to be used on the question
@property (nonatomic, copy) NSString* explanation; // Description about the answer
@property (nonatomic, copy) NSString* questionImage;
@property (nonatomic, copy) NSString* explanationImage;


// temporary
@property (nonatomic) NSMutableArray<NSString*>* selected;
@property (nonatomic) NSInteger numberOfTry;
@property (nonatomic) BOOL isAnsweredCorrectly;
@property (nonatomic) BOOL isAnswerChecked;
@property (nonatomic) BOOL isBtnTriggered;
@property (nonatomic) BOOL isFlagged;
//@property (nonatomic) Work *work;

// Functions
- (void) checkAnswer;

- (NSArray*) getCorrects;

- (void) initData;
@end

NS_ASSUME_NONNULL_END
