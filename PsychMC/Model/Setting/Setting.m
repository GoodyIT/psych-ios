//
//  Settings.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-07.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "Setting.h"

@implementation Setting

+ (UIFont*) curFont
{
    NSArray* fontArray = @[@(27.0), @(20.0), @(23.0)];
    
    CGFloat curFontSize = [fontArray[((Setting*)[Setting allInstances][0]).fontSize - 1] floatValue];
    //return [UIFont systemFontOfSize:curFontSize];
    return [UIFont fontWithName:@"Helvetica" size:curFontSize];
}

+ (UIColor*) curFontColor
{
    return [Util colorWithHexString:((Setting*)[Setting allInstances][0]).fontColor withAlpha:1];
}

+ (UIColor*) curBackgroundColor
{
      return [Util colorWithHexString:((Setting*)[Setting allInstances][0]).backgroundColor withAlpha:1];
}

+ (NSInteger) getNumberOfQuestions
{
    return ((Setting*)[Setting allInstances][0]).numberOfQuestions;
}

@end
