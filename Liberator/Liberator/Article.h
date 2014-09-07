//
//  Article.h
//  Liberator
//
//  Created by Oscar Newman on 8/28/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRMustache.h"


@interface Article : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *featureImage;
@property (nonatomic, retain) NSString *excerpt;
@property (nonatomic, retain) NSString *postURL;

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *date;

@property (nonatomic, retain) GRMustacheTemplate *articleTemplate;
@property (nonatomic, retain) NSString *basePath;

- (id)initWithParameters:(NSDictionary*)parameters;

- (BOOL)hasFeatureImage;

- (NSString*)getHTML;


@end
