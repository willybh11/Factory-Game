
void keyPressed() {
	if (key == CODED) {
		switch(keyCode) {
			case UP:
			case DOWN:
			case LEFT:
			case RIGHT:
			if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) {
				int col = mouseX / 50 - 1;
				int row = mouseY / 50 - 1;

				switch(keyCode) {
					case UP:
					grid[row][col].rotateMe('N');
					break;
					case DOWN:
					grid[row][col].rotateMe('S');
					break;
					case LEFT:
					grid[row][col].rotateMe('W');
					break;
					case RIGHT:
					grid[row][col].rotateMe('E');
					break;
				}
			}
		}
	}
	switch(key) {
		case 'q':
		case 'Q':
		exit();
	}
}

void mousePressed() {
	if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) { // on grid
		lastPress[0] = mouseY / 50 - 1; 	// row
		lastPress[1] = mouseX / 50 - 1; 	// col
		println(lastPress[0],lastPress[1]);
	}
}

void mousePressedUpdate() {

	if (mousePressed) {
		if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) { // on grid
			int mouseCol = mouseX / 50 - 1;
			int mouseRow = mouseY / 50 - 1;

			if (mouseRow != lastPress[0] || mouseCol != lastPress[1]) {

				String temp = itemInHands;
				swapItems(lastPress[0],lastPress[1]);
				buy(temp);

				if (temp == "Pipe") {
					if 		(mouseRow > lastPress[0])	grid[lastPress[0]][lastPress[1]].rotateMe('S');
					else if (mouseRow < lastPress[0])	grid[lastPress[0]][lastPress[1]].rotateMe('N');
					else if (mouseCol > lastPress[1])	grid[lastPress[0]][lastPress[1]].rotateMe('E');
					else if (mouseCol < lastPress[1])	grid[lastPress[0]][lastPress[1]].rotateMe('W');
				}

				if (temp != "Empty") { // someothing is wrong here
					for (Button button : buildingButtons) {
						if (button.id == temp) {
							for (int i = 0; i < buildingCosts[button.index].length; i++) {
								inventory[i] -= buildingCosts[button.index][i];
							}

							deconstruct(temp);
							itemInHands = button.id;
						}
					}
			}

				lastPress[0] = mouseRow;
				lastPress[1] = mouseCol;
			}
		}
	}
}

void mouseReleased() {

	if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) { // on grid
		int col = mouseX / 50 - 1;
		int row = mouseY / 50 - 1;

		swapItems(row,col);

	} else if (mouseX < 150 && mouseX > 50 && mouseY < 950 && mouseY > 850) { // on hands

		deconstruct(itemInHands);
		itemInHands = "Empty";

	} else if (mouseX < 1400 && mouseX > 200 && mouseY < 950 && mouseY > 850) { // on inv

		int cursorIndex = mouseX / 100 - 2;

		deconstruct(itemInHands);
		itemInHands = itemNames[cursorIndex];
		inventory[cursorIndex]--;

	} else if (mouseX < 1400 && mouseX > 850 && mouseY < 800 && mouseY > 50) {	// on build menu
		for (Button button : buildingButtons) {
			if (button.inBounds(mouseX,mouseY)) {

				buy(button.id);

				deconstruct(itemInHands);
				itemInHands = button.id;
			}
		}
	}
}