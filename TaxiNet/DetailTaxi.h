//
//  DetailTaxi.h
//  taxinet
//
//  Created by Louis Nhat on 3/31/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CWPopup.h"
#import "unity.h"
#import "CreateTrip.h"
@interface DetailTaxi : UIViewController
- (IBAction)Book:(id)sender;

- (IBAction)cancel:(id)sender;
@property (nonatomic, retain) UIViewController *vcParent;
@property (weak, nonatomic) IBOutlet UILabel *taxiname;
@property (weak, nonatomic) IBOutlet UILabel *taxiBKS;
@property (weak, nonatomic) IBOutlet UILabel *taxisheet;
@property (weak, nonatomic) IBOutlet UILabel *namedriver;
@property (weak, nonatomic) IBOutlet UIImageView *imagedriver;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *to;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (nonatomic,strong) NSMutableDictionary *dataTaxi;
@property (nonatomic,strong) NSString *localFrom;
@property (nonatomic,strong) NSString *localTo;
@property (nonatomic,strong) NSString *distancelocal;
@property (weak, nonatomic) IBOutlet UIView *boder;
@property (weak, nonatomic) IBOutlet UIView *boder1;
@property (weak, nonatomic) IBOutlet UIView *boder2;
@property (weak, nonatomic) IBOutlet UIView *boder3;
@property (weak, nonatomic) IBOutlet UIView *boder4;
- (IBAction)Call:(id)sender;

@end
