//
//  Scedule1.m
//  InhomeSports
//
//  Created by NewageSMB on 7/22/14.
//  Copyright (c) 2014 InhomeSports. All rights reserved.
//

#import "Scedule1.h"
#import "Schedule2.h"


@interface Scedule1 ()

@end

@implementation Scedule1




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
   
    
    
#pragma mark - calender
    
    //Calender
    
    
    keysArray=[[NSMutableArray alloc]init];
       
    currentSelectedDate=[NSDate date];
    actualCurrentDate=[NSDate date];
    [self createCalendarView:[NSDate date]];
    
    
    
    [keysArray addObject:@"4"];   // considering the day 4 has an event
    [keysArray addObject:@"17"];  // considering the day 9 has an event


}


-(void)createCalendarView:(NSDate *)date{
    
    
    globalDate = date;
    
    NSLog(@"date----%@",globalDate);
    
    
    NSArray *monthsWith30Days=[NSArray arrayWithObjects:@"September",@"April",@"June",@"November",nil];
    NSDate *today=date;
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    df.dateFormat=@"MMMM yyyy";
    monthName.text=[df stringFromDate:today];
    
    

    
    
    
    
    df.dateFormat=@"yyyy";
    int year=[[df stringFromDate:today]intValue];
    
    df.dateFormat=@"dd MM yyyy";
    NSString *todayStr=(NSMutableString *)[df stringFromDate:today];
    NSRange inRange=NSMakeRange(0, 2);
    NSString *dateFor1stDayStr=[todayStr stringByReplacingCharactersInRange:inRange withString:@"01"];
    
    df.dateFormat=@"dd MM yyyy";
    NSDate *firstDay=[df dateFromString:dateFor1stDayStr];
    df.dateFormat=@"EEE";
    NSString *firstDayName=[df stringFromDate:firstDay];
    
    df.dateFormat=@"MM";
    int currMonth=[[df stringFromDate:firstDay]intValue];
    

    
    
    int start=1;
    if([firstDayName isEqualToString:@"Sun"]){
        start=1;
    }else if([firstDayName isEqualToString:@"Mon"]){
        start=2;
    }else if([firstDayName isEqualToString:@"Tue"]){
        start=3;
    }else if([firstDayName isEqualToString:@"Wed"]){
        start=4;
    }else if([firstDayName isEqualToString:@"Thu"]){
        start=5;
    }else if([firstDayName isEqualToString:@"Fri"]){
        start=6;
    }else if([firstDayName isEqualToString:@"Sat"]){
        start=7;
    }
    df.dateFormat=@"MMMM";
    
    
    NSString *currentMonthName=[df stringFromDate:firstDay];
    
    month = currentMonthName;
    
    NSLog(@"month----%@",month);

    
    
    
    
    
    int currMonthDay=1;
    int nxtMonthDay=1;
    int febDays=1;
    BOOL found=NO;
    for (int idx=0;idx<[monthsWith30Days count];idx++) {
        if ([[monthsWith30Days objectAtIndex:idx] isEqualToString:currentMonthName]) {
            found=YES;
            break;
        }
    }
    if (found) {
        for (int tag=start; tag<=42; tag++) {
            
            
            
            
            [(UIButton *)[self.view viewWithTag:tag] setSelected:NO];
            [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:Nil forState:UIControlStateNormal];
            
            
            
            
            if (currMonthDay<31) {
                
                [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",currMonthDay] forState:UIControlStateNormal];
                ///button
                
                [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                
                /// here
                
                   NSLog(@"keysArray %@",keysArray);
                
                for (int p=0; p<keysArray.count; p++) {
                    
                    
                    if (currMonthDay==[[keysArray objectAtIndex:p] intValue]) {
                        
                        [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:[UIImage imageNamed:@"yellowsmall.png"] forState:UIControlStateNormal];
                        
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                NSDateFormatter *dfTemp=[[NSDateFormatter alloc]init];
                dfTemp.dateFormat=@"dd";
                int dd=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                dfTemp.dateFormat=@"MM";
                int tmonth=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                dfTemp.dateFormat=@"yyyy";
                int tyear=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                
                if (dd==currMonthDay && tmonth == currMonth && tyear==year) {
                    
                    
                    
                    
                    [(UIButton *)[self.view viewWithTag:tag] setSelected:YES];
                    [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                    
                    
                    //  NSLog(@"day current %i",dd);
                    
                    
                    
                }
                //  [dfTemp release];
                
                
                
                
            }else{
                
                ////button
                [(UIButton *)[self.view viewWithTag:tag] setSelected:NO];
                //next month
                [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",nxtMonthDay] forState:UIControlStateNormal];
                [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                nxtMonthDay++;
                //  NSLog(@"more than 30 ");
                
                
            }
            currMonthDay++;
            
            
            
            
            
            
            
        }
        
    }
    
    
    else
    {
        //31 days in a month and February leap year code
        
        if (currMonth==2) {
            if (year%400==0 || (year%100 !=0 && year%4 == 0)) {
                febDays=29;
            }else{
                febDays=28;
            }
            
        }
        
        //  NSLog(@":curr month %d",currMonth);
        
        
        for (int tag=start; tag<=42; tag++) {
            
            
            //      NSLog(@"currMonthDay %i",currMonthDay);
            
            if (currMonth!=2) {
                if (currMonthDay<32) {
                    
                    [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:Nil forState:UIControlStateNormal];
                    
                    
                    [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",currMonthDay] forState:UIControlStateNormal];
                    [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    
                    
                    
                    /// here
                    
                    
                    //       NSLog(@"keysArray %@",keysArray);
                    
                    
                    for (int p=0; p<keysArray.count; p++) {
                        
                        
                        if (currMonthDay==[[keysArray objectAtIndex:p] intValue]) {
                            
                            [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:[UIImage imageNamed:@"yellowsmall.png"] forState:UIControlStateNormal];
                            
                            [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    //new thing for date selection
                    [(UIButton *)[self.view viewWithTag:tag] setSelected:NO];
                    NSDateFormatter *dfTemp=[[NSDateFormatter alloc]init];
                    dfTemp.dateFormat=@"dd";
                    int dd=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    dfTemp.dateFormat=@"MM";
                    int tmonth=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    dfTemp.dateFormat=@"yyyy";
                    int tyear=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    
                    if (dd==currMonthDay && tmonth == currMonth && tyear==year) {
                        
                        
                        
                        
                        
                        [(UIButton *)[self.view viewWithTag:tag] setSelected:YES];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                        
                        
                        for (int p=0; p<keysArray.count; p++) {
                            
                            
                            if (dd==[[keysArray objectAtIndex:p] intValue]) {
                                
                                
                                
                                
                                [(UIButton *)[self.view viewWithTag:tag] setSelected:NO];
                                
                                [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:[UIImage imageNamed:@"yellowsmall.png"] forState:UIControlStateNormal];
                                
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    // [dfTemp release];
                    //end
                }else{
                    [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",nxtMonthDay] forState:UIControlStateNormal];
                    [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                    nxtMonthDay++;
                }
                currMonthDay++;
                
                
                
                
                
                
                
                
                //                for (int o=0; 0<keysArray.count; o++) {
                //
                //
                //                    if (currMonthDay==o) {
                //
                //
                //                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                //
                //                    }
                //
                //
                //                }
                //
                
                
                
                
            }else{
                if(febDays==29){
                    
                    
                    //   NSLog(@"currMonthDay %i",currMonthDay);
                    
                    if (currMonthDay<30) {
                        
                        
                        [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:Nil forState:UIControlStateNormal];
                        
                        [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",currMonthDay] forState:UIControlStateNormal];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        
                        /// here
                        
                        
                        //     NSLog(@"keysArray %@",keysArray);
                        
                        
                        for (int p=0; p<keysArray.count; p++) {
                            
                            
                            if (currMonthDay==[[keysArray objectAtIndex:p] intValue]) {
                                
                                [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:[UIImage imageNamed:@"yellowsmall.png"] forState:UIControlStateNormal];
                                [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }else{
                        [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",nxtMonthDay] forState:UIControlStateNormal];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        nxtMonthDay++;
                    }
                    //new thing for date selection
                    [(UIButton *)[self.view viewWithTag:tag] setSelected:NO];
                    NSDateFormatter *dfTemp=[[NSDateFormatter alloc]init];
                    dfTemp.dateFormat=@"dd";
                    int dd=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    dfTemp.dateFormat=@"MM";
                    int tmonth=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    dfTemp.dateFormat=@"yyyy";
                    int tyear=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    
                    if (dd==currMonthDay && tmonth == currMonth && tyear==year) {
                        
                        
                        
                        [(UIButton *)[self.view viewWithTag:tag] setSelected:YES];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                        
                        
                        
                    }
                    //  [dfTemp release];
                    //end
                    currMonthDay++;
                }else if(febDays==28){
                    
                    //  NSLog(@"currMonthDay %i",currMonthDay);
                    
                    if (currMonthDay<29) {
                        
                        [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:Nil forState:UIControlStateNormal];
                        
                        [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",currMonthDay] forState:UIControlStateNormal];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        
                        /// here
                        
                        
                        //   NSLog(@"keysArray %@",keysArray);
                        
                        
                        for (int p=0; p<keysArray.count; p++) {
                            
                            
                            if (currMonthDay==[[keysArray objectAtIndex:p] intValue]) {
                                
                                [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:[UIImage imageNamed:@"yellowsmall.png"] forState:UIControlStateNormal];
                                [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }else{
                        [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",nxtMonthDay] forState:UIControlStateNormal];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                        nxtMonthDay++;
                    }
                    //new thing for date selection
                    [(UIButton *)[self.view viewWithTag:tag] setSelected:NO];
                    NSDateFormatter *dfTemp=[[NSDateFormatter alloc]init];
                    dfTemp.dateFormat=@"dd";
                    int dd=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    dfTemp.dateFormat=@"MM";
                    int tmonth=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    dfTemp.dateFormat=@"yyyy";
                    int tyear=[[dfTemp stringFromDate:actualCurrentDate] intValue];
                    
                    if (dd==currMonthDay && tmonth == currMonth && tyear==year) {
                        
                        
                        
                        [(UIButton *)[self.view viewWithTag:tag] setSelected:YES];
                        [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                        
                        
                        
                        
                    }
                    //   [dfTemp release];
                    //end
                    currMonthDay++;
                    
                }
            }
            
            
            
            
            
            //            for (int o=0; 0<keysArray.count; o++) {
            //
            //
            //                if (currMonthDay==o) {
            //
            //
            //                    [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            //
            //                }
            //
            //
            //            }
            //
            
        }
    }
    
    int prevMonthDay=31;
    inRange=NSMakeRange(3, 2);
    NSString *dateFor1stDayOfPrevMonth;
    int prevMonth=0;
    
    if (currMonth!=1) {
        prevMonth=currMonth-1;
    }else{
        prevMonth=12;
    }
    
    
    if (prevMonth>9) {
        dateFor1stDayOfPrevMonth=[todayStr stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"%i",prevMonth]];
    }else{
        dateFor1stDayOfPrevMonth=[todayStr stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"0%i",prevMonth]];
    }
    
    // NSLog(@"--%@",dateFor1stDayOfPrevMonth);
    df.dateFormat=@"dd MM yyyy";
    NSDate *previousMonthDay=[df dateFromString:dateFor1stDayOfPrevMonth];
    df.dateFormat=@"MMMM";
    NSString *previousMonthName=[df stringFromDate:previousMonthDay];
    // NSLog(@"--%@",previousMonthName);
    
    for (int idx=0;idx<[monthsWith30Days count];idx++) {
        if ([[monthsWith30Days objectAtIndex:idx] isEqualToString:previousMonthName]) {
            found=YES;
            prevMonthDay=30;
            break;
        }
    }
    if (found) {
        for (int tag=start-1; tag!=0; tag--) {
            
            [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:Nil forState:UIControlStateNormal];
            
            [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",prevMonthDay] forState:UIControlStateNormal];
            [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            prevMonthDay--;
        }
    }else{
        if (prevMonth==2) {
            
            //check for leap year
            
            if (year%400==0 || (year%100 !=0 && year%4 == 0)) {
                prevMonthDay=29;
            }else{
                prevMonthDay=28;
            }
            
            
        }
        for (int tag=start-1; tag!=0; tag--) {
            
            [(UIButton *)[self.view viewWithTag:tag] setBackgroundImage:Nil forState:UIControlStateNormal];
            
            [(UIButton *)[self.view viewWithTag:tag] setTitle:[NSString stringWithFormat:@"%i",prevMonthDay] forState:UIControlStateNormal];
            [(UIButton *)[self.view viewWithTag:tag] setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            prevMonthDay--;
        }
        
        
    }
    
    
    
    
    
    
    
    
    PassingMonth =currMonth;
    PassingYear=year;
    
    
    
    
    
    
    df.dateFormat=@"yyyy";
    yr =[[df stringFromDate:today] integerValue];
    df.dateFormat=@"M";
    mnth=[[df stringFromDate:today] integerValue];

    

    
}













-(IBAction)gotoNextMonth:(id)sender{
    
    
    s=0;
    
    
    int currMonth=0;
    int nextYear=0;
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    
    df.dateFormat=@"dd MM yyyy";
    NSString *todayStr=[df stringFromDate:currentSelectedDate];
    
    df.dateFormat=@"MM";
    currMonth=[[df stringFromDate:currentSelectedDate] intValue];
    
    NSRange inRange=NSMakeRange(3, 2);
    NSString *dateFor1stDayOfNextMonth;
    int nextMonth=0;
    
    if (currMonth==12) {
        nextMonth=1;
        df.dateFormat=@"yyyy";
        nextYear=[[df stringFromDate:currentSelectedDate] intValue]+1;
    }else{
        nextMonth=currMonth+1;
        
    }
    if (nextMonth>9) {
        dateFor1stDayOfNextMonth=[todayStr stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"%i",nextMonth]];
    }else{
        dateFor1stDayOfNextMonth=[todayStr stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"0%i",nextMonth]];
    }
    if (nextMonth==1) {
        inRange=NSMakeRange(6, 4);
        dateFor1stDayOfNextMonth=[dateFor1stDayOfNextMonth stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"%i",nextYear]];
    }
    // NSLog(@"--%@",dateFor1stDayOfNextMonth);
    df.dateFormat=@"dd MM yyyy";
    NSDate *nextMonthDay=[df dateFromString:dateFor1stDayOfNextMonth];
    currentSelectedDate=nextMonthDay;
    [self createCalendarView:nextMonthDay];
    
    
    
}
-(IBAction)gotoPreviousMonth:(id)sender{
    s=0;
    
    
    int currMonth=0;
    int prevYear=0;
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    
    df.dateFormat=@"dd MM yyyy";
    NSString *todayStr=[df stringFromDate:currentSelectedDate];
    
    df.dateFormat=@"MM";
    currMonth=[[df stringFromDate:currentSelectedDate] intValue];
    
    NSRange inRange=NSMakeRange(3, 2);
    NSString *dateFor1stDayOfPrevMonth;
    int prevMonth=0;
    
    if (currMonth!=1) {
        prevMonth=currMonth-1;
    }else{
        prevMonth=12;
        df.dateFormat=@"yyyy";
        prevYear=[[df stringFromDate:currentSelectedDate] intValue]-1;
    }
    if (prevMonth>9) {
        dateFor1stDayOfPrevMonth=[todayStr stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"%i",prevMonth]];
    }else{
        dateFor1stDayOfPrevMonth=[todayStr stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"0%i",prevMonth]];
    }
    if (prevMonth==12) {
        inRange=NSMakeRange(6, 4);
        dateFor1stDayOfPrevMonth=[dateFor1stDayOfPrevMonth stringByReplacingCharactersInRange:inRange withString:[NSString stringWithFormat:@"%i",prevYear]];
    }
    // NSLog(@"--%@",dateFor1stDayOfPrevMonth);
    df.dateFormat=@"dd MM yyyy";
    NSDate *previousMonthDay=[df dateFromString:dateFor1stDayOfPrevMonth];
    currentSelectedDate=previousMonthDay;
    [self createCalendarView:previousMonthDay];
    
    
}




-(IBAction)btn1:(id)sender{
    
    
    NSString *title = [(UIButton *)sender currentTitle];
    NSLog(@"title-----%@",title);
        
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
