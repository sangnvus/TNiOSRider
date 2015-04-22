//
//  ShowPromotionTrips.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/13/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPromotionTrips : UIViewController <UITableViewDelegate, UITableViewDataSource>
    
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;


@end
