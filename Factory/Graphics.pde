
void drawGrid() {

	pushMatrix();
	translate(50,50);
	strokeWeight(1);
	stroke(150);

	for (int row = 0; row < 15; row++) {
		for (int col = 0; col < 15; col++) {

			grid[row][col].drawMe();

			if (Hopper.class.isAssignableFrom(grid[row][col].getClass())) { // ?
				grid[row][col].update();
			}
		}
	}

	popMatrix();
}

void drawBuildMenu() {

	pushMatrix();

	translate(850,50);
	fill(255);
	rect(0,0,550,750);

	for (Button button : buildingButtons)
		button.drawMe();

	popMatrix();
}

void drawHands() {

	pushMatrix();
	translate(50,850);
	strokeWeight(1);
	stroke(150);

	fill(255);
	rect(0,0,100,100);

	EntityObject model = makeModel(itemInHands,50,50);

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

		EntityObject model = makeModel(itemNames[i],50 + 100*i,75);

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