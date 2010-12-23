#import "RatingView.h"

#define MAX_RATING 5.0

@implementation RatingView

- (void)_commonInit
{
    backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsBackground.png"]];
    backgroundImageView.contentMode = UIViewContentModeLeft;
    [self addSubview:backgroundImageView];
    
    foregroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsForeground.png"]];
    foregroundImageView.contentMode = UIViewContentModeLeft;
    foregroundImageView.clipsToBounds = YES;
    [self addSubview:foregroundImageView];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self _commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        [self _commonInit];
    }
    
    return self;
}

- (void)setRating:(float)newRating
{
	rating = newRating;
	NSLog(@"rating:%f",rating);
	if (rating >= 0) {
		foregroundImageView.frame = CGRectMake(0.0, 0.0, backgroundImageView.frame.size.width * (rating ), foregroundImageView.bounds.size.height);
	}else {
		//[foregroundImageView release];
	}
	
}

- (float)rating
{
    return rating;
}

- (void)dealloc
{
    [backgroundImageView release];
    [foregroundImageView release];
    [super dealloc];
}

@end
