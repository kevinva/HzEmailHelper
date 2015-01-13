//
//  EmailHelperV2.h
//  21DigitalPaperiPad
//
//  Created by 何 峙 on 13-8-2.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>


@interface EmailHelperV2 : NSObject<MFMailComposeViewControllerDelegate>

+ (void)showEmailViewFromController:(UIViewController *)controller
                     recipients:(NSArray *)recipients
                        subject:(NSString *)subject
                        content:(NSString *)body;

@end
