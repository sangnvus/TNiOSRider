//
//  AppDelegate.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSMutableDictionary *yoursefl;
@property (nonatomic,strong) NSMutableDictionary *promotionDataDe;
@property (nonatomic,strong) NSMutableArray *promotionDataArray;
@property (nonatomic,retain) NSMutableArray *myPromotionTripArr;
@property (nonatomic,strong) NSDictionary *RiderInfo;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

