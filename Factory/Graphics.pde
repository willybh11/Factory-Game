
void drawGrid() {

	pushMatrix();
	translate(50,50);
	strokeWeight(1);
	stroke(150);

	for (int row = 0; row < 15; row++) {
		for (int col = 0; col < 15; col++) {

			grid[row][col].drawMe();

			if (HopperInterface.class.isAssignableFrom(grid[row][col].getClass())) {
				grid[row][col].update();
			}

			// if (grid[row][col] instanceof HopperInterface) grid[row][col].update();

			// if (entityType(grid[row][col].id) == "Hopper") grid[row][col].update();
		}
	}

	popMatrix();
}

void drawBuildMenu() {

	pushMatrix();

	translate(850,50);
	fill(255);
	rect(0,0,550,750);

	for (Button button : buildingButtons) {
		button.drawMe();
	}

	popMatrix();
}

void drawHands() {

	pushMatrix();
	translate(50,850);
	strokeWeight(1);
	stroke(150);

	fill(255);
	rect(0,0,100,100);

	EntityObject model = new Empty(12345,54321,"xy");

	switch(itemInHands) {
		case "Iron Ore":
		model = new IronOre(50,50,"xy");
		break;
		case "Iron Bar":
		model = new IronBar(50,50,"xy");
		break;
		case "Smelter":
		model = new Smelter(50,50,"xy");
		break;
		case "Drill":
		model = new Drill(50,50,"xy","Empty");
		break;
		case "Pipe":
		model = new Pipe(50,50,"xy",'E');
		break;
	}

	model.drawMe();

	popMatrix();
}

void drawInventory() {

	pushMatrix();

	translate(200,850);
	fill(255);
	rect(0,0,1200,100);

	for (int i = 0; i < inventory.length; i++) {
		fill(0);
		textSize(24);
		text(itemNames[i],50 + 100*i,30);
		textSize(20);
		text(inventory[i],50 + 100*i,53);

		stroke(150);
		strokeWeight(1);
		line(100*(i+1),0,100*(i+1),100);

		EntityObject model = new Empty(12345,54321,"xy");

		switch(itemNames[i]) {
			case "Iron Ore":
			model = new IronOre(50 + 100*i,75,"xy");
			break;
			case "Iron Bar":
			model = new IronBar(50 + 100*i,75,"xy");
			break;
		}

		model.drawMe();
	}

	popMatrix();
}

void drawMouse() {
	if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) {
		int col = mouseY / 50;
		int row = mouseX / 50;

		stroke(255,0,0);
		strokeWeight(3);
		noFill();
		rect(row*50,col*50,50,50);
	} else {
		fill(255,0,0);
		noStroke();
		rect(mouseX-1,mouseY-10,2,20);
		rect(mouseX-10,mouseY-1,20,2);
	}
}