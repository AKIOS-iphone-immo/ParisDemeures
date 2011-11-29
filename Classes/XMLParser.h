//
//  XMLParser.h
//  ParisDemeures
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Annonce.h"
#import "ParisDemeuresAppDelegate.h"

@class ParisDemeuresAppDelegate, Annonce;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Annonce *uneAnnonce;
	ParisDemeuresAppDelegate *appDelegate;
}

- (XMLParser *) initXMLParser;

@end
