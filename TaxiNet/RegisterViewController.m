//
//  RegisterViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "RegisterViewController.h"
#import "unity.h"
#import "ViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
bool checked=NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scroolview setContentSize:CGSizeMake(320,700)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"AppLogin" bundle: nil];
    LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (IBAction)save:(id)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    // check white space
   // NSRange whiteSpacea = [self.NameUser.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ( [self.NameUser.text isEqualToString:@""])
    {
        
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"please input username",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else
        if([self.EmailUser.text isEqualToString:@""]||self.EmailUser.text==nil)
        {
            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                             message:NSLocalizedString(@"please input email",nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                   otherButtonTitles:nil, nil];
            [alertTmp show];
            
            
            
        }
        else if ([emailTest evaluateWithObject:self.EmailUser.text] == NO)
        {
            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                             message:NSLocalizedString(@"please input corect email",nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                   otherButtonTitles:nil, nil];
            [alertTmp show];
        }
        else
            if( [self.PassUser.text isEqualToString:@""]|| self.PassUser.text==nil)
            {
                UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                 message:NSLocalizedString(@"please input password",nil)
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                       otherButtonTitles:nil, nil];
                [alertTmp show];
            }
            else
            {
                if (![self.PassUser.text isEqualToString:self.RepassUser.text]) {
                    UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                     message:NSLocalizedString(@"password not right",nil)
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                           otherButtonTitles:nil, nil];
                    [alertTmp show];
                }
                else
                {
                    if (checked==NO) {
                        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                         message:NSLocalizedString(@"tick checkbox",nil)
                                                                        delegate:self
                                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                               otherButtonTitles:nil, nil];
                        [alertTmp show];
                    }
                    else
                    {
                        if( [self.PhoneUser.text isEqualToString:@""]|| self.PhoneUser.text==nil)
                        {
                            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                             message:NSLocalizedString(@"please input Phonenumber",nil)
                                                                            delegate:self
                                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                                   otherButtonTitles:nil, nil];
                            [alertTmp show];
                        }
                        else
                        {
                            [unity register_by_email:self.EmailUser.text
                                            password:self.PassUser.text
                                           firstname:self.lastName.text
                                            lastname:self.NameUser.text
                                               phone:self.PhoneUser.text
                                            language:@"en" usergroup:@"RD" countrycode:@"VN"];
                            // show alert
                            
                            // return MAIN screen
                            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                            ViewController *controller = (ViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ViewController"];
                            [self.navigationController pushViewController:controller animated:YES];
                            
                        }
                    }
                }
                
            }
    
    
    
}
- (IBAction)checkRule:(id)sender {
    if (!checked) {
        UIImage *btnImage = [UIImage imageNamed:@"checkBox.png"];
        [_checkBox setImage:btnImage forState:UIControlStateNormal];
        checked=YES;
        
    }
    else
    {
        UIImage *btnImage = [UIImage imageNamed:@"checkbox_non.png"];
        [_checkBox setImage:btnImage forState:UIControlStateNormal];
        checked=NO;
    }
}
@end
