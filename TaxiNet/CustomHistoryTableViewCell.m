//
//  CustomHistoryTableViewCell.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/7/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "CustomHistoryTableViewCell.h"

@implementation CustomHistoryTableViewCell

@synthesize viewDateTime,viewDriver,viewFrom,viewTo,dateTimeLb,fromAddress,toAddress,driverName;
- (void)awakeFromNib {
    // Initialization code
//    [UIColor colorWithRed:1 green:0.922 blue:0.898 alpha:1] /*#ffebe5*/
    [viewDateTime setBackgroundColor:[UIColor colorWithRed:1 green:0.475 blue:0.298 alpha:1] /*#ff794c*/];
    
    [viewFrom setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [viewTo setBackgroundColor:[UIColor colorWithRed:1 green:0.922 blue:0.898 alpha:1]];
    [viewDriver setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
