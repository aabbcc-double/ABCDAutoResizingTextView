/*
 MIT License
 
 Copyright (c) 2017 Shakhzod Ikromov (GRiMe2D) <aabbcc.double@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

#import "ABCDAutoResizingTextView.h"

@implementation ABCDAutoResizingTextView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _minHeight = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    /* no - op */
}

- (void)textDidChange {
    [self invalidateIntrinsicContentSize];
    self.contentOffset = CGPointZero;
    
    if (self.automaticallyScrollSuperview) {
        UIScrollView *scrollView;
        if (![self.superview isKindOfClass:[UIScrollView class]]) {
            return;
        }
        scrollView = (UIScrollView *)self.superview;
        
        CGRect rect = [self caretRectForPosition:self.selectedTextRange.start];
        rect = [scrollView convertRect:rect fromView:self];
        [scrollView scrollRectToVisible:rect animated:YES];
    }
}

- (CGSize)intrinsicContentSize {
    CGSize size = self.contentSize;
    size.width += self.contentInset.left + self.contentInset.right;
    size.height += self.contentInset.top + self.contentInset.bottom;
    
    
    CGFloat minHeight = self.minHeight ?: self.font.lineHeight;
    size.height = MAX(minHeight + self.textContainerInset.top + self.textContainerInset.bottom, size.height);

    return size;
}

- (void)prepareForInterfaceBuilder {
    [self invalidateIntrinsicContentSize];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
