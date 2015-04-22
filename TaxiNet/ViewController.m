//
//  ViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Register:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"AppLogin" bundle: nil];
    RegisterViewController *controller = (RegisterViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"RegisterViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)Login:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"AppLogin" bundle: nil];
    LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
