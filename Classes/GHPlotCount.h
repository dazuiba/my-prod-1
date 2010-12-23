@interface GHPlotCount : NSObject {
	NSString *created_at;
	int used_count;
	int empty_count;
}

@property(nonatomic,retain)NSString *created_at;
@property(nonatomic)int used_count;
@property(nonatomic)int empty_count;

- (float)percent;
@end