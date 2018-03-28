//
//  AppDelegate.m
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/25.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import "AppDelegate.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) NSArray *musicArr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _musicArr = [NSArray arrayWithObjects:@"somethinglikethis",@"qulvxing",@"yuanzougaofei",@"bayinhe",@"canxue",@"dizi",@"bongbala",@"chuntian",@"fengweizhu",@"spacecowboy",@"dushen",@"dirtydesire",@"bewithyou",@"inmyheart",@"xiaojibuku", nil];
    
    [self playerWithName:@"xiaojibuku"];
    
    return YES;
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    _player = nil;
    
    [self playerWithName:_musicArr[arc4random() % _musicArr.count]];
}

- (void)playerWithName:(NSString *)musicName {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:@"mp3"];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    _player.delegate = self;
    
    _player.rate = 1.0;
    
    _player.numberOfLoops = 0;
    
    [_player prepareToPlay];
    
    [_player play];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
