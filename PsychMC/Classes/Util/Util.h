//
//  Util.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-07.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (uint32_t)randomUInt32: (NSInteger) count;

+ (NSString*) getToday;

@end

NS_ASSUME_NONNULL_END
