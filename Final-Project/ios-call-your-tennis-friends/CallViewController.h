//
//  CallViewController.h
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>
#import "CFriend.h"

@interface CallViewController : UIViewController <SINCallClientDelegate, SINCallDelegate>

@property CFriend *callingFriend;
@property (weak, nonatomic) IBOutlet UILabel *CallLabel;
@property (weak, nonatomic) IBOutlet UIButton *AnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *HangupButton;
@property (nonatomic, readwrite, strong) id<SINCall> call;

- (IBAction)AnswerAction:(id)sender;
- (IBAction)HangupAction:(id)sender;

@end
