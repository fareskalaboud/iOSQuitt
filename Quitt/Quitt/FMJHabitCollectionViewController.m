//
//  FMJHabitCollectionViewController.m
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import "FMJHabitCollectionViewController.h"

#import "FMJAppDelegate.h"
#import "Habit.h"

@interface FMJHabitCollectionViewController() <UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation FMJHabitCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.managedObjectContext) {
        [self useContext];
    }
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
}

- (void)useContext {
    FMJAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 260);
}

#pragma mark - Properties

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Habit"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        //request.predicate = [NSPredicate predicateWithFormat:@"userID != %@", userID]; // all Connections
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HabitCell";
    
    Habit *habit = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    [titleLabel setText:habit.title];
    
    NSDate *date = [NSDate date];
    NSDate *start_date = [habit start_date];
    
    
    
    NSTimeInterval diff = [date timeIntervalSinceDate:start_date];
    
    while (diff > habit.interval.doubleValue) {
        diff = diff - habit.interval.doubleValue;
    }
    
    UILabel *intervalLabel = (UILabel *)[cell viewWithTag:2];
    NSDate *finalDate = [NSDate dateWithTimeInterval:diff sinceDate:date];
    NSString *dateString = [self.dateFormatter stringFromDate:finalDate];
    [intervalLabel setText:[NSString stringWithFormat:@"Next Report on %@", dateString]];
    
    return cell;
}

@end
