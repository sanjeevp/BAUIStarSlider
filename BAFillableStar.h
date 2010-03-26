//
//  BAFillableStar.h
//  BAUICustomSlider
//
//  Created by Sanjeev Paskaradevan on 15/04/09.
//  Copyright 2009 BeefyApps. All rights reserved.
//  www.beefyapps.com

#import <UIKit/UIKit.h>


@interface BAFillableStar : UIView {
	
	CGPoint points[10];
	UIColor * fillColor;
	UIColor * backgroundColor;
	UIColor * strokeColor;
	
	CGFloat lineWidth;

	float fillPercent;
}

@property (nonatomic, retain) UIColor * fillColor, * backgroundColor, * strokeColor;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) float fillPercent;

@end
