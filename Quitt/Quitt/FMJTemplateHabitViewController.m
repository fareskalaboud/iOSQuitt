//
//  FMJTemplateHabitViewController.m
//  Quitt
//
//  Created by James Bellamy on 23/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJTemplateHabitViewController.h"

#import "FMJAppDelegate.h"
#import "Habit.h"

@interface FMJTemplateHabitViewController ()
@property (nonatomic, strong) NSArray *templates;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation FMJTemplateHabitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSNumber *weekInterval = [NSNumber numberWithInt:60 * 60 * 24 * 7];
    NSNumber *biweeklyInterval = [NSNumber numberWithInt:weekInterval.intValue * 2];
    
    self.templates = @[@{@"title": @"Smoking", @"requires_quantity": [NSNumber numberWithBool:NO], @"interval": weekInterval},
                       @{@"title": @"Drinking", @"requires_quantity": [NSNumber numberWithBool:NO], @"interval": biweeklyInterval},
                       @{@"title": @"Swearing", @"requires_quantity": [NSNumber numberWithBool:YES], @"interval": weekInterval}];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.templates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TemplateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell.textLabel setText:self.templates[indexPath.row][@"title"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self addHabit:indexPath.row];
}

- (void)addHabit:(NSInteger)index {
    
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Habit *habit = [NSEntityDescription insertNewObjectForEntityForName:@"Habit"
                                                 inManagedObjectContext:context];
    
    [habit setTitle:self.templates[index][@"title"]];
    [habit setStart_date:[NSDate date]];
    [habit setRequires_quantity:self.templates[index][@"requires_quantity"]];
    [habit setInterval:self.templates[index][@"interval"]];
    
    [appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
