//
//  FindPromotionTrip.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "JPSThumbnailAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

@interface FindPromotionTrip : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewLocationFrom;
@property (strong, nonatomic) IBOutlet UIView *viewLocationTo;
@property (strong, nonatomic) IBOutlet UIView *viewNumber;
@property (strong, nonatomic) IBOutlet UIView *viewDateTime;
@property (strong, nonatomic) IBOutlet UIView *viewToCity;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateTime;
@property (strong, nonatomic) IBOutlet UIView *viewFromCity;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLb;


- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *fromCityField;
@property (strong, nonatomic) IBOutlet UITextField *toCityField;
@property (strong, nonatomic) IBOutlet UITextField *fromAddress;
@property (strong, nonatomic) IBOutlet UITextField *toAddress;
@property (strong, nonatomic) IBOutlet UITextField *noOfSeatsField;
@property (strong, nonatomic) IBOutlet UIImageView *pointPick;
@property (strong, nonatomic) IBOutlet MKMapView *mapViewPro;
@property (strong, nonatomic) IBOutlet UIButton *findBtn;

@property (strong, nonatomic) IBOutlet UIView *viewDetails;

@property (strong, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic) NSDictionary *promotionData;
@property (strong,nonatomic) NSArray *promotionDataArr;

- (IBAction)getCurrentLocation:(id)sender;
- (IBAction)findPromotion:(id)sender;
-(void)checkAndSetData;
@end
