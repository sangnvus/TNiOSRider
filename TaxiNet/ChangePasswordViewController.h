//
//  ChangePasswordViewController.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/27/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;


@property (strong, nonatomic) IBOutlet UIView *viewBanner;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UIView *viewOldPassword;
@property (strong, nonatomic) IBOutlet UIView *viewPassword;
@property (strong, nonatomic) IBOutlet UIView *viewConfirmPass;





@property (strong, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordField;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordField;


- (IBAction)doBack:(id)sender;
- (IBAction)doSave:(id)sender;
-(void)checkPassword:(NSString*)message;

@end
