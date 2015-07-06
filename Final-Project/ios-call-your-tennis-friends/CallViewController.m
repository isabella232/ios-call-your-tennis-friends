//
//  CallViewController.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "CallViewController.h"

@interface CallViewController ()

@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.call direction] == SINCallDirectionIncoming) {
        self.AnswerButton.hidden = NO;
        self.CallLabel.text = [NSString stringWithFormat:@"call from %@ %@", self.callingFriend.firstName, self.callingFriend.lastName];
    } else {
        self.AnswerButton.hidden = YES;
        self.CallLabel.text = [NSString stringWithFormat:@"calling %@ %@...", self.callingFriend.firstName, self.callingFriend.lastName];
    }
    
    [self displayPictureForUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCall:(id<SINCall>)call {
    _call = call;
    _call.delegate = self;
}

- (IBAction)AnswerAction:(id)sender {
    [self.call answer];
    self.AnswerButton.hidden = YES;
    self.CallLabel.text = @"";
    
}

- (IBAction)HangupAction:(id)sender {
    [self.call hangup];
}

- (void)callDidEstablish:(id<SINCall>)call {
    self.CallLabel.text = @"";
}

- (void)callDidEnd:(id<SINCall>)call {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) displayPictureForUser {
    NSURL *pictureURL = [NSURL URLWithString:self.callingFriend.picUrl];
    NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
    UIImage *img = [UIImage imageWithData:imageData];
    CGSize size = img.size;
    CGRect rectFrame = CGRectMake(self.view.frame.size.width/2 - size.width/2, size.width/2 + 50, size.width, size.height);
    UIImageView* imgv = [[UIImageView alloc] initWithImage:img];
    imgv.frame = rectFrame;
    
    // make picture into circle
    imgv.layer.cornerRadius = size.width/2;
    imgv.layer.masksToBounds = YES;
    
    [self.view addSubview:imgv];
}

@end
