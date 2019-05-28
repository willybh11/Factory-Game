
import java.util.*;

EntityObject[][] grid = new EntityObject[15][15];

Button[] buildingButtons = new Button[12];

Dictionary buildings = new Hashtable();

int[] 		inventory = {3,10};
String[] 	itemNames = {"Iron Ore", "Iron Bar"};
String[] 	buildingNames = {"Smelter","Drill","Pipe","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"};
int[][] 	buildingCosts = {
	{0,5},	// smelter
	{0,10},	// drill
	{0,2},	// pipe
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
};

String itemInHands = "Empty";

void setup() {

	size(1450,1000);
	noCursor();
	textAlign(CENTER);

	for (int i = 0; i < 15; i++) {
		for (int j = 0; j < 15; j++) {
			grid[i][j] = new Empty(i,j,"rowcol");
		}
	}

	for (int row = 0; row < 4; row++) {
		for (int col = 0; col < 3; col++) {
			buildingButtons[3*row + col] = new Button(25 + 175*col,35 + 175*row,buildingNames[3*row + col]);
		}
	}

	addObjectToGrid("Iron Ore Patch",1,1,"rowcol");
	addObjectToGrid("Iron Ore Patch",2,1,"rowcol");
	addObjectToGrid("Iron Ore Patch",1,2,"rowcol");
	addObjectToGrid("Iron Ore Patch",2,2,"rowcol");
	addObjectToGrid("Iron Ore Patch",3,1,"rowcol");
}

void draw() {
	background(220);

	drawGrid();
	drawBuildMenu();
	drawInventory();
	drawHands();

	drawMouse();
}