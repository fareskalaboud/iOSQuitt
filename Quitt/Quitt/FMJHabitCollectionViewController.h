//
//  FMJHabitCollectionViewController.h
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreDataUICollectionViewController.h"

@interface FMJHabitCollectionViewController : CoreDataUICollectionViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
