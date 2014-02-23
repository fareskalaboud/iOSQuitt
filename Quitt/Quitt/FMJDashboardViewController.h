//
//  FMJDashboardViewController.h
//  Quitt
//
//  Created by James Bellamy on 22/02/2014.
//  Copyright (c) 2014 DragonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JDDroppableView.h"

@interface FMJDashboardViewController : UIViewController <JDDroppableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *dropView;

- (IBAction)addHabitMenu:(id)sender;

@end
