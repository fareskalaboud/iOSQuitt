//
//  FMJReportViewController.m
//  Quitt
//
//  Created by James Bellamy on 23/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJReportViewController.h"

#import "ActivityLog.h"

#import "FMJAppDelegate.h"

@interface FMJReportViewController ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation FMJReportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [self setTitle:self.habit.title];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.managedObjectContext) {
        [self useContext];
    }
}

- (void)useContext {
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
}

#pragma mark - Properties

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ActivityLog"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"quantity"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"habit_title = %@", self.habit.title]; // all Logs for Habit
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    ActivityLog *log = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //UIView *embedView = (UIView *)[cell viewWithTag:-1];
    
    [cell.textLabel setText:[self.dateFormatter stringFromDate:log.log_time]];
    [cell.detailTextLabel setText:log.quantity.stringValue];
    
    return cell;
}


@end
