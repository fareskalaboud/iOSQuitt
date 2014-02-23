//
//  FMJReportViewController.h
//  Quitt
//
//  Created by James Bellamy on 23/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "UACoreDataTVC.h"

#import "Habit.h"

@interface FMJReportViewController : UACoreDataTVC

@property (nonatomic, strong) Habit *habit;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
