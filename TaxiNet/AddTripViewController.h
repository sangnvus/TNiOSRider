//
//  AddTripViewController.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/23/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JPSThumbnailAnnotation.h"

@interface AddTripViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mImageFocus;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UILabel *txtAdressFrom;
@property (weak, nonatomic) IBOutlet UILabel *txtAdressTo;
@property (weak, nonatomic) IBOutlet UILabel *txtDateTime;
@property (weak, nonatomic) IBOutlet UILabel *txtSheetFree;
@property (weak, nonatomic) IBOutlet UIView *viewDetailFrom;
@property (weak, nonatomic) IBOutlet UIView *viewDetailTo;
@property (weak, nonatomic) IBOutlet UIView *viewDetailTime;
@property (weak, nonatomic) IBOutlet UIView *viewDetailSheet;
@property (weak, nonatomic) IBOutlet UIView *viewDetail;
- (IBAction)AddPromotionTrip:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIView *ViewPicker;
- (IBAction)cancelPicker:(id)sender;
- (IBAction)savePicker:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;
- (IBAction)CancelSheet:(id)sender;
- (IBAction)SaveSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewPickerSheet;
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (weak, nonatomic) IBOutlet UIView *ViewtabBar;

@end
