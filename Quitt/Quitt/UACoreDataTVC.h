//
//  UACoreDataTVC.h
//  Unitu Mobile
//
//  Created by Liam Thorpe-Young on 06/09/2013.
//  Copyright (c) 2013 tybdev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UACoreDataTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) BOOL suspendTrackingInObjectContext;

- (void)performFetch;

@end
