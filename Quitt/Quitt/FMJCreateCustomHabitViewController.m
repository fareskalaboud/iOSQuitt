//
//  FMJCreateCustomHabitViewController.m
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJCreateCustomHabitViewController.h"

#import "FMJAppDelegate.h"

@interface FMJCreateCustomHabitViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UIDatePicker *startDatePicker;

@end

@implementation FMJCreateCustomHabitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.startDatePicker setDate:[NSDate date]];
}

- (IBAction)addHabit:(id)sender {
    
    NSNumber *week = [NSNumber numberWithInt:60 * 60 * 24 * 7];
    
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *newHabit = [NSEntityDescription insertNewObjectForEntityForName:@"Habit"
                                                              inManagedObjectContext:context];
    [newHabit setValue: self.titleField.text forKey:@"title"];
    [newHabit setValue: self.startDatePicker.date forKey:@"start_date"];
    [newHabit setValue: week forKey:@"interval"];
    [newHabit setValue: NO forKey:@"requires_quantity"];
    [self.titleField setText:@""];
    [self.startDatePicker setDate:[NSDate date]];
    
    [appDelegate saveContext];
}

- (IBAction)showLatestHabit:(id)sender {
    
//    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    
//    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Habit"
//                                                  inManagedObjectContext:context];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDesc];
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(title = %@)", self.titleField.text];
//    [request setPredicate:pred];
//    NSManagedObject *matches = nil;
//    
//    NSError *error;
//    NSArray *objects = [context executeFetchRequest:request
//                                              error:&error];
//    
//    if ([objects count] == 0) {
//        NSLog(@"No Matches");
//    } else {
//        matches = objects[0];
//        [self.titleField setText:[matches valueForKey:@"title"]];
//        [self.startDatePicker setDate:(NSDate *)[matches valueForKey:@"start_date"]];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
