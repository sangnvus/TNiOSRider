//
//  HistoryViewController.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/5/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)showMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain) NSArray *myHistoryTrips;

-(void)showResponseData;
@end
