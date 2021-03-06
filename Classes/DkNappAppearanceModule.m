/**
 * Module developed by Napp ApS
 * www.napp.dk
 * Mads Møller
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "DkNappAppearanceModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation DkNappAppearanceModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"ace06789-ffad-4f30-80fc-9e5cc8835ffe";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"dk.napp.appearance";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs


-(NSMutableDictionary *)parseParams:(NSDictionary *)dict
{
    NSMutableDictionary *output = [NSMutableDictionary dictionary];
    
    if ([dict objectForKey:@"color"] != nil) {
        [output setObject:[[TiUtils colorValue:@"color" properties:dict] _color] forKey:UITextAttributeTextColor];
    }
    
    if ([dict objectForKey:@"shadowColor"] != nil) {
        [output setObject:[[TiUtils colorValue:@"shadowColor" properties:dict] _color] forKey:UITextAttributeTextShadowColor];
    }
    
    if ([dict objectForKey:@"shadowOffset"] != nil) {
        CGPoint p = [TiUtils pointValue:@"shadowOffset" properties:dict];
        CGSize size = {p.x,p.y};
        [output setObject:[NSValue valueWithCGSize:size] forKey:UITextAttributeTextShadowOffset];
    }
    
    if ([dict objectForKey:@"font"] != nil) {
        NSDictionary * fontValue = [dict objectForKey:@"font"];
        UIFont *font =  [[TiUtils fontValue:fontValue] font];
        [output setObject:font forKey:UITextAttributeFont];
    }
    return output;
}
//http://stackoverflow.com/questions/9424112/what-properties-can-i-set-via-an-uiappearance-proxy
-(void)setGlobalStyling:(id)args
{
    ENSURE_UI_THREAD(setGlobalStyling,args);
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    if(args != nil){

        NSDictionary *navBar = [args objectForKey:@"navBar"];
        NSDictionary *navBarTitle = [args objectForKey:@"navBarTitle"];
        NSDictionary *barButton = [args objectForKey:@"barButton"];
        NSDictionary *backButton = [args objectForKey:@"backButton"];
        NSDictionary *tabBar = [args objectForKey:@"tabBar"];
        NSDictionary *slider = [args objectForKey:@"slider"];
        NSDictionary *progressBar = [args objectForKey:@"progressBar"];
        NSDictionary *pageControl = [args objectForKey:@"pageControl"];
        NSDictionary *switchDict = [args objectForKey:@"switchBar"];
        NSDictionary *toolbar = [args objectForKey:@"toolbar"];
        NSDictionary *searchBar = [args objectForKey:@"searchBar"];
        NSDictionary *activityIndicator = [args objectForKey:@"activityIndicator"];
        NSDictionary *segmentedControl = [args objectForKey:@"segmentedControl"];
        
        
        //nav bar Title text for UINavigationBar
        if(navBarTitle != nil){
            NSMutableDictionary *attributes = [self parseParams:navBarTitle];
            if([[attributes allKeys] count] > 0){
                [[UINavigationBar appearance] setTitleTextAttributes:attributes];
            }
            [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:[TiUtils floatValue:@"verticalPositionOffset" properties:navBarTitle] forBarMetrics:UIBarMetricsDefault];

        }
        
        if(navBar != nil){
            [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:[TiUtils stringValue:@"shadowImage" properties:navBar]]];
            UIImage *navbuttonimg = [[UIImage imageNamed:[TiUtils stringValue:@"backgroundImage" properties:navBar]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
            // Set the background image for *all* UINavigationBars
            [[UINavigationBar appearance] setBackgroundImage:navbuttonimg forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearance] setBackgroundImage:navbuttonimg forBarMetrics:UIBarMetricsLandscapePhone];

            UIImage *backbuttonimg = [[UIImage imageNamed:[TiUtils stringValue:@"buttonBackgroundImage" properties:navBar]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
            [[UIBarButtonItem appearance] setBackgroundImage:backbuttonimg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [[UIBarButtonItem appearance] setBackgroundImage:backbuttonimg forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
        }
        
        if(backButton !=nil){
            UIImage *backbuttonimg = [[UIImage imageNamed:[TiUtils stringValue:@"backgroundImage" properties:backButton]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
            [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backbuttonimg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backbuttonimg forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
        }
        
        if(barButton != nil){
            NSMutableDictionary *barAttributes = [self parseParams:barButton];
            if([[barAttributes allKeys] count] > 0){
                [[UIBarButtonItem appearance] setTitleTextAttributes:barAttributes forState:UIControlStateNormal];
            }
            [[UIBarButtonItem appearance] setTintColor:[[TiUtils colorValue:@"tintColor" properties:barButton] _color]];
        }
        
        if(tabBar != nil){
            // Customizing the tab bar
            UIImage *tabBackground = [[UIImage imageNamed:[TiUtils stringValue:@"backgroundImage" properties:tabBar]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [[UITabBar appearance] setBackgroundImage:tabBackground];
            [[UITabBar appearance] setSelectionIndicatorImage: [UIImage imageNamed:[TiUtils stringValue:@"backgroundSelectedImage" properties:tabBar]]];
        } 
        
        if(slider != nil){
            // Customizing the UISlider
            UIImage *leftTrackImage = [[UIImage imageNamed:[TiUtils stringValue:@"leftTrackImage" properties:slider]]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            UIImage *rightTrackImage = [[UIImage imageNamed:[TiUtils stringValue:@"rightTrackImage" properties:slider]]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            UIImage *thumbImage = [UIImage imageNamed:[TiUtils stringValue:@"thumbImage" properties:slider]];
            
            [[UISlider appearance] setMaximumTrackImage:rightTrackImage forState:UIControlStateNormal];
            [[UISlider appearance] setMinimumTrackImage:leftTrackImage forState:UIControlStateNormal];
            [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
            [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
        }
        
        if(progressBar != nil){
            // Customize the progress view
            [[UIProgressView appearance] setProgressTintColor:[[TiUtils colorValue:@"progressTintColor" properties:progressBar] _color]];
            [[UIProgressView appearance] setTrackTintColor:[[TiUtils colorValue:@"trackTintColor" properties:progressBar] _color]];
            
            [[UIProgressView appearance] setProgressImage:[[UIImage imageNamed:[TiUtils stringValue:@"progressImage" properties:progressBar]]
                                                           resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)]];
            [[UIProgressView appearance] setTrackImage:[[UIImage imageNamed:[TiUtils stringValue:@"trackImage" properties:progressBar]]
                                                           resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)]];
        }
        
        if(pageControl != nil){
            // Customize the page control
            [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[[TiUtils colorValue:@"currentPageIndicatorTintColor" properties:pageControl] _color]];
            [[UIPageControl appearance] setPageIndicatorTintColor:[[TiUtils colorValue:@"pageIndicatorTintColor" properties:pageControl] _color]];
        }
        
        if(switchDict !=nil){
            // Customizing the switch control
            [[UISwitch appearance] setOnTintColor:[[TiUtils colorValue:@"onTintColor" properties:switchDict] _color]];
            [[UISwitch appearance] setTintColor:[[TiUtils colorValue:@"tintColor" properties:switchDict] _color]];
            [[UISwitch appearance] setThumbTintColor:[[TiUtils colorValue:@"thumbTintColor" properties:switchDict] _color]];
            
            // Customizing the switch text
            [[UISwitch appearance] setOnImage:[UIImage imageNamed:[TiUtils stringValue:@"onImage" properties:switchDict]]];
            [[UISwitch appearance] setOffImage:[UIImage imageNamed:[TiUtils stringValue:@"offImage" properties:switchDict]]];
        }
        
        if(toolbar !=nil){
            //toolbar
            [[UIToolbar appearance] setTintColor:[[TiUtils colorValue:@"tintColor" properties:toolbar] _color]];
            [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"backgroundImage" properties:toolbar]]
                                    forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        }
        
        
        if(searchBar !=nil){
            
            [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"searchFieldBackgroundImage" properties:searchBar]] forState:UIControlStateNormal];
            
            [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"backgroundImage" properties:searchBar]]];
            
            //cancel button
            [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:[TiUtils stringValue:@"cancelTitle" properties:searchBar] forState:UIControlStateNormal];
            NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
            if ([searchBar objectForKey:@"cancelTitleColor"] != nil) {
                [attributes setObject:[[TiUtils colorValue:@"cancelTitleColor" properties:searchBar] _color] forKey:UITextAttributeTextColor];
            }
            if ([searchBar objectForKey:@"cancelFont"] != nil) {
                NSDictionary * fontValue = [searchBar objectForKey:@"font"];
                UIFont *font =  [[TiUtils fontValue:fontValue] font];
                [attributes setObject:font forKey:UITextAttributeFont];
            }
            if ([searchBar objectForKey:@"cancelShadowColor"] != nil) {
                [attributes setObject:[[TiUtils colorValue:@"cancelShadowColor" properties:searchBar] _color] forKey:UITextAttributeTextShadowColor];
            }
            if ([searchBar objectForKey:@"cancelShadowOffset"] != nil) {
                CGPoint p = [TiUtils pointValue:@"cancelShadowOffset" properties:searchBar];
                CGSize size = {p.x,p.y};
                [attributes setObject:[NSValue valueWithCGSize:size] forKey:UITextAttributeTextShadowOffset];
            }
            if([[attributes allKeys] count] > 0){ //apply to cancel button
                [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:attributes forState:UIControlStateNormal];
                [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:attributes forState:UIControlStateDisabled];
            }
            
            //scopebar
            [[UISearchBar appearance] setScopeBarBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"scopeBarBackgroundImage" properties:searchBar]]];
            [[UISearchBar appearance] setScopeBarButtonBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"scopeBarButtonBackgroundImageUnselected" properties:searchBar]] forState:UIControlStateNormal];
            [[UISearchBar appearance] setScopeBarButtonBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"scopeBarButtonBackgroundImageSelected" properties:searchBar]] forState:UIControlStateSelected];
            
            [[UISearchBar appearance] setScopeBarButtonDividerImage:[UIImage imageNamed:[TiUtils stringValue:@"scopeBarDividerImageUnselectedUnselected" properties:searchBar]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
            [[UISearchBar appearance] setScopeBarButtonDividerImage:[UIImage imageNamed:[TiUtils stringValue:@"scopeBarDividerImageSelectedUnselected" properties:searchBar]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal];
            [[UISearchBar appearance] setScopeBarButtonDividerImage:[UIImage imageNamed:[TiUtils stringValue:@"scopeBarDividerImageUnselectedSelected" properties:searchBar]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected];
            
            
            NSMutableDictionary *scopeBarAttributes = [self parseParams:searchBar];
            if([[scopeBarAttributes allKeys] count] > 0){
                [[UISearchBar appearance] setScopeBarButtonTitleTextAttributes:scopeBarAttributes forState:UIControlStateNormal];
            }
            
        }
        
        if(activityIndicator != nil){
            [[UIActivityIndicatorView appearance] setColor:[[TiUtils colorValue:@"color" properties:activityIndicator] _color]];
        }
        
        if(segmentedControl != nil){
            [[UISegmentedControl appearance] setTintColor:[[TiUtils colorValue:@"tintColor" properties:segmentedControl] _color]];
            
            NSMutableDictionary *segmentedAttributes = [self parseParams:segmentedControl];
            if([[segmentedAttributes allKeys] count] > 0){
                [[UISegmentedControl appearance] setTitleTextAttributes:segmentedAttributes forState:UIControlStateNormal];
            }
            
            [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"backgroundImageUnselected" properties:segmentedControl]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:[TiUtils stringValue:@"backgroundImageSelected" properties:segmentedControl]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
            
            [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:[TiUtils stringValue:@"dividerImageUnselectedUnselected" properties:segmentedControl]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:[TiUtils stringValue:@"dividerImageSelectedUnselected" properties:segmentedControl]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:[TiUtils stringValue:@"dividerImageUnselectedSelected" properties:segmentedControl]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        }
        
    }
}


@end
