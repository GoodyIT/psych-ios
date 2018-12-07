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
    _type = @"normal";
    return self;
}

@end
