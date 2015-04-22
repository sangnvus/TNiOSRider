//
//  ShowMyPromotionTrip.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMyPromotionTrip : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) NSDictionary *promotionData;

- (IBAction)backBtn:(id)sender;

- (IBAction)findPromotion:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextToFindPro;
@property (strong, nonatomic) IBOutlet UIView *bannerView;


@end
