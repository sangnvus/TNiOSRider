//
//  RegisterViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *NameUser;
@property (weak, nonatomic) IBOutlet UITextField *EmailUser;
@property (weak, nonatomic) IBOutlet UITextField *PassUser;
@property (weak, nonatomic) IBOutlet UITextField *RepassUser;
@property (weak, nonatomic) IBOutlet UITextField *PhoneUser;
- (IBAction)checkRule:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
@property (weak, nonatomic) IBOutlet UIScrollView *scroolview;

@end
