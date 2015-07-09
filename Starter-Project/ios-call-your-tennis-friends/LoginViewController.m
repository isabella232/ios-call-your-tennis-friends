//
//  LoginViewController.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterViewController.h"
#import "TennisParser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PasswordTextField.secureTextEntry = YES;
    // Do any additional setup after loading the view.
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

- (IBAction)LoginAction:(id)sender {
}

@end
