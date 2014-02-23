//
//  FMJHabitCollectionViewController.h
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreDataUICollectionViewController.h"

#import "FMJDashboardViewController.h"

@class Habit;

@interface FMJHabitCollectionViewController : CoreDataUICollectionViewController

@property (nonatomic) FMJDashboardViewController *parent;
@property (nonatomic, strong) Habit *currentHabit;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
