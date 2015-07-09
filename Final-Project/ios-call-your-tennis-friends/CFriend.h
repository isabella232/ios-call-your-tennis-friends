//
//  CFriend.h
//  ios-call-your-tennis-friends
//
//  Created by Ali Minty on 7/5/15.
//  Copyright (c) 2015 Ali Minty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFriend : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *userID;
@property NSString *country;
@property NSString *state;
@property NSString *city;
@property NSString *level;
@property NSString *gender;
@property NSString *picUrl;

/*- (id) initWithFirstname:(NSString *)firstname
                Lastname:(NSString *) lastname
                  UserID:(NSString *)userID
                 Country:(NSString *)country
                   State:(NSString *)state
                    City:(NSString *)city
                   Level:(NSString *)level
                  Gender:(NSString *)gender
                  PicUrl:(NSString *)picUrl;
 */

@end
