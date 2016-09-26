//
//  PageNavigationInterceptor.h
//  FrameworkDemo
//
//  Created by lianxianghui on 16/9/24.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageNavigationInterceptor : NSObject

- (void)relaceOriginalPage:(NSString *)originalPageClassName withNewPage:(NSString *)newPageClassName;
- (void)relaceOriginalPage:(NSString *)originalPageClassName withNewPage:(NSString *)newPageClassName newDic:(NSDictionary *)newDic;
- (void)remove;
@end
