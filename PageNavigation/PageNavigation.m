//
//  PageNavigation.m
//  FrameworkDemo
//
//  Created by lianxianghui on 16/9/24.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "PageNavigation.h"
#import <UIKit/UIKit.h>
#import "Aspects.h"

@implementation PageNavigation

static UINavigationController *currentNavigationController;

+ (void)load {
    [UINavigationController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter
        usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
            currentNavigationController = [aspectInfo instance];
    } error:NULL];
}

+ (void)pushControllerWithClassName:(NSString *)className params:(NSDictionary *)params {
    UIViewController *controller = [self controllerWithClassName:className params:params];
    [currentNavigationController pushViewController:controller animated:YES];
}

+ (UIViewController *)controllerWithClassName:(NSString *)className params:(NSDictionary *)params {
    Class newPageClass = NSClassFromString(className);
    id newPageInstance = [newPageClass alloc];
    newPageInstance = [newPageInstance performSelector:@selector(initWithDic:) withObject:[params mutableCopy]];
    return newPageInstance;
}

@end
