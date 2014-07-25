//
//  Scedule1.h
//  InhomeSports
//
//  Created by NewageSMB on 7/22/14.
//  Copyright (c) 2014 InhomeSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define kEventDate 1
#define kEventName 2


@interface Scedule1 : UIViewController

{
    
    AppDelegate *appDelegate;
    
    IBOutlet UIButton *backBtn;
   
    
    //calender
    IBOutlet UILabel *monthName;
    NSDate *currentSelectedDate, *actualCurrentDate, *globalDate;
    int PassingYear;
    int PassingMonth;
    NSString *month;
   
    
    
     NSMutableArray *keysArray;

    int yr, mnth;
    int s; //server request

}



//calender

-(IBAction)gotoPreviousMonth:(id)sender;
-(IBAction)gotoNextMonth:(id)sender;

-(void)createCalendarView:(NSDate *)date;
-(void)loadEventsList:(id)sender;
-(IBAction)btn1:(id)sender;

@end
