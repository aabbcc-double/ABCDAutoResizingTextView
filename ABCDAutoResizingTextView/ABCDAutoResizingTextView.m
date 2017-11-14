#import "ABCDAutoResizingTextView.h"

@implementation ABCDAutoResizingTextView
- (CGSize)intrinsicContentSize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invalidateIntrinsicContentSize) name:UITextViewTextDidChangeNotification object:self];
    });
    return self.contentSize;
}

- (void)prepareForInterfaceBuilder {
    [self invalidateIntrinsicContentSize];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
