//
//  AppDelegate.m
//  iFrameTube
//
//  Created by Moe Abry on 13/03/2014.
//  Copyright (c) 2014 Moe Abry. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize videoText;
@synthesize currentID;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [self.window setLevel:NSFloatingWindowLevel];
    
    CGSize fixedSize = self.window.frame.size;
    [self.window setMinSize:fixedSize];
    [self.window setMaxSize:fixedSize];
    
    _defaults = [NSUserDefaults standardUserDefaults];
  
    [self setupFrame:TRUE];
    
    [_win_Pref close];
    
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}

- (void)setupFrame:(BOOL)isOnTop {
    if (isOnTop){
        [self.window setLevel:NSFloatingWindowLevel];
    }
    
    NSDictionary *appDefaults =
    [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"CacheDataAgressively"];
    
    [_defaults registerDefaults:appDefaults];
    
    _Alwaysontop = [_defaults boolForKey:@"Alwaysontop"];
    _btn_Alwaysontop.state = _Alwaysontop;
    _Autoplay = [_defaults boolForKey:@"Autoplay"];
    _btn_Autoplay.state = _Autoplay;
    _Controls = [_defaults boolForKey:@"Controls"];
    _btn_Controls.state = _Controls;
    _HTML = [_defaults boolForKey:@"HTML5"];
    _btn_HTML.state = _HTML;
    _Modest = [_defaults boolForKey:@"Modest"];
    _btn_Modest.state = _Modest;
    _Related = [_defaults boolForKey:@"Related"];
    _btn_Related.state = _Related;
    _Showinfo = [_defaults boolForKey:@"Showinfo"];
    _btn_Showinfo.state = _Showinfo;
}

- (void)embedYouTube: (NSString*)videoID {
    NSString *embedHTML = [NSString stringWithFormat:
                           @"<style> * { margin: 0; padding: 0; border: 0;} </style><div id='ytplayer'></div><script> var tag = document.createElement('script'); tag.src = 'https://www.youtube.com/player_api';  var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('ytplayer', {height: '240', width: '320', videoId: '%@', playerVars: { html5: %d, autoplay: %d, controls: %d, theme: 'dark', color: 'white', modestbranding: %d, showinfo: %d, rel: %d}}); }</script>",videoID,_HTML,_Autoplay,_Controls,_Modest,_Showinfo,_Related];
   
    /*
    @"<style> * { margin: 0; padding: 0; border: 0;} </style><iframe width='320' height='240' src='http://www.youtube.com/embed/%@?html5=1'></iframe>",videoID];
     
    */

    [[self.webView mainFrame] loadHTMLString:embedHTML baseURL:nil];
}

- (IBAction)linkVideoID:(id)sender {
    NSString *myString = videoText.stringValue;
    //If invald
    if ( myString.length == 0 ){
        return;
    }//if 11 characters most be valid right?
    else if ( myString.length == 11 ) {
        [self embedYouTube: videoText.stringValue];
        currentID.stringValue =videoText.stringValue;
    }
    
    //look for video id component
    NSRange range1 = [myString rangeOfString:@"v="];
    NSRange range2 = [myString rangeOfString:@"embed/"];
    
    

    //no valid component found
    if (range1.location == NSNotFound && range2.location == NSNotFound ) {
        //NSLog(@"Component not found");
        videoText.stringValue = @"";
        return;
    }//component was found so lets deal with it
    else if (range1.location != NSNotFound) {
        //NSLog(@"NS was found at %d", range.location);
        //NSArray *components = [myString componentsSeparatedByString:@"v="];
        //NSString *query = [components lastObject];
        myString = [myString substringWithRange: NSMakeRange (range1.location+range1.length, 11)];
        [self embedYouTube: myString];
        currentID.stringValue =myString;
    } else {
        myString = [myString substringWithRange: NSMakeRange (range2.location+range2.length, 11)];
        [self embedYouTube: myString];
        currentID.stringValue =myString;
    }
}

- (IBAction)Pref_btn:(id)sender {
    NSButton* btn = (NSButton*)sender;
    
    if (btn == _btn_Alwaysontop){
        _Alwaysontop = btn.state;
        [_defaults setBool:_HTML forKey:@"Alwaysontop"];
    } else if (btn == _btn_Autoplay){
        _Autoplay = btn.state;
        [_defaults setBool:_Autoplay forKey:@"Autoplay"];
    } else if (btn == _btn_Controls){
        _Controls = btn.state;
        [_defaults setBool:_Controls forKey:@"Controls"];
    } else if (btn == _btn_HTML){
        _HTML = btn.state;
        [_defaults setBool:_HTML forKey:@"HTML5"];
    } else if (btn == _btn_Modest){
        _Modest = btn.state;
        [_defaults setBool:_Modest forKey:@"Modest"];
    } else if (btn == _btn_Related){
        _Related = btn.state;
        [_defaults setBool:_Related forKey:@"Related"];
    } else if (btn == _btn_Showinfo){
        _Showinfo = btn.state;
        [_defaults setBool:_Showinfo forKey:@"Showinfo"];
    } else {
        //Nothing
    }
    
    currentID.stringValue = [NSString stringWithFormat:@"%@ is %@",[btn title],[btn state]? @"Active":@"Inactive"];
    [_defaults synchronize];
}

@end
