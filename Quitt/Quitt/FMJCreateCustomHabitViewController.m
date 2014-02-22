//
//  FMJCreateCustomHabitViewController.m
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJCreateCustomHabitViewController.h"

#import "FMJAppDelegate.h"

@interface FMJCreateCustomHabitViewController ()

@end

@implementation FMJCreateCustomHabitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSNumber *week = [NSNumber numberWithInt:60 * 60 * 24 * 7];
    
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newHabit = [NSEntityDescription insertNewObjectForEntityForName:@"Habit"
                                                                inManagedObjectContext:context];
    [newHabit setValue: @"Habit Title" forKey:@"title"];
    [newHabit setValue: [NSDate date] forKey:@"start_date"];
    [newHabit setValue: week forKey:@"interval"];
    [newHabit setValue: NO forKey:@"requires_quantity"];
    // Clear Fields or pop view
    NSError *error;
    [context save:&error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
