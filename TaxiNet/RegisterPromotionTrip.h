//
//  RegisterPromotionTrip.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/16/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RegisterPromotionTrip : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewDetails;
@property (strong, nonatomic) IBOutlet UIView *viewFrom;
@property (strong, nonatomic) IBOutlet UIView *viewTo;
@property (strong, nonatomic) IBOutlet UIView *viewNo;
@property (strong, nonatomic) IBOutlet UIView *viewBanner;
@property (strong, nonatomic) IBOutlet UIButton *viewSendBtn;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *pointLocation;

@property (strong, nonatomic) IBOutlet UITextField *fromField;
@property (strong, nonatomic) IBOutlet UITextField *toField;
@property (strong, nonatomic) IBOutlet UITextField *numberField;
- (IBAction)doBack:(id)sender;


@end
