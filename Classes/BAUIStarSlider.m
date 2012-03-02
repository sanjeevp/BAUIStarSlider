//
//  BAUIStarSlider.m
//
//  Created by Sanjeev Paskaradevan on 04/05/09.
//
//  Copyright 2009 (c) BeefyApps. www.beefyapps.com
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

#import "BAUIStarSlider.h"
#import "BAFillableStar.h"

@interface BAUIStarSlider (Private)
-(float)getApproximatedPart:(float)part;
-(void)fillStars;
@end

@implementation BAUIStarSlider

@synthesize approxMode, value;
@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;
@synthesize backgroundColor = _backgroundColor;
@synthesize lineWidth = _lineWidth;


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

- (void)setFillColor:(UIColor *)color {
  [_fillColor release];
  _fillColor = nil;
  
  _fillColor = [color retain];
  
  for (UIView *v in self.subviews) {
    if ([v isKindOfClass:[BAFillableStar class] ]) {
      BAFillableStar *star = (BAFillableStar *)v;
      
      [star setFillColor:_fillColor];
      
      [star setNeedsDisplay];

    }
  }
}

- (void)setBackgroundColor:(UIColor *)color {
  [_backgroundColor release];
  _backgroundColor = nil;
  
  _backgroundColor = [color retain];
  
  for (UIView *v in self.subviews) {
    if ([v isKindOfClass:[BAFillableStar class] ]) {
      BAFillableStar *star = (BAFillableStar *)v;
      
      [star setBackgroundColor:_backgroundColor];
      
      [star setNeedsDisplay];

    }
  }
}

- (void)setStrokeColor:(UIColor *)color {
  [_strokeColor release];
  _strokeColor = nil;
  
  _strokeColor = [color retain];
  
  for (UIView *v in self.subviews) {
    if ([v isKindOfClass:[BAFillableStar class] ]) {
      BAFillableStar *star = (BAFillableStar *)v;
      
      [star setStrokeColor:_strokeColor];
      
      [star setNeedsDisplay];
    }
  }
}

- (void)lineWidth:(CGFloat)widht {
  _lineWidth = widht;
  
  for (UIView *v in self.subviews) {
    if ([v isKindOfClass:[BAFillableStar class] ]) {
      BAFillableStar *star = (BAFillableStar *)v;
      
      [star setLineWidth:_lineWidth];
      
      [star setNeedsDisplay];
    }
  }
}

- (void)dealloc {
	[_fillColor release];
  [_strokeColor release];
  [_backgroundColor release];
  [starArray release];
  [super dealloc];
}

+ (BAUIStarSlider *)sliderWithFrame:(CGRect)frame stars:(NSUInteger)stars {
  BAUIStarSlider *slider = [[BAUIStarSlider alloc] initWithFrame:frame andStars: stars];
  
  return [slider autorelease];
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
