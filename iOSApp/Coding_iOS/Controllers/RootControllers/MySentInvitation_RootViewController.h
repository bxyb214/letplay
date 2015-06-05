//
//  MySentInvitation_RootViewController.h
//  Lets_Play
//
//  Created by HongDongZhao on 5/20/15.
//  Copyright (c) 2015 Coding. All rights reserved.
//

#import "BaseViewController.h"
#import "Projects.h"
#import "XTSegmentControl.h"
#import "iCarousel.h"

@interface MySentInvitation_RootViewController : BaseViewController<iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) NSArray *segmentItems;
@property (assign, nonatomic) BOOL icarouselScrollEnabled;
@end
