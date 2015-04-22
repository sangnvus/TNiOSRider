//
//  ChangeAddressViewController.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/11/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ChangeAddressViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *homeNoLb;
@property (strong, nonatomic) IBOutlet UILabel *streetLb;
@property (strong, nonatomic) IBOutlet UILabel *districLb;
@property (strong, nonatomic) IBOutlet UILabel *cityLb;

@property (strong, nonatomic) IBOutlet UITextField *homeNoField;
@property (strong, nonatomic) IBOutlet UITextField *streetField;
@property (strong, nonatomic) IBOutlet UITextField *districField;
@property (strong, nonatomic) IBOutlet UITextField *cityField;

@property (strong, nonatomic) IBOutlet UILabel *addressFullLb;

- (IBAction)getCurrentLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *pointAddressImg;
@property (strong, nonatomic) IBOutlet MKMapView *mapViewAddress;

- (IBAction)backToDetails:(id)sender;
- (IBAction)doneEditAddress:(id)sender;

@end
