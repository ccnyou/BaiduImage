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


- (id)init {
    self = [super init];
    if (self) {
        _isImagesLoaded = NO;
        _images = [[NSMutableArray alloc] init];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"gallery" ofType:@"json"];
        NSLog(@"%s line:%d %@", __FUNCTION__, __LINE__, path);
        NSData* data = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%s line:%d dict = %@", __FUNCTION__, __LINE__, json);
        _totalImages = [json objectForKey:@"data"];
        
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
    NSDictionary *object = [_images objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    [photoView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (void)thumbImageAtIndex:(NSInteger)index thumbView:(KTThumbView *)thumbView {
    
    NSDictionary *object = [_images objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    [thumbView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
    
}

- (void)append
{
    static int cnt = 0;
    for (int i = 0; i < 50; i++) {
        [_images addObject:_totalImages[i+cnt]];
    }
    
    cnt += 50;
}
@end
