//
//  Schedule2.h
//  InhomeSports
//
//  Created by NewageSMB on 7/22/14.
//  Copyright (c) 2014 InhomeSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "iCarousel.h"
#import "ServerRequests.h"

@interface Schedule2 : UIViewController <iCarouselDataSource, iCarouselDelegate,ServerRequestProcessDelegate>
{
    
    AppDelegate *appDelegate;
    IBOutlet iCarousel *carousel;
    BOOL wrap;
    IBOutlet UILabel  *monthdateLbl, *yeardayLbl;

    int totalDays;
}



-(IBAction)addSession:(id)sender;
-(IBAction)back:(id)sender;



@property(nonatomic) int month, year,date;
@property(nonatomic,strong) NSDictionary *eventDict;
@property(nonatomic,strong) NSArray *eventArray;

@end
