
class Button {
		// buttons are only graphical, and arent ACTUALLY interacted with!
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
		model = makeModel(id,x+75,y+75);
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

				EntityObject costModel = makeModel(itemNames[i],x+25*(materials+1),y+110);

				costModel.drawMe();
				
				fill(0);
				textSize(20);
				text(costs[i],x+25*(materials+1),y+140);
			}
		}
	}
}