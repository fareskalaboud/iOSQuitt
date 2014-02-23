//
//  FMJDashboardViewController.m
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJDashboardViewController.h"

#import "FMJAppDelegate.h"
#import "ActivityLog.h"
#import "Habit.h"
#import "FMJHabitCollectionViewController.h"
#import "FMJReportViewController.h"

@interface FMJDashboardViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addHabitButton;
@property (nonatomic) FMJHabitCollectionViewController *child;
@end

@implementation FMJDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (IBAction)addHabitMenu:(id)sender {
    UIActionSheet *addHabitSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                 destructiveButtonTitle:nil otherButtonTitles:@"Use Template Habit", @"Create Custom Habit", nil];
    [addHabitSheet showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) { // Template Chooser
        [self performSegueWithIdentifier:@"templateChooser" sender:self];
    } else if (buttonIndex == 1) { // Custom Chooser
        [self performSegueWithIdentifier:@"customChooser" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"collectionView"]) {
        FMJHabitCollectionViewController *vc = [segue destinationViewController];
        [vc setParent:self];
        [self setChild:vc];
    } else if ([segue.identifier isEqualToString:@"reports"]) {
        FMJReportViewController *vc = [segue destinationViewController];
        [vc setHabit:self.child.currentHabit];
    }
}

#pragma JDDroppableViewDelegate

- (void)droppableViewBeganDragging:(JDDroppableView*)view;
{
    //    NSLog(@"droppableViewBeganDragging");
    
	[UIView animateWithDuration:0.33 animations:^{
        //view.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
        view.alpha = 0.8;
    }];
}

- (void)droppableViewDidMove:(JDDroppableView*)view;
{
    //    NSLog(@"droppableViewDidMove:");
}

- (void)droppableViewEndedDragging:(JDDroppableView*)view onTarget:(UIView *)target
{
    //    NSLog(@"droppableViewEndedDragging:onTarget: %@", target == nil ? @"no target" : @"on target");
    
	[UIView animateWithDuration:0.33 animations:^{
//        if (!target) {
//            view.backgroundColor = [UIColor blackColor];
//        } else {
//            view.backgroundColor = [UIColor darkGrayColor];
//        }
        view.alpha = 1.0;
    }];
}

- (void)droppableView:(JDDroppableView*)view enteredTarget:(UIView*)target
{
    //    NSLog(@"droppableView:enteredTarget: %@", target == self.dropTarget1 ? @"one" : @"two");
    
    //target.transform = CGAffineTransformMakeScale(1.5, 1.5);
    
    if (target == self.dropView) {
        target.backgroundColor = [UIColor greenColor];
    }
}

- (void)droppableView:(JDDroppableView*)view leftTarget:(UIView*)target
{
    //    NSLog(@"droppableView:leftTarget: %@", target == self.dropTarget1 ? @"one" : @"two");
    
    //target.transform = CGAffineTransformMakeScale(1.0, 1.0);
    target.backgroundColor = [UIColor whiteColor];
}

- (BOOL)shouldAnimateDroppableViewBack:(JDDroppableView *)view wasDroppedOnTarget:(UIView *)target
{
    //    NSLog(@"shouldAnimateDroppableViewBack:wasDroppedOnTarget: %@", target == self.dropTarget1 ? @"one" : @"two");
    
	[self droppableView:view leftTarget:target];
    
    if (target == self.dropView) {
        [self addLog];
        return YES;
    }
    
    return NO;
}

- (void)addLog {
    NSNumber *weekInterval = [NSNumber numberWithInt:60 * 60 * 24 * 7];
    NSNumber *biweeklyInterval = [NSNumber numberWithInt:weekInterval.intValue * 2];
    
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    ActivityLog *log = [NSEntityDescription insertNewObjectForEntityForName:@"ActivityLog"
                                                     inManagedObjectContext:context];
    
    [log setLog_time:[NSDate date]];
    [log setQuantity:@1];
    [log setHabit:self.child.currentHabit];
    [log setHabit_title:self.child.currentHabit.title];
    
    [appDelegate saveContext];
}

@end
