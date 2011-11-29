//
//  RechercheSauveesController.m
//  ParisDemeures
//
//  Created by Christophe Bergé on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RechercheSauveesController.h"


@implementation RechercheSauveesController

@synthesize recherchesSauvees;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	recherchesSauvees = [[NSMutableArray alloc] init];
	NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSMutableDictionary *recherche;
	
    int i = 0;
	for (i = 0; i < 5; i++) {
		[recherchesSauvees addObject:@""];
		
		recherche = [NSMutableDictionary dictionaryWithContentsOfFile:
					 [directory stringByAppendingPathComponent:
					  [@"" stringByAppendingFormat:@"%d.plist",i+1]]];
		
		//recherche2 = [NSMutableDictionary dictionaryWithDictionary:recherche1];
		
		if (recherche != nil) {
			[recherchesSauvees replaceObjectAtIndex:i withObject:recherche];
		}
		
	}
	//NSLog(@"recherchesSauvees: %@",recherchesSauvees);
	appDelegate = (ParisDemeuresAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheListeAnnoncesReady:) name:@"afficheListeAnnoncesReady" object: nil];
}

- (void) afficheListeAnnoncesReady:(NSNotification *)notify {
	/*[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheListeAnnonces" object: appDelegate.accueilView.myTableViewController.tableauAnnonces];*/
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [recherchesSauvees count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	//NSLog(@"%@",recherchesSauvees);
	NSMutableDictionary *rechercheRecente = [recherchesSauvees objectAtIndex:indexPath.row];
	//NSLog(@"dict: %@, row: %d",rechercheRecente, indexPath.row);
	NSString *ville1 = [rechercheRecente valueForKey:@"ville1"];
	NSString *code1 = [rechercheRecente valueForKey:@"cp1"];
	NSString *budMax = [rechercheRecente valueForKey:@"prix_maxi"];
	
	NSString *texte = @"";
	
	if (budMax != nil) {
		texte = [texte stringByAppendingFormat:@"%@(%@) - %@€ max", ville1, code1, budMax];
	}
	else {
		texte = [texte stringByAppendingFormat:@"%@(%@)", ville1, code1];
	}

    cell.textLabel.text = texte;
	
	NSString *typeBien = [rechercheRecente valueForKey:@"types"];
	NSString *surfMax = [rechercheRecente valueForKey:@"surface_maxi"];
	NSString *nbPieces = [rechercheRecente valueForKey:@"nb_pieces_maxi"];
	NSString *subTitle = @"";
	
	if (typeBien != nil) {
		subTitle = [subTitle stringByAppendingString:typeBien];
	}
	
	if (surfMax != nil) {
		subTitle = [subTitle stringByAppendingFormat:@" %@m² max", surfMax];
	}
	
	if (nbPieces != nil) {
		subTitle = [subTitle stringByAppendingFormat:@" %@ pieces max", nbPieces];
	}
	
	cell.detailTextLabel.text = subTitle;
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableDictionary *criteresSauves = [recherchesSauvees objectAtIndex:indexPath.row];
	
	//NSLog(@"criteres: %@",criteresSauves);
	//ENVOYER LA REQUETE ET AFFICHER LES RESULTATS
	
	//[appDelegate.accueilView.myTableViewController.tableauAnnonces removeAllObjects];
	
	BOOL requeteEnvoyee;
	requeteEnvoyee = [self sendRequest:criteresSauves];
	
	if (requeteEnvoyee == YES) {
		NSLog(@"requeteEnvoyee: %d",requeteEnvoyee);
		AfficheListeAnnoncesController2 *afficheListeAnnoncesController =
		[[AfficheListeAnnoncesController2 alloc] init];
		afficheListeAnnoncesController.title = @"Annonces";
		[self.navigationController pushViewController:afficheListeAnnoncesController animated:YES];
		[afficheListeAnnoncesController release];
	}
	else {
		NSLog(@"NO requeteEnvoyee: %d",requeteEnvoyee);
	}

}

-(BOOL) sendRequest:(NSMutableDictionary *)criteres {
	Utility *util = [[Utility alloc] init];
	[util httpRequestForSmallAdds:criteres];
	[util release];
	//if ([appDelegate.accueilView.myTableViewController.tableauAnnonces count] > 0) {
		return YES;
	/*}
	else {
		return NO;
	}*/
	
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[recherchesSauvees release];
    [super dealloc];
}


@end

