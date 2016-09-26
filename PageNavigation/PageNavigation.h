//
//  PageNavigation.h
//  FrameworkDemo
//
//  Created by lianxianghui on 16/9/24.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define pushController(ClassName, Params) [PageNavigation pushControllerWithClassName:ClassName params:Params];

@interface PageNavigation : NSObject

+ (void)pushControllerWithClassName:(NSString *)className params:(NSDictionary *)params;

@end
