
abstract class EntityObject implements BasicInterface {

	int row;
	int col;
	int x;
	int y;
	String id;
	boolean active;

	void initCoords(int a, int b, String coordType) {
		switch(coordType) {
			case "xy":
			x = a;
			y = b;
			break;
			case "rowcol":
			row = a;
			col = b;
			x = col*50 + 25;
			y = row*50 + 25;
			break;
		}
	}
}

abstract class Hopper extends EntityObject {
	
	boolean full = false;
	char outputDirection = 'E';
	ArrayList<String> storage = new ArrayList<String>();
	int startTime;
	int timeLimit;
	int capacity;
	boolean active;

	char getOutputDirection() {
		return outputDirection;
	}

	void rotateMe(char direction) {
		outputDirection = direction;
	}
}

interface BasicInterface {

	void drawMe();
	boolean inputItem(String input);
}

interface HopperInterface {

	void update();
	char getOutputDirection();
}

class IronOrePatch extends EntityObject implements BasicInterface {

	color bg = color(120,150,170);

	public IronOrePatch(int a, int b, String coordType) {

		initCoords(a,b,coordType);

		id = "Iron Ore Patch";
	}

	void drawMe() {
		fill(bg);
		noStroke();
		rect(x - 25,y - 25,50,50);
	}

	boolean inputItem(String input) {
		return false;
	}
}

class Empty extends EntityObject implements BasicInterface {

	public Empty(int a, int b, String coordType) {

		initCoords(a,b,coordType);
		id = "Empty";
	}

	void drawMe() {
		fill(255);
		stroke(150);
		strokeWeight(1);

		rect(x - 25,y - 25,50,50);
	}

	boolean inputItem(String input) {
		addObjectToGrid(input,row,col,"rowcol"); // should destroy itself
		return true;
	}
}

class IronOre extends EntityObject implements BasicInterface {

	public IronOre(int a, int b, String coordType) {

		initCoords(a,b,coordType);
		id = "Iron Ore";
	}

	void drawMe() {
		fill(120,150,170);
		noStroke();
		ellipse(x,y,26,26);
	}

	boolean inputItem(String input) {
		return false;
	}
}

class IronBar extends EntityObject implements BasicInterface {

	public IronBar(int a, int b, String coordType) {

		initCoords(a,b,coordType);
		id = "Iron Bar";
	}

	void drawMe() {
		fill(170,200,200);
		noStroke();
		rect(x-13,y-5,26,10);
	}

	boolean inputItem(String input) {
		return false;
	}
}

class Pipe extends Hopper implements BasicInterface, HopperInterface {

	public Pipe(int a, int b, String coordType, char outDir) {

		initCoords(a,b,coordType);

		id = "Pipe";
		timeLimit = 500;
		capacity = 1;
		outputDirection = outDir;
	}

	void drawMe() {

		pushMatrix();
		translate(x,y);
		noStroke();

		if (full || active) 	fill(0,255,0);
		else 					fill(255,0,0);

		rect(-5,-5,10,10);

		// switch(inputDirection) {
		// 	case 'N':
		// 	rect(-5,-25,10,25);
		// 	break;
		// 	case 'S':
		// 	rect(-5,0,10,25);
		// 	break;
		// 	case 'W':
		// 	rect(-25,-5,25,10);
		// 	break;
		// 	case 'E':
		// 	rect(0,-5,25,10);
		// 	break;
		// }

		switch(outputDirection) {
			case 'N':
			rect(-5,-25,10,25);
			break;
			case 'S':
			rect(-5,0,10,25);
			break;
			case 'W':
			rect(-25,-5,25,10);
			break;
			case 'E':
			rect(0,-5,25,10);
			break;
		}

		popMatrix();
	}

	void update() {
		if (millis() >= startTime + timeLimit || full) {

			int outputRow = 0;
			int outputCol = 0;

			switch(outputDirection) {
				case 'N':
				outputRow = row-1;
				outputCol = col;
				break;
				case 'E':
				outputRow = row;
				outputCol = col+1;
				break;
				case 'S':
				outputRow = row+1;
				outputCol = col;
				break;
				case 'W':
				outputRow = row;
				outputCol = col-1;
				break;
			}

			if (storage.size() > 0) {
				if (grid[outputRow][outputCol].inputItem(storage.get(0))) {
					active = false;
					full = false;
					storage = new ArrayList<String>();
				} else {
					full = true;
				}
			}
		}
	}

