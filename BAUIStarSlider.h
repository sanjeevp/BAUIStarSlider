//
//  BAUIStarSlider.h
//  BAUICustomSlider
//
//  Created by Sanjeev Paskaradevan on 04/05/09.
//  Copyright 2009 BeefyApps. All rights reserved.
//  www.beefyapps.com

#import <UIKit/UIKit.h>

typedef enum 
{	
	ApproximationModeNone,
	ApproximationModeWhole,
	ApproximationModeHalf
	
} SliderApproximationMode;

@interface BAUIStarSlider : UIControl {
	
	NSMutableArray * starArray;
	int numStars;
	SliderApproximationMode approxMode;
	float value;
}
@property(nonatomic) SliderApproximationMode approxMode;
@property(nonatomic) float value;

-(id)initWithFrame:(CGRect)frame andStars:(int)inNumStars;

@end
