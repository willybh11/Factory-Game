
void deconstruct(String id) {

	if (entityType(id) == "Hopper") {

		int index = indexOf(id,buildingNames);

		for (int i = 0; i < buildingCosts[index].length; i++)
			inventory[i] += buildingCosts[index][i];

	} else if (entityType(id) == "Item")
	inventory[indexOf(id,itemNames)]++;
}

String entityType(String id) {
	switch(id) {
		case "Iron Ore":
		case "Iron Bar":		return "Item";
		case "Iron Ore Patch":	return "Static";
		case "Drill":
		case "Pipe":
		case "Smelter":			return "Hopper";
		default:				return "Universal";
	}
}

// void buy(Button button) {
// 	for (int i = 0; i < buildingCosts[button.index].length; i++)
// 		inventory[i] -= buildingCosts[button.index][i];
// }

void buy(String id) {

	int index = indexOf(id,buildingNames);

	for (int i = 0; i < buildingCosts[index].length; i++)
		inventory[i] -= buildingCosts[index][i];
	
	println("item bought:",id);
}

void addObjectToGrid(String id, int a, int b, String coordType, char outputDirection) {
	grid[a][b] = new Pipe(a,b,coordType,outputDirection);
}

EntityObject makeModel(String id, int x, int y) {
	switch(id) {
		case "Iron Ore":
		return new IronOre(x,y,"xy");
		case "Iron Bar":
		return new IronBar(x,y,"xy");
		case "Smelter":
		return new Smelter(x,y,"xy");
		case "Drill":
		return new Drill(x,y,"xy","Empty");
		case "Pipe":
		return new Pipe(x,y,"xy",'E');
		default: //this will never happen on purpose
		return new Empty(x,y,"xy");
	}
}

void addObjectToGrid(String id, int a, int b, String coordType) {

	switch(id) {
		case "Smelter":
		grid[a][b] = new Smelter(a,b,coordType);
		break;
		case "Iron Ore":
		grid[a][b] = new IronOre(a,b,coordType);
		break;
		case "Iron Bar":
		grid[a][b] = new IronBar(a,b,coordType);
		break;
		case "Empty":
		grid[a][b] = new Empty(a,b,coordType);
		break;
		case "Iron Ore Patch":
		grid[a][b] = new IronOrePatch(a,b,coordType);
		break;
		case "Pipe":
		grid[a][b] = new Pipe(a,b,coordType,'E');
		break;
		case "Drill":
		String oldID = grid[a][b].id;
		grid[a][b] = new Drill(a,b,coordType,oldID);
		break;
	}
}

int indexOf(int n, int[] array) {
	for (int i = 0; i < array.length; i++) {
		if (array[i] == n)
			return i;
	}
	return 123456789;
}

int indexOf(String n, String[] array) {
	for (int i = 0; i < array.length; i++) {
		if (array[i] == n)
			return i;
	}
	return 123456789;
}

void swapItems(int row, int col) {
	String handType = entityType(itemInHands);
	String gridType = entityType(grid[row][col].id);

	if (grid[row][col].id == "Drill" && handType == "Universal") {	// pick up drill
		switch(grid[row][col].outputID) {
			case "Iron Ore":
			addObjectToGrid("Iron Ore Patch",row,col,"rowcol");
			break;
			case "Empty":
			addObjectToGrid("Empty",row,col,"rowcol");
			break;
		}
		itemInHands = "Drill";
		
	} else if (gridType != "Static" || (gridType == "Static" && itemInHands == "Drill") ) {	// swap items
		String temp = itemInHands;
		itemInHands = grid[row][col].id;
		addObjectToGrid(temp,row,col,"rowcol");
		if (gridType == "Static") // placing a drill
			itemInHands = "Empty";
	}

	if (handType == "Item" && gridType == "Hopper") {
		if (!grid[row][col].active) {
			grid[row][col].inputItem(itemInHands);
			itemInHands = "Empty";
		}
	}
}