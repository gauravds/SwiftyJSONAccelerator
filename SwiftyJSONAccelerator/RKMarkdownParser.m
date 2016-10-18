//
//  RKMarkdownParser.m
//  RKMarkdownParser
//
//  Created by Punchh on 10/17/16.
//  Copyright © 2016 Punchh. All rights reserved.
//

#import "RKMarkdownParser.h"

@interface RKMarkdownParser () {
    NSString *strMarkdown;
}
@end

@implementation RKMarkdownParser

- (instancetype)initWithString:(NSString *)string {
    if (self == nil) {
        self = [super init];
    }
    strMarkdown = string;
    [self printStrings];
    return self;
}

- (void)printStrings {
    NSData *data = [strMarkdown dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *dictionaryToModify = [json objectForKey:@"data"];

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i=0; i<dictionaryToModify.count; i++) {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
        tempArray[i] = tempDictionary;
    }

    for (NSString *key in dictionaryToModify) {
        NSArray *components = [key componentsSeparatedByString:@"-"];
        if (components.count > 1) {
            int row = [[components objectAtIndex:0] intValue];
            int column = [[components objectAtIndex:1] intValue];

            NSMutableDictionary *tempDictionary;
            tempDictionary = [tempArray objectAtIndex:row];

            if (column == 0) {
                NSString *someKey = [[dictionaryToModify objectForKey:key] stringByReplacingOccurrencesOfString:@"`" withString:@""];
                [tempDictionary setValue:someKey forKey:@"mdKey"];
            }
            if (column == 2) {
                [tempDictionary setValue:[dictionaryToModify objectForKey:key] forKey:@"mdValue"];
            }
        }
    }

    self.outputDictionary = [[NSMutableDictionary alloc] init];
    for (NSMutableDictionary *dic in tempArray) {
        if (dic.allKeys.count == 2) {
            [self.outputDictionary setObject:[dic objectForKey:@"mdValue"] forKey:[dic objectForKey:@"mdKey"]];
        }
    }
}

- (NSString *)textForKey:(NSString *)key {
    return [[self.outputDictionary objectForKey:key] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
}

@end
