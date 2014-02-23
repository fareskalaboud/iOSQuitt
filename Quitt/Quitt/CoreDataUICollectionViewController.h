//
//  CoreDataUICollectionViewController.h
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataUICollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) BOOL suspendTrackingInObjectContext;

- (void)performFetch;

@end
