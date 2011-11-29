//
//  RechercheSauveesController.h
//  ParisDemeures
//
//  Created by Christophe Bergé on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "AfficheListeAnnoncesController2.h"
#import "ParisDemeuresAppDelegate.h"

@class ParisDemeuresAppDelegate;

@interface RechercheSauveesController : UITableViewController {
	NSMutableArray *recherchesSauvees;
	ParisDemeuresAppDelegate *appDelegate;

}

@property (nonatomic,retain) NSMutableArray *recherchesSauvees;

-(BOOL) sendRequest:(NSDictionary *)criteres;

@end
