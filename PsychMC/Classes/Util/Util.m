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
    uint8_t randomBytes[count];
    (void)SecRandomCopyBytes(kSecRandomDefault, count, randomBytes); // gotta have priorities. I'm not going to put an insecure RNG in my throwaway random-stuff class.
    return (uint32_t) *randomBytes;
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
@end
