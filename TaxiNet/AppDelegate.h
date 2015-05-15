//
//  AppDelegate.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSMutableDictionary *yoursefl;
@property (nonatomic,strong) NSMutableDictionary *promotionDataDe;
@property (nonatomic,strong) NSMutableArray *promotionDataArray;
@property (nonatomic,retain) NSMutableArray *myPromotionTripArr;
@property (nonatomic,retain) NSString *deviceToken;
@property (nonatomic,strong) NSMutableDictionary *dataDriver;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *lontitude;

@property (nonatomic,strong) NSDictionary *RiderInfo;

@property (nonatomic,strong) NSString *profileFlag;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

