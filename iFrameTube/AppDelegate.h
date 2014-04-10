//
//  AppDelegate.h
//  iFrameTube
//
//  Created by Moe Abry on 13/03/2014.
//  Copyright (c) 2014 Moe Abry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    WebView *_webView;
    NSUserDefaults *_defaults;
    
    BOOL _HTML;
    BOOL _Autoplay;
    BOOL _Controls;
    BOOL _Showinfo;
    BOOL _Modest;
    BOOL _Related;
    BOOL _Alwaysontop;
}

- (void)setupFrame:(BOOL)isOnTop;
- (void)embedYouTube:(NSString*)videoID;

- (IBAction)linkVideoID:(id)sender;
- (IBAction)Pref_btn:(id)sender;

@property (weak) IBOutlet NSTextField *videoText;
@property (weak) IBOutlet NSTextField *currentID;

@property (weak) IBOutlet NSButton *btn_HTML;
@property (weak) IBOutlet NSButton *btn_Autoplay;
@property (weak) IBOutlet NSButton *btn_Controls;
@property (weak) IBOutlet NSButton *btn_Showinfo;
@property (weak) IBOutlet NSButton *btn_Modest;
@property (weak) IBOutlet NSButton *btn_Related;
@property (weak) IBOutlet NSButton *btn_Alwaysontop;


@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet WebView *webView;
@property (unsafe_unretained) IBOutlet NSWindow *win_Pref;

@end
