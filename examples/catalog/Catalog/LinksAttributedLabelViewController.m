//
// Copyright 2011-2014 NimbusKit
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "LinksAttributedLabelViewController.h"
#import "NimbusAttributedLabel.h"

//
// What's going on in this file:
//
// This controller demos the use of links in NIAttributedLabels. You'll see how to explicitly add
// links and how to configure autodetection of links.
//
// You will find the following Nimbus features used:
//
// [attributedlabel]
// NIAttributedLabel
//
// This controller requires the following frameworks:
//
// Foundation.framework
// UIKit.framework
// CoreText.framework
// QuartzCore.framework
//

// We declare the protocol conformity here in the source file using a category extension.
// This allows us to conform to protocols privately and to avoid polluting the public namespace.
@interface LinksAttributedLabelViewController() <NIAttributedLabelDelegate>
@end

@implementation LinksAttributedLabelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Links";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // iOS 7-only.
  if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
  self.view.backgroundColor = [UIColor whiteColor];

  NIAttributedLabel* label = [[NIAttributedLabel alloc] initWithFrame:CGRectZero];
  label.numberOfLines = 0;
  label.lineBreakMode = NSLineBreakByWordWrapping;
  label.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  label.frame = CGRectInset(self.view.bounds, 20, 20);
  label.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];

  // When the user taps a link we can change the way the link text looks.
  label.attributesForHighlightedLink = @{NSForegroundColorAttributeName: RGBCOLOR(255, 0, 0)};

  // In order to handle the events generated by the user tapping a link we must implement the
  // delegate.
  label.delegate = self;

  // By default the label will not automatically detect links. Turning this on will cause the label
  // to pass through the text with an NSDataDetector, highlighting any detected URLs.
  label.autoDetectLinks = YES;

  // By default links do not have underlines and this is generally accepted as the standard on iOS.
  // If, however, you do wish to show underlines, you can enable them like so:
  label.linksHaveUnderlines = YES;

  label.text =
  @"A screen on the dash flickers and displays an artist's rendition of the planet."
  // We can use \n characters to separate lines of text.
  @"\nSigned beneath the image: tenach.deviantart.com";

  NSRange linkRange = [label.text rangeOfString:@"an artist's rendition of the planet"];

  // Explicitly adds a link at a given range.
  [label addLink:[NSURL URLWithString:@"http://th04.deviantart.net/fs71/300W/f/2010/145/c/9/Planet_Concept_1_by_Tenach.jpg"]
           range:linkRange];

  [self.view addSubview:label];
}

#pragma mark - NIAttributedLabelDelegate

- (void)attributedLabel:(NIAttributedLabel*)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
  // In a later example we will show how to push a Nimbus web controller onto the navigation stack
  // rather than punt the user out of the application to Safari.
  [[UIApplication sharedApplication] openURL:result.URL];
}

@end