	boolean inputItem(String input) {
		if (!active && !full) {
			storage.add(input);
			startTime = millis();
			active = true;
			return true;
		} else {
			return false;
		}
	}
}

class Drill extends Hopper implements BasicInterface, HopperInterface {

	String outputID;
	float angle;

	public Drill(int a, int b, String coordType, String patchID) {

		initCoords(a,b,coordType);

		id = "Drill";
		outputDirection = 'E';
		timeLimit = 3000;
		active = true;

		switch(patchID) {
			case "Iron Ore Patch":
			outputID = "Iron Ore";
			break;
			case "Empty":
			outputID = "Empty";
			break;
		}
	}

	void drawMe() {

		pushMatrix();
		translate(x,y);

		switch(outputID) {
			case "Iron Ore":
			fill(120,150,170);
			rect(-25,-25,50,50);
			break;
		}

		fill(80);
		noStroke();

		if (!full) angle += 5;

		rotate(radians(angle));

		rectMode(CENTER);
		rect(0,0,30,4,5);
		rectMode(CORNER);

		rotate(-radians(angle));

		rect(-5,-4,30,8);

		fill(0,255,0);

		switch(outputDirection) {
			case 'W':
			rect(-20,-3,6,6);
			break;
			case 'E':
			rect(20,-3,6,6);
			break;
		}

		popMatrix();
	}

	void update() {
		if (millis() >= startTime + timeLimit || full) {

			int outputRow = 0;
			int outputCol = 0;

			switch(outputDirection) {
				case 'N':
				outputRow = row-1;
				outputCol = col;
				break;
				case 'E':
				outputRow = row;
				outputCol = col+1;
				break;
				case 'S':
				outputRow = row+1;
				outputCol = col;
				break;
				case 'W':
				outputRow = row;
				outputCol = col-1;
				break;
			}

			if (grid[outputRow][outputCol].inputItem(outputID)) {
				active = false;
				full = false;
				storage = new ArrayList<String>();
				startTime = millis();
			} else {
				full = true;
			}
		}
	}

	boolean inputItem(String input) {
		return false;
	}
}

class Smelter extends Hopper implements BasicInterface, HopperInterface {

	public Smelter(int a, int b, String coordType) {

		initCoords(a,b,coordType);

		id = "Smelter";
		timeLimit = 5000; // 5 sec
		capacity = 1;
	}

	void drawMe() {

		pushMatrix();
		translate(x,y); // center of tile
		fill(80);
		noStroke();
		rect(-25,-25,50,50);

		if (full) fill(0,255,0);
		else if (active) {
			if (frameCount % 100 < 50)	fill(255,frameCount % 50 * 4,0);
			else 						fill(255,200 - (frameCount % 50 * 4),0);
		} else fill(0);

		ellipse(0,0,25,25);

		fill(0,255,0);

		switch(outputDirection) {
			case 'W':
			rect(-25,-3,6,6);
			break;
			case 'E':
			rect(20,-3,6,6);
			break;
			case 'S':
			rect(-3,20,6,6);
			break;
			case 'N':
			rect(-3,-25,6,6);
			break;
		}

		popMatrix();
	}

	void update() {
		if (millis() >= startTime + timeLimit || full) {

			int outputRow = 0;
			int outputCol = 0;

			switch(outputDirection) {
				case 'N':
				outputRow = row-1;
				outputCol = col;
				break;
				case 'E':
				outputRow = row;
				outputCol = col+1;
				break;
				case 'S':
				outputRow = row+1;
				outputCol = col;
				break;
				case 'W':
				outputRow = row;
				outputCol = col-1;
				break;
			}

			if (storage.size() > 0) {
				switch(storage.get(0)) {
					case "Iron Ore":
					if (grid[outputRow][outputCol].inputItem("Iron Bar")) {
						active = false;
						full = false;
						storage = new ArrayList<String>();
					} else {
						full = true;
					}
					break;
					case "Empty":
					break;
					default:
					if (grid[outputRow][outputCol].inputItem(storage.get(0))) {
						active = false;
						full = false;
						storage = new ArrayList<String>();
					} else {
						full = true;
					}
				}
			}
		}
	}

	boolean inputItem(String input) {
		if (!active && !full) {
			storage.add(input);
			startTime = millis();
			active = true;

			if (storage.get(0) != "Iron Ore") {
				startTime = 0;
			}
			return true;
		} else {
			return false;
		}
	}
}
