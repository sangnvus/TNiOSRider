//
//  TermsViewController.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/15/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "TermsViewController.h"
#import "RegisterViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set bar color
    [self.viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"AppLogin" bundle:nil];
//    RegisterViewController *controller = (RegisterViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"TermsViewController"];
//    [self.navigationController pushViewController:controller animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
