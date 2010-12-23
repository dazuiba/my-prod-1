//
//  SiteTableCell.m
//  handhz
//
//  Created by sam on 10-12-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SiteTableCell.h"


@implementation SiteTableCell

@synthesize site;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier site:(GHSite *)theSite {
	[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	self.textLabel.font = [UIFont systemFontOfSize:16.0f];
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.opaque = YES;
	self.site = theSite;
	return self;
}


//- (void)setBackgroundColor:(UIColor *)backgroundColor{
//	[super setBackgroundColor:backgroundColor];
//	
//	//iconView.backgroundColor = backgroundColor;
//	//publisherLabel.backgroundColor = backgroundColor;
//	numberView.backgroundColor = backgroundColor;
//	nameLabel.backgroundColor = backgroundColor;
//	ratingView.backgroundColor = backgroundColor;
//	numRatingsLabel.backgroundColor = backgroundColor;
//	updateLabel.backgroundColor = backgroundColor;
//}

- (void)setSite:(GHSite *)newSite{ 
	numberView.text = [NSString stringWithFormat:@"%@",newSite.number];
	nameLabel.text = newSite.name;
	if (newSite.plot_count) {
		UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		CGRect progframe = progressView.frame;
		progframe.size.width = 93;
		progressView.frame = progframe;
		progressView.progress   = newSite.plot_count.percent;
		[ratingView addSubview:progressView];
		[progressView release];
	
		NSMutableAttributedString *string = [NSMutableAttributedString attributedStringWithString:@"还有"];
		NSMutableAttributedString* count = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%d",newSite.plot_count.used_count]];
		[count setTextColor:[UIColor orangeColor]];
		[count setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
		NSMutableAttributedString *append = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"辆, %@前更新",newSite.plot_count.created_at]];
		[string appendAttributedString:count];
		[string appendAttributedString:append];
		
		
		NSLog(@"ratingView.progress: %f",newSite.plot_count.percent);
		numRatingsLabel.attributedText = string;
	}else { 
		numRatingsLabel.text = @"未收录该站点的数据";
	}

} 

- (void)dealloc{
	[numberView release];
	[nameLabel release];
	[ratingView release];
	[numRatingsLabel release];
	[site release];
	[super dealloc];
}