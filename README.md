# Virus battle strategy game (2025 vers)

A simple demonstration of how CNNs can be integrated into desktop games built with Godot. The player may submit a doodle made on the game's canvas. Should the drawing be classified as a white blood cell, the player fires at the closest enemy; should it be considered a red blood cell, the player's oxygen count increases by 1 instead. Oxygens may be used to purchase supporting troops that march forward at the enemy.

This project uses IREE's execution environment to deploy the image classification model.

[![alt text][image]][hyperlink]

[hyperlink]: https://virtujoy.domcloud.dev/images/e/ec/00_guide.png
[image]:
https://virtujoy.domcloud.dev/images/e/ec/00_guide.png
(Screenshot of the in-game guide)

[![alt text][image2]][hyperlink2]

[hyperlink2]: https://virtujoy.domcloud.dev/images/2/22/02_wbc.png
[image2]:
https://virtujoy.domcloud.dev/images/2/22/02_wbc.png
(Screenshot of gameplay; a white blood cell is drawn on the canvas)

[![alt text][image3]][hyperlink3]

[hyperlink3]: https://virtujoy.domcloud.dev/images/7/7a/01_rbc.png
[image3]:
https://virtujoy.domcloud.dev/images/7/7a/01_rbc.png
(Screenshot of gameplay; a red blood cell is drawn on the canvas)