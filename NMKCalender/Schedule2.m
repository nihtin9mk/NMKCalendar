//
//  Schedule2.m
//  InhomeSports
//
//  Created by NewageSMB on 7/22/14.
//  Copyright (c) 2014 InhomeSports. All rights reserved.
//

#import "Schedule2.h"
#import "AddSession.h"
#import "JSON.h"
#import "MBProgressHUD.h"


@interface Schedule2 ()

@end

@implementation Schedule2
@synthesize month, year,date,eventArray,eventDict;


#pragma mark -MBHud Methods


-(void)startLoader
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText=@"Loading ...";
}
-(void)stopLoader
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}


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
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    wrap = YES;

    
    
    NSString *string = [NSString stringWithFormat:@"%d-%d-%d",date,month,year];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
     dateFromString = [dateFormatter dateFromString:string];
     NSLog(@"%@", dateFromString);
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:dateFromString];
    
    
    
    
    
    
    totalDays = days.length;
    carousel.type = iCarouselTypeCustom;
    NSLog(@"%@", eventDict);
    [carousel reloadData];
    [self performSelector:@selector(setCarausel) withObject:nil afterDelay:.3];
    
    
    
    NSString *string2 = [NSString stringWithFormat:@"%d/%d/%d",month,date-1,year];
    NSLog(@"%@", string2);
    [dateFormatter setDateFormat:@"mm/dd/yyyy"];
    NSDate *dateT = [dateFormatter dateFromString:string2];
    NSLog(@"%@", dateT);
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateFormatter stringFromDate:dateT]);
    
    
    
    NSArray *monthArray = [NSArray arrayWithObjects:@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];
    
    
    
    monthdateLbl.text = [NSString stringWithFormat:@"%@ %d",[monthArray objectAtIndex:month-1],date];
    yeardayLbl.text = [NSString stringWithFormat:@"%@ %d",[dateFormatter stringFromDate:dateT],year];
    

    
    
    
    
    
    
    
}


-(void)getMonthDetails:(NSDate *)date{
    
    
    
    NSUserDefaults *dflts = [NSUserDefaults standardUserDefaults];

    
    
    ServerRequests *ser_req = [[ServerRequests alloc] init];
    ser_req.server_req_proces = self;
    NSString *postdata = [[NSString alloc] initWithFormat:@"{\"function\":\"get_instructor_session_day_view\", \"parameters\": {\"user_id\": \"%@\",\"session_date\": \"%@\"},\"token\":\"\"}", [dflts objectForKey:@"userid"],date];
    [self startLoader];
    
    
    
    
    [ser_req sendServerRequests:postdata];
    NSLog(@"post data %@",postdata);

    
    
}



-(void) ServerRequestProcessFinish:(NSString *) serverResponse{
    
    
    
    
    
    NSDictionary *dict = [serverResponse JSONValue];
    NSLog(@"server response %@",serverResponse);
}





-(void)setCarausel{
    
    
    carousel.currentItemIndex = date-1;
    
   // [carousel scrollToItemAtIndex:date-1 animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - Buttons

-(IBAction)addSession:(id)sender{
    
    AddSession *schedule = [[AddSession alloc]init];
    schedule.date = date;
    schedule.month = month;
    schedule.year = year;
   [self.navigationController pushViewController:schedule animated:YES];
    
    
}
-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    carousel.delegate = nil;
    carousel.dataSource = nil;
}










#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return totalDays;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    
    NSLog(@"index===%d",index);
    
    UILabel *label = nil;
    UILabel *label2 = nil;

    
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        view.backgroundColor = nil;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        
        
        
 
        
            if ([[eventDict objectForKey:[NSString stringWithFormat:@"%i",index+1]] isEqualToString:@"Y"]) {
                
              
                image.image = [UIImage imageNamed:@"yellowlarge.png"];

                
                
            }
            
            else{
                image.image = [UIImage imageNamed:@"graylarge.png"];

                
            }
        
        
        
        image.contentMode = UIViewContentModeCenter;
        [view addSubview:image];

    
    
        label = [[UILabel alloc] initWithFrame:image.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:20];
        label.tag = 1;
        [image addSubview:label];
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, 48, 30)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = UITextAlignmentCenter;
    label2.font = [label.font fontWithSize:10];
    label2.textColor = [UIColor whiteColor];
    label2.tag = 2;
    [view addSubview:label2];
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *string = [NSString stringWithFormat:@"%d/%d/%d",month,index,year];
    NSLog(@"%@", string);
    [dateFormatter setDateFormat:@"mm/dd/yyyy"];
    NSDate *dateT = [dateFormatter dateFromString:string];
    NSLog(@"%@", dateT);
    [dateFormatter setDateFormat:@"EEE"];
    
    
    
    
    label2.text = [[dateFormatter stringFromDate:dateT] uppercaseString];
    
    
    label = (UILabel *)[view viewWithTag:1];
    
    label.text =[NSString stringWithFormat:@"%d",index+1];
    
    return view;
}


- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    NSLog(@"index===%d",index);
    
    UILabel *label = nil;
    UILabel *label2 = nil;
    
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    view.backgroundColor = nil;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    
    
    
    
    if ([[eventDict objectForKey:[NSString stringWithFormat:@"%i",index+1]] isEqualToString:@"Y"]) {
        
        
        image.image = [UIImage imageNamed:@"yellowlarge.png"];
        
        
        
    }
    
    else{
        image.image = [UIImage imageNamed:@"graylarge.png"];
        
        
    }
    
    
    
    image.contentMode = UIViewContentModeCenter;
    [view addSubview:image];
    
    
    
    label = [[UILabel alloc] initWithFrame:image.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [label.font fontWithSize:15];
    label.tag = 1;
    [image addSubview:label];
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, 50, 30)];
    label2.font = [label.font fontWithSize:10];
    label2.textColor = [UIColor whiteColor];
    label2.tag = 2;
    [view addSubview:label2];
    
    
    label2.text = @"SUNDAY";
    
    
    label = (UILabel *)[view viewWithTag:1];
    
    label.text =[NSString stringWithFormat:@"%d",index+1];
    
    return view;
}



- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    CGFloat distance = 200.0f; //number of pixels to move the items away from camera
    CGFloat z = - fminf(1.0f, fabs(offset)) * distance;
    return CATransform3DTranslate(transform, offset * carousel.itemWidth, 0.0f, z);
}




- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}












- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 0.5f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeInvertedWheel)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{

    NSLog(@"Tapped view number: %d", index);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    date = index;
    
    NSString *string = [NSString stringWithFormat:@"%d/%d/%d",month,date,year];
    NSLog(@"%@", string);
    [dateFormatter setDateFormat:@"mm/dd/yyyy"];
    NSDate *dateT = [dateFormatter dateFromString:string];
    NSLog(@"%@", dateT);
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateFormatter stringFromDate:dateT]);

    
    
    
    
    
     yeardayLbl.text = [NSString stringWithFormat:@"%@ %d",[dateFormatter stringFromDate:dateT],year];
    

    
    
    
}





@end
