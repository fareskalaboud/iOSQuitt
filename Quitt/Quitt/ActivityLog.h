//
//  ActivityLog.h
//  Quitt
//
//  Created by James Bellamy on 23/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Habit;

@interface ActivityLog : NSManagedObject

@property (nonatomic, retain) NSNumber * log_id;
@property (nonatomic, retain) NSDate * log_time;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * habit_title;
@property (nonatomic, retain) Habit *habit;

@end
