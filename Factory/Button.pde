
class Button {

	int x;
	int y;
	public String id;
	int index;
	EntityObject model;

	public Button(int xCoord, int yCoord, String t) {
		x = xCoord;
		y = yCoord;
		id = t;
		index = indexOf(id,buildingNames);

		switch(id) {
			case "Smelter":
			model = new Smelter(x+75,y+75,"xy");
			break;
			case "Drill":
			model = new Drill(x+75,y+75,"xy","Empty");
			break;
			case "Pipe":
			model = new Pipe(x+75,y+75,"xy",'E');
			break;
			case "Empty":
			model = new Empty(x+75,y+75,"xy");
			break;
		}
	}

	boolean inBounds(int testX, int testY) {
		return (testX - 850 > x && testX - 850 < x+150 && testY - 50 > y && testY - 50 < y+150);
	}

	void drawMe() {

		fill(255);
		stroke(150);
		rect(x,y,150,150,10);

		fill(0);
		textSize(30);
		text(id,x+75,y+30);

		model.drawMe();

		int[] costs = buildingCosts[index];
		int materials = 0;

		for (int i = 0; i < costs.length; i++) {
			if (costs[i] > 0) {

				EntityObject model = new Empty(123456789,987654321,"xy");
				switch(itemNames[i]) {
					case "Iron Bar":
					model = new IronBar(x+25*(materials+1),y+110,"xy");
					break;
				}

				model.drawMe();
				fill(0);
				textSize(20);
				text(costs[i],x+25*(materials+1),y+140);
			}
		}
	}
}