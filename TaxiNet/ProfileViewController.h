//
//  ProfileViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
- (IBAction)menu:(id)sender;

- (IBAction)editProfile:(id)sender;
- (IBAction)doneEditProfile:(id)sender;
- (IBAction)passwordChange:(id)sender;
- (IBAction)addAddress:(id)sender;
- (IBAction)addMoreJob:(id)sender;
- (void)checkUpdateRider;
@property (strong, nonatomic) IBOutlet UIView *ViewAll;
@property (strong, nonatomic) IBOutlet UIView *viewAccount;
@property (strong, nonatomic) IBOutlet UILabel *viewLocation;

@property (strong, nonatomic) IBOutlet UIView *viewUsualLocation;

@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *doneEditBtn;
@property (strong, nonatomic) IBOutlet UIButton *passwordChangeBtn;

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoField;

@property (strong, nonatomic) IBOutlet UILabel *firstNameLb;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLb;
@property (strong, nonatomic) IBOutlet UILabel *emailLb;
@property (strong, nonatomic) IBOutlet UILabel *phoneNoLb;

@property (strong, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic) NSDictionary *message;


@property (strong, nonatomic) IBOutlet UIImageView *riderAvatar;

-(void)showRiderDetailsToEditingWithFname:(NSString*)firstName
                               withLname:(NSString*)lastName
                               withEmail:(NSString*)email
                             withPhoneNo:(NSString*)phoneNo;

-(void)showRiderDetailsReadOnlyWithFname:(NSString*)firstName
                                  withLname:(NSString*)lastName
                                  withEmail:(NSString*)email
                                withPhoneNo:(NSString*)phoneNo;

@end
