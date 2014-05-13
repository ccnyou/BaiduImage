//
//  SDWebImageDataSource.m
//  BaiduImage
//
//  Created by ccnyou on 14-5-11.
//  Copyright (c) 2014年 ccnyou. All rights reserved.
//

#import "SDWebImageDataSource.h"
#import "KTPhotoView+SDWebImage.h"
#import "KTThumbView+SDWebImage.h"

@interface SDWebImageDataSource ()

@property (nonatomic, assign) BOOL isImagesLoaded;
@property (nonatomic, strong) NSArray* totalImages;

@end

@implementation SDWebImageDataSource

#define FULL_SIZE_INDEX 0
#define THUMBNAIL_INDEX 1
#define SERVER_URL @"http://192.168.1.140:8080/ImageServer"


- (id)init {
    self = [super init];
    if (self) {
        _isImagesLoaded = NO;
        _images = [[NSMutableArray alloc] init];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"json"];
        //NSLog(@"%s line:%d %@", __FUNCTION__, __LINE__, path);
        NSData* data = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%s line:%d dict = %@", __FUNCTION__, __LINE__, json);
        _totalImages = [json objectForKey:@"file_names"];
        
        [self append];
    }
    return self;
}

#pragma mark -
#pragma mark KTPhotoBrowserDataSource

- (NSInteger)numberOfPhotos {
    NSInteger count = [_images count];
    return count;
}

- (void)imageAtIndex:(NSInteger)index photoView:(KTPhotoView *)photoView {
    NSString *fileName = [_images objectAtIndex:index];
    NSString* urlString = [[NSString alloc] initWithFormat:@"%@/images/%@", SERVER_URL, fileName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [photoView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (void)thumbImageAtIndex:(NSInteger)index thumbView:(KTThumbView *)thumbView {
    NSString *fileName = [_images objectAtIndex:index];
    NSString* urlString = [[NSString alloc] initWithFormat:@"%@/images/thumb/%@", SERVER_URL, fileName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [thumbView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
    
}

- (void)append
{
    static int cnt = 0;
    for (int i = 0; i < 50; i++) {
        int index = (i + cnt) % _totalImages.count;
        [_images addObject:_totalImages[index]];
    }
    
    cnt += 50;
}
@end
