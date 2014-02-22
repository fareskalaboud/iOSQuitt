//
//  FMJDashboardViewController.m
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJDashboardViewController.h"

@interface FMJDashboardViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addHabitButton;
@end

@implementation FMJDashboardViewController

- (void)viewDidLoad
{
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

@end
