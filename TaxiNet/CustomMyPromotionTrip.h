//
//  CustomMyPromotionTrip.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMyPromotionTrip : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLb;
@property (strong, nonatomic) IBOutlet UILabel *statusLb;

@property (strong, nonatomic) IBOutlet UILabel *numberOfSeats;
@property (strong, nonatomic) IBOutlet UILabel *priceLb;
@property (strong, nonatomic) IBOutlet UILabel *driverLb;

@property (strong, nonatomic) IBOutlet UILabel *toLb;

@property (strong, nonatomic) IBOutlet UILabel *fromLb;

@property (strong, nonatomic) IBOutlet UIView *viewFrom;
@property (strong, nonatomic) IBOutlet UIView *viewTo;
@property (strong, nonatomic) IBOutlet UIView *viewNumber;
@property (strong, nonatomic) IBOutlet UIView *viewPrice;
@property (strong, nonatomic) IBOutlet UIView *viewDriver;
@property (strong, nonatomic) IBOutlet UIView *labelView;


@end
