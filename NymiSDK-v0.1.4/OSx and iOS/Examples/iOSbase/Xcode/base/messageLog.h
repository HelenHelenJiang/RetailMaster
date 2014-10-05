@interface MessageLog: UILabel{
	NSMutableArray* messages;
}

- (void)add: (NSString*)message;

@end
