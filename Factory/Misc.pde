
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

void addObjectToGrid(String id, int a, int b, String coordType, char outputDirection) {
	grid[a][b] = new Pipe(a,b,coordType,outputDirection);
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