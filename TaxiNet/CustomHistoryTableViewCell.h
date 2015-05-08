//
//  CustomHistoryTableViewCell.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/7/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *viewDateTime;
@property (strong, nonatomic) IBOutlet UIView *viewFrom;
@property (strong, nonatomic) IBOutlet UIView *viewTo;
@property (strong, nonatomic) IBOutlet UIView *viewDriver;

@property (strong, nonatomic) IBOutlet UILabel *dateTimeLb;
@property (strong, nonatomic) IBOutlet UILabel *fromAddress;
@property (strong, nonatomic) IBOutlet UILabel *toAddress;
@property (strong, nonatomic) IBOutlet UILabel *driverName;



@end
