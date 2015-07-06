//
//  DetailViewController.m
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import "DetailViewController.h"
#import "CallViewController.h"
#import "AppDelegate.h"
#import "CFriend.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.ContactTitle.title = [NSString stringWithFormat:@"%@ %@", self.detailItem.firstName, self.detailItem.lastName];
        self.CityStateLabel.text = [NSString stringWithFormat:@"%@, %@", self.detailItem.city, self.detailItem.state];
        self.CountryLabel.text = self.detailItem.country;
        self.LevelLabel.text = [NSString stringWithFormat:@"Level: %@", self.detailItem.level];
        [self displayPictureForUser];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<SINCallClient>)callClient {
    return [[(AppDelegate *)[[UIApplication sharedApplication] delegate] sinch] callClient];
}

- (IBAction)CallAction:(id)sender {
    CallViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"callScreen"];
    [controller setCallingFriend:self.detailItem];
    id<SINCall> call = [self.callClient callUserWithId:self.detailItem.userID];
    [controller setCall:call];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void) displayPictureForUser {
    NSURL *pictureURL = [NSURL URLWithString:self.detailItem.picUrl];
    NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
    UIImage *img = [UIImage imageWithData:imageData];
    CGSize size = img.size;
    CGRect rectFrame = CGRectMake(size.width/2, size.width/2 + 50, size.width, size.height);
    UIImageView* imgv = [[UIImageView alloc] initWithImage:img];
    imgv.frame = rectFrame;
    
    // make picture into circle
    imgv.layer.cornerRadius = size.width/2;
    imgv.layer.masksToBounds = YES;
    
    [self.view addSubview:imgv];
}

@end
