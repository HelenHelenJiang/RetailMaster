#import <UIKit/UIKit.h>

@interface SIMButton : UIButton

@property (nonatomic) UIColor *primaryColor;

- (instancetype)initWithFrame:(CGRect)frame primaryColor:(UIColor *)primaryColor;

@end
