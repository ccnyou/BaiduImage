//
//  SDWebImageDataSource.h
//  BaiduImage
//
//  Created by ccnyou on 14-5-11.
//  Copyright (c) 2014年 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTPhotoBrowserDataSource.h"

@interface SDWebImageDataSource : NSObject<KTPhotoBrowserDataSource>

@property (nonatomic, strong) NSMutableArray* images;

- (void)again;

@end
