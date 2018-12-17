//
//  Util.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-07.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (uint32_t)randomUInt32: (NSInteger) count
{
//    uint8_t randomBytes[4];
//    (void)SecRandomCopyBytes(kSecRandomDefault, 4, randomBytes); // gotta have priorities. I'm not going to put an insecure RNG in my throwaway random-stuff class.
//    return ((uint32_t) *randomBytes) % count;
    if (count == 1) {
        return 0;
    }
    return 1 + arc4random() % (count - 1);
}

+ (Question*) selectOneRandomlyForFree:(NSInteger) free withNonGroupQuestions:(NSMutableArray*) allNonGroupQuestions
{
    NSUInteger firstIdx = [self randomUInt32:allNonGroupQuestions.count];
    Question* question = allNonGroupQuestions[firstIdx];
    [allNonGroupQuestions removeObject:question];
    
    return question;
}

+ (void) checkGroupQuestion:(Question*) question inArray:(NSMutableArray*) allGroupQuestions forFree:(NSInteger) free randomQuestionIDs: (NSMutableArray*) randomQuestionIDs
{
    if (question.nextID > 0) {
        NSNumber* nextID = @(question.nextID);
        Question* question = [Question firstInstanceWhere:@"ID=? AND isFree=? LIMIT 1", nextID, @(free)];
        [allGroupQuestions removeObject:question];
        [randomQuestionIDs addObject:@(question.ID)];
        [self checkGroupQuestion:question inArray:allGroupQuestions forFree:free randomQuestionIDs:randomQuestionIDs];
    } else {
        return;
    }
}

+ (NSString*) randomQuestions:(NSInteger) count forFree:(NSInteger) free
{
    NSMutableArray* allGroupQuestions = [[Question instancesWhere:@"hasPrev = 1 AND isFree=?", @(free)] mutableCopy];
    NSMutableArray* allNonGroupQuestions = [[Question instancesWhere:@"hasPrev != 1 AND isFree=?", @(free)] mutableCopy];
    NSMutableArray* randomQuestionIDs = [NSMutableArray new];
    
    while (allNonGroupQuestions.count > 0 && randomQuestionIDs.count < [Setting getNumberOfQuestions]) {
        Question* question = [self selectOneRandomlyForFree:free withNonGroupQuestions: allNonGroupQuestions];
        [randomQuestionIDs addObject:@(question.ID)];
        [self checkGroupQuestion:question inArray:allGroupQuestions forFree:free randomQuestionIDs:randomQuestionIDs];
    }
    
    return [randomQuestionIDs componentsJoinedByString:@","];
}

+ (Question*) getQuestionAtIndex: (NSInteger) index forQuestions: (NSString*) questions
{
    NSInteger questionID = [[questions componentsSeparatedByString:@","][index] integerValue];
    return [Question firstInstanceWhere:@"ID=? LIMIT 1", @(questionID)];
}

+ (NSString*) getToday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy hh:mm"];
    
//    //Optionally for time zone conversions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//
    return [formatter stringFromDate:[NSDate date]];
}

+ (UIColor *)colorWithHexString:(NSString *)string withAlpha:(CGFloat)alpha
{
    
    //Quick return in case string is empty
    if (string.length == 0) {
        return nil;
    }
    
    //Check to see if we need to add a hashtag
    if('#' != [string characterAtIndex:0]) {
        string = [NSString stringWithFormat:@"#%@", string];
    }
    
    //Make sure we have a working string length
    if (string.length != 7 && string.length != 4) {
        
#ifdef DEBUG
        NSLog(@"Unsupported string format: %@", string);
#endif
        
        return nil;
    }
    
    //Check for short hex strings
    if(string.length == 4) {
        
        //Convert to full length hex string
        string = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                  [string substringWithRange:NSMakeRange(1, 1)],[string substringWithRange:NSMakeRange(1, 1)],
                  [string substringWithRange:NSMakeRange(2, 1)],[string substringWithRange:NSMakeRange(2, 1)],
                  [string substringWithRange:NSMakeRange(3, 1)],[string substringWithRange:NSMakeRange(3, 1)]];
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(1, 2)]];
    unsigned red = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(3, 2)]];
    unsigned green = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(5, 2)]];
    unsigned blue = [[self class] hexValueToUnsigned:blueHex];
    
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    
    //Define default unsigned value
    unsigned value = 0;
    
    //Scan unsigned value
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    //Return found value
    return value;
}
@end
