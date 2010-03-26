//
//  BAUIStarSlider.m
//  BAUICustomSlider
//
//  Created by Sanjeev Paskaradevan on 04/05/09.
//  Copyright 2009 BeefyApps. All rights reserved.
//  www.beefyapps.com

#import "BAUIStarSlider.h"
#import "BAFillableStar.h"

@interface BAUIStarSlider (Private)
-(float)getApproximatedPart:(float)part;
-(void)fillStars;
@end

@implementation BAUIStarSlider

@synthesize approxMode, value;

-(id)initWithFrame:(CGRect)frame andStars:(int)inNumStars
{
	if (self = [super initWithFrame:frame])
	{
		numStars = inNumStars;
		starArray = [[NSMutableArray alloc] initWithCapacity:numStars];
		approxMode = ApproximationModeWhole; //default approximation mode
		
		float width = frame.size.width/numStars;
		float height = frame.size.height;
		
		for(int i=0; i<numStars; i++)
		{
			BAFillableStar * star = [[BAFillableStar alloc] initWithFrame:CGRectMake(0+(i*width), 0, width, height)];
			[starArray addObject:star];
			[self addSubview:star];
			[star release];
		}
	}
	
	return self;
}

- (void)dealloc {
	[starArray release];
    [super dealloc];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	
	//make sure the points are within our bounds
	if(touchPoint.x < 0 )
	{
		touchPoint.x = 0;
	}
	if(touchPoint.x > self.frame.size.width)
	{
		touchPoint.x = self.frame.size.width;
	}
	
	value = touchPoint.x / (self.frame.size.width/numStars);
	[self fillStars];
}

-(void)fillStars{
	
	float whole = floor(value);
	float part = value - whole;
	part = [self getApproximatedPart:part];
	
	value = whole+part;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	
	int i = 0;
	for(BAFillableStar * star in starArray)
	{
		if( i < whole)
		{
			star.fillPercent = 1;
			
		}
		else if ( part > 0 )
		{
			star.fillPercent = part;
			part = 0;
		
		}
		else
		{
			star.fillPercent = 0;
	
		}
		
		i++;
	}

}

-(float)getApproximatedPart:(float)part
{
	if(approxMode == ApproximationModeWhole)
	{
		if(part > 0 )
		{
			part = 1;
		}
	}
	else if(approxMode == ApproximationModeHalf)
	{
		if(part < 0.25 )
		{
			part = 0;
		}
		else if(part > 0.75)
		{
			part = 1;
		}
		else
		{
			part = 0.5;
		}
	}
	return part;
}

-(void)setValue:(float)inValue
{
	value = inValue;
	[self fillStars];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//just call the touchesBegan method
	[self touchesBegan:touches withEvent:event];
}

@end
