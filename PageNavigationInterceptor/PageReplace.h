//
//  PageReplace.h
//  FrameworkDemo
//
//  Created by lianxianghui on 16/9/24.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageReplace : NSObject

- (void)addPageReplaceWithOrignalClassName:(NSString *)originalClassName newPageClassName:(NSString *)newPageClassName;
- (void)removeWithOrignalClassName:(NSString *)originalClassName;
- (void)removeAll;
@end
