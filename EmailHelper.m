//
//  EmailHelper.m
//  Biando
//
//  Created by biando on 13-1-7.
//  Copyright (c) 2013年 biando. All rights reserved.
//

#import "EmailHelper.h"
#import "Constants.h"

static EmailHelper *instance = nil;

@implementation EmailHelper

#pragma mark - Public Methods

- (void)showMailComposerFromController:(UIViewController *)controller{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if(mailClass != nil){
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"Biando 啊？"];
        
        NSString *emailBody =@"你看不懂看不懂看不懂！\nhttp://bian.do/";
        [picker setMessageBody:emailBody isHTML:NO];
        
        [controller presentViewController:picker animated:YES completion:nil];
        [picker release];
    
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to send email"
                                                            message:@"This device is not yet configured for sending emails."
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

+ (id)sharedInstance{
    @synchronized(self){
        if(instance == nil){
            instance = [[self alloc] init];
        }
        return instance;
    }
}


#pragma mark - MFMailComposeViewControllerDelegate delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    NSString *resultTitle = @"";
    
    switch(result){
        case MFMailComposeResultCancelled:
            //resultTitle = @"Email Cancelled";
            break;
            
        case MFMailComposeResultSaved:
            //resultTitle = @"Email Saved";
            break;
            
        case MFMailComposeResultSent:
            resultTitle = @"发送成功";
            break;
        
        case MFMailComposeResultFailed:
            //resultTitle = @"Email Failed";
            break;
        
        default:
            //resultTitle = @"Email Not Sent";
            break;
    }

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:resultTitle, kKeyMailComposerResultMessage, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRequestCancelMailComposerView object:self userInfo:dict];
}


@end
