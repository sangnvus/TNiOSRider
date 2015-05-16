//
//  TripInfoViewController.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/16/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UIView *viewContent;

@property (strong, nonatomic) IBOutlet UILabel *driverName;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;

@property (strong, nonatomic) IBOutlet UILabel *fromAddress;
@property (strong, nonatomic) IBOutlet UILabel *toAddress;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *costLb;
@property (strong, nonatomic) IBOutlet UILabel *paymentMethod;


- (IBAction)doBack:(id)sender;
- (IBAction)callDriver:(id)sender;

-(void)showData:(NSArray*)data;

@end
