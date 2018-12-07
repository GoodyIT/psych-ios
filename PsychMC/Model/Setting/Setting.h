//
//  Settings.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-07.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Setting : FCModel

@property (nonatomic, assign) int64_t ID; // 1
@property (nonatomic, assign) int64_t fontSize; // 1: small, 2: normall, 3: big
@property (nonatomic, copy) NSString* fontColor;
@property (nonatomic, copy) NSString* backgroundColor;
@property (nonatomic, assign) int64_t numberOfQuestions; 
@property (nonatomic, assign) int64_t random; // 1: random on, 0: random off
@property (nonatomic) int64_t IAP; // In App Purchase


+ (UIFont*) curFont;

+ (UIColor*) curFontColor;

+ (UIColor*) curBackgroundColor;

+ (NSInteger) getNumberOfQuestions;
@end

NS_ASSUME_NONNULL_END
