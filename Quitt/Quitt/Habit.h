//
//  Habit.h
//  Quitt
//
//  Created by James Bellamy on 23/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ActivityLog;

@interface Habit : NSManagedObject

@property (nonatomic, retain) NSNumber * habit_id;
@property (nonatomic, retain) NSNumber * interval;
@property (nonatomic, retain) NSNumber * requires_quantity;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) ActivityLog *activities;

@end
