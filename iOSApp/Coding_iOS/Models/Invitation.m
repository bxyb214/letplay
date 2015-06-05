//
//  Invitation.m
//  Lets_Play
//
//  Created by HongDongZhao on 5/31/15.
//  Copyright (c) 2015 Coding. All rights reserved.
//

#import "Invitation.h"

@implementation Invitation

-(NSString *)toCreatePath{
    //TODO
    return @"activities";
}


-(NSDictionary *)toCreateParams{
    
    return @{@"title":self.title,
             @"description":self.description_mine,
             //@"preferredGender":self.preferredGender,
             @"location": self.location,
             //@"preferredAge": self.preferredAge,
             @"location_longitude":  [[NSDecimalNumber alloc] initWithDouble:self.location_longitude],
             @"location_latitude":  [[NSDecimalNumber alloc] initWithDouble:self.location_latitude],
             @"start_time":@"2015-05-30T21:23:16.000Z",
             @"created_time":@"2015-05-30T21:23:16.000Z",
             @"updated_time":@"2015-05-30T21:23:16.000Z",
             @"created_at":@"2015-05-30T21:23:16.000Z",
             @"updated_at":@"2015-05-30T21:23:16.000Z",
             @"end_time":@"2015-05-30T21:23:16.000Z",
             @"user_id":@1
             };
}

-(NSString *)toUpdatePath{
    return @"activities";
}


@end
