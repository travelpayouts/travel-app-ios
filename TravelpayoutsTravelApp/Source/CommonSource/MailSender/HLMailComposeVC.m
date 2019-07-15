// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

#import "HLMailComposeVC.h"

@implementation HLMailComposeVC

- (void) viewWillAppear:(BOOL)animated
{
    [self.parentViewController resignFirstResponder];
    [super viewWillAppear:animated];
	
	[self.view setNeedsLayout];
	[self.view layoutIfNeeded];
}

@end
