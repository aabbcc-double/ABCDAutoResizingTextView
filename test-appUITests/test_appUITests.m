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

#import <XCTest/XCTest.h>

#define ELEMENT_FRAME_ACCURACY 5
#define DEFAULT_TEXTVIEW_PADDING 16

@interface test_appUITests : XCTestCase

@end

@implementation test_appUITests

- (void)setUp {
    [super setUp];
    

    self.continueAfterFailure = NO;
    
    [[[XCUIApplication alloc] init] launch];
    
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testProsAutoresizing {
    XCUIElement *textView = [[XCUIApplication alloc] init].textViews[@"pros_text_view"];
    CGFloat height = CGRectGetHeight(textView.frame) - DEFAULT_TEXTVIEW_PADDING;
    [textView tap];
    
    [textView typeText:@"Hello world"];
    XCTAssertEqualWithAccuracy(CGRectGetHeight(textView.frame) - DEFAULT_TEXTVIEW_PADDING, height, ELEMENT_FRAME_ACCURACY);
    
    [textView typeText:@"\n\n"];
    XCTAssertEqualWithAccuracy(CGRectGetHeight(textView.frame) - DEFAULT_TEXTVIEW_PADDING, height * 3, ELEMENT_FRAME_ACCURACY);
    
    [textView typeText:@"\n\n\n\n\nHello world"];
    XCTAssertEqualWithAccuracy(CGRectGetHeight(textView.frame) - DEFAULT_TEXTVIEW_PADDING, height * 8, ELEMENT_FRAME_ACCURACY);
}

- (void)testProsAutoscrolling {
    XCUIElement *textView = [[XCUIApplication alloc] init].textViews[@"pros_text_view"];
    CGFloat top = CGRectGetMinY(textView.frame);
    
    [textView tap];
    [textView typeText:@"Hello world"];
    
    XCTAssertEqualWithAccuracy(CGRectGetMinY(textView.frame), top, ELEMENT_FRAME_ACCURACY);
    
    [textView typeText:@"\nHello again"];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(textView.frame), top, ELEMENT_FRAME_ACCURACY);

    [textView typeText:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"];
    XCTAssertTrue(CGRectGetMinY(textView.frame) < top);
}

@end
 

#undef ELEMENT_FRAME_ACCURACY
#undef DEFAULT_TEXTVIEW_PADDING
