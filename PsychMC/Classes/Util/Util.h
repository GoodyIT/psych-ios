//
//  Util.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-07.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Question;

@interface Util : NSObject

+ (uint32_t)randomUInt32: (NSInteger) count;

+ (NSString*) getToday;

+ (UIColor *)colorWithHexString:(NSString *)string withAlpha:(CGFloat)alpha;

+ (NSString*) randomQuestions:(NSInteger) count forFree:(NSInteger) free;

+ (Question*) getQuestionAtIndex: (NSInteger) index forQuestions: (NSString*) questions;
@end

NS_ASSUME_NONNULL_END
