//
//  FindPromotionTripResult.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/15/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPromotionTripResult : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)backPromotionBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backPromotionView;
@property (strong, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic) NSArray *promotionTripResult;
@property (strong, nonatomic) NSArray *proArray;
@property (strong, nonatomic) NSArray *driverArray;
@property (copy, nonatomic) NSString *nOfS;

-(int)countFlag:(NSMutableArray*)array withFlag:(int)flag;
-(void)checkAndSetData;




@end
