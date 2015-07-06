//
//  DetailViewController.h
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFriend.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) CFriend *detailItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *ContactTitle;
@property (weak, nonatomic) IBOutlet UILabel *CityStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *CountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *LevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *CallButton;
- (IBAction)CallAction:(id)sender;

@end

