//
//  ViewController.m
//  BAUIStarSlider
//
//  Created by Carl Jahn on 02.03.12.
//  Copyright (c) 2012 NIDAG. All rights reserved.
//

#import "ViewController.h"
#import "BAUIStarSlider.h"

@implementation ViewController


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

  
  self.view.backgroundColor = [UIColor purpleColor];
  
  BAUIStarSlider *slider = [BAUIStarSlider sliderWithFrame:CGRectMake(10, 10, 300, 50) stars:5];
  
  [slider setStrokeColor:[UIColor grayColor]];
  [slider setFillColor:[UIColor redColor]];
  [slider setBackgroundColor:[UIColor clearColor]];
  [slider setStarBackgroundColor:[UIColor greenColor]];
  [slider setLineWidth:1.0f];
  
  [self.view addSubview:slider];
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
