#import "messageLog.h"

@implementation MessageLog

- (id)initWithCoder: (NSCoder*)decoder{
	self=[super initWithCoder: decoder];
	if(self){
		self.numberOfLines=20;
		messages=[[NSMutableArray alloc] init];
		for(unsigned i=0; i<self.numberOfLines-1; ++i) [messages addObject: @" "];
	}
	return self;
}

- (void)add: (NSString*)message{
	@synchronized(self){
		NSLog(@"%@", message);
		[messages insertObject: message atIndex: 0];
		[messages removeLastObject];
		NSMutableString* text=[[NSMutableString alloc] init];
		for(NSString* message in messages){
			[text appendString: @"-"];
			[text appendString: message];
			[text appendString: @"\n"];
		}
		dispatch_async(dispatch_get_main_queue(), ^{ self.text=text; });
	}
}

@end
