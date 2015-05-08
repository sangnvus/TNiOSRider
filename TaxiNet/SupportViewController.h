//
//  SupportViewController.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/5/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportViewController : UIViewController
- (IBAction)showMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UIView *viewTel;
@property (strong, nonatomic) IBOutlet UIView *viewEmailSupport;

- (IBAction)sendReport:(id)sender;
- (IBAction)callToSupport:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *subjectField;
@property (strong, nonatomic) IBOutlet UITextView *contentField;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberSupport;

@end
