//
//  FMJCreateCustomHabitViewController.m
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJCreateCustomHabitViewController.h"

#import "FMJAppDelegate.h"
#import "IQDropDownTextField.h"

#import "Habit.h"

@interface FMJCreateCustomHabitViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet IQDropDownTextField *startDateField;
@property (strong, nonatomic) IBOutlet IQDropDownTextField *intervalField;
@property (strong, nonatomic) IBOutlet IQDropDownTextField *iconField;
@property (strong, nonatomic) IBOutlet UISwitch *quantitySwitch;
@property (strong, nonatomic) NSDateFormatter *dropDownDateFormatter;
@end

@implementation FMJCreateCustomHabitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dropDownDateFormatter = [[NSDateFormatter alloc] init];
    [self.dropDownDateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dropDownDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [self.startDateField setInputAccessoryView:[self dropDownToolbar]];
    [self.startDateField setDropDownMode:IQDropDownModeDatePicker];
    
    [self.intervalField setInputAccessoryView:[self dropDownToolbar]];
    [self.intervalField setItemList:@[@"Weekly", @"Bi-Weekly"]];
    [self.intervalField setDropDownMode:IQDropDownModeTextPicker];
    
    [self.iconField setInputAccessoryView:[self dropDownToolbar]];
    [self.iconField setItemList:@[@"Icon 1", @"Icon 2", @"Icon 3"]];
    [self.iconField setDropDownMode:IQDropDownModeTextPicker];
}

- (UIToolbar *)dropDownToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    return toolbar;
}

- (IBAction)addHabit:(id)sender {
    
    NSNumber *weekInterval = [NSNumber numberWithInt:60 * 60 * 24 * 7];
    NSNumber *biweeklyInterval = [NSNumber numberWithInt:weekInterval.intValue * 2];
    
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Habit *habit = [NSEntityDescription insertNewObjectForEntityForName:@"Habit"
                                                 inManagedObjectContext:context];
    
    [habit setTitle:self.titleField.text];
    [habit setStart_date:[self.dropDownDateFormatter dateFromString:self.startDateField.text]];
    [habit setRequires_quantity:[NSNumber numberWithBool:self.quantitySwitch.isOn]];
    
    if ([self.intervalField.text isEqualToString:@"Weekly"]) {
        [habit setInterval:weekInterval];
    } else {
        [habit setInterval:biweeklyInterval];
    }
    
    [self.titleField setText:@""];
    [self.startDateField setText:@""];
    [self.intervalField setText:@""];
    [self.quantitySwitch setOn:NO];
    
    [appDelegate saveContext];
}

- (void)doneClicked:(UIBarButtonItem *)button {
    [self.view endEditing:YES];
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
