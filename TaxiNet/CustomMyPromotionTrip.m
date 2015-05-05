//
//  CustomMyPromotionTrip.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "CustomMyPromotionTrip.h"

@implementation CustomMyPromotionTrip

@synthesize dateTimeLb;
@synthesize viewDriver,viewFrom,viewNumber,viewPrice,viewTo,labelView;
- (void)awakeFromNib {
    // Initialization code
//    [UIColor colorWithRed:1 green:0.475 blue:0.298 alpha:1] /*#ff794c*/
//    [UIColor colorWithRed:1 green:0.922 blue:0.898 alpha:1] /*#ffebe5*/
//    [UIColor colorWithRed:1 green:0 blue:0.247 alpha:1] /*#ff003f*/
    [labelView setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0.247 alpha:1]];
    [viewTo setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [viewPrice setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
