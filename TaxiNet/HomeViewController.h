//
//  HomeViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JPSThumbnailAnnotation.h"
#import "UIViewController+CWPopup.h"
#import "DetailTaxi.h"
#import "unity.h"
@interface HomeViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@property (weak, nonatomic) IBOutlet UILabel *mLocationTo;
@property (weak, nonatomic) IBOutlet UIImageView *mImageFocus;
@property (weak, nonatomic) IBOutlet UILabel *mLocationFrom;
@property (weak, nonatomic) IBOutlet UIView *viewLocationFrom;
@property (weak, nonatomic) IBOutlet UIView *viewLocationTo;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic,strong) NSArray *nearTaxi;
@property (weak, nonatomic) IBOutlet UIButton *btnWaiting;
- (IBAction)waitingTaxi:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *homeviewmap;
@property (weak, nonatomic) IBOutlet UIButton *findMyTaxi;
@property (weak, nonatomic) IBOutlet UILabel *mSuggest;
@property (weak, nonatomic) IBOutlet UIView *ViewDetail;
@property (weak, nonatomic) IBOutlet UILabel *mLocationCityFrom;
@property (weak, nonatomic) IBOutlet UILabel *mLocationCityTo;
- (IBAction)setMylocation:(id)sender;

- (IBAction)BookNow:(id)sender;
-(void)checkGetnearTaxi;

@property (weak, nonatomic) IBOutlet UIView *ViewtabBar;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
- (IBAction)searchMap:(id)sender;

@end
