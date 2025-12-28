\# The Odyssey



A two-level 2D adventure game where you play as Odysseus infiltrating Troy after 

the Trojan Horse breaches the city walls. Navigate dangerous environments and 

outrun your enemies to reach the throne room and end the ten-year war.



---



\## About the Game



\### Story

The Trojan War has raged for ten long years. You are Odysseus, the cunning Greek 

hero who devised the legendary Trojan Horse. Hidden inside the wooden giant, you 

and your warriors have been brought through Troy's impenetrable walls.



LEVEL 1 - THE CITADEL COURTYARD:

As night falls, you emerge into the burning citadel. Navigate through the 

war-torn courtyard where flames rage, fallen swords and shields scatter the 

ground, and the bodies of soldiers lie where they fell. Avoid enemy patrols 

and reach the palace portal to continue your mission.



LEVEL 2 - THE PALACE CHASE:

Inside the palace, Trojan guards have spotted you! Sprint through the royal 

halls in a desperate chase to reach the throne room. Dodge overturned tables, 

leap over shattered vases, and avoid the endless volley of arrows from pursuing 

archers. The guards grow faster and more aggressive—survive the gauntlet and 

reach 15,000 points to claim the throne room and victory!



The fate of Greece rests on your speed and cunning.



\### Main Features

\- Two distinct gameplay styles in one adventure

\- Level 1: Exploration and hazard avoidance

\- Level 2: Fast-paced infinite runner with increasing difficulty

\- Historical Trojan War setting with authentic atmosphere

\- Progressive challenge system - difficulty increases as you advance

\- Custom hand-drawn artwork and sprites



---



\## How to Play



\### Controls



\#### Keyboard

\- W / Up Arrow - Move Forward

\- A / Left Arrow - Move Left

\- S / Down Arrow - Move Backward

\- D / Right Arrow - Move Right

\- SPACE - Jump

\- ESC - Pause Menu



\### Objective

\- \*\*Level 1\*\*: Navigate through obstacles and find the portal

\- \*\*Level 2\*\*: Survive the chase and reach 15,000 points to win



---



\## Obstacles



\### Level 1 - Citadel Courtyard:

\- \*\*Flames\*\* - Raging fires that block your path

\- \*\*Fallen Swords\*\* - Sharp blades scattered on the ground

\- \*\*Shields\*\* - Scattered shields creating obstacles

\- \*\*Corpses\*\* - Bodies of fallen soldiers



\### Level 2 - Palace Chase:

\- \*\*Tables\*\* - Overturned furniture to jump over

\- \*\*Vases\*\* - Shattered pottery to jump over

\- \*\*Arrows\*\* - Constant projectiles from pursuing archers

\- \*\*Increasing Speed\*\* - The chase gets faster as you progress



---



\## Installation and Running



\### For Players



\#### Download from Itch.io

1\. Visit the game page: https://annabeth176.itch.io/odyssey

2\. Click the \*\*Download\*\* button

3\. Download \*\*index.zip\*\* (44 MB)

4\. Extract the archive to a folder of your choice

5\. Open the extracted folder

6\. Double-click the \*\*.exe\*\* file to start the game



\*\*Note\*\*: You may need to allow the game through Windows Defender/Firewall on first launch.



\### System Requirements



\*\*Minimum:\*\*

\- OS: Windows 7/8/10/11

\- RAM: 2 GB

\- Storage: 100 MB

\- Graphics: Any modern GPU with OpenGL 3.3 support



\*\*Recommended:\*\*

\- OS: Windows 10/11

\- RAM: 4 GB

\- Storage: 200 MB



---



\## Technologies Used



\- \*\*Engine\*\*: Godot Engine 4.5.1

\- \*\*Language\*\*: GDScript

\- \*\*Art\*\*: Created by me with assets from PNGEgg

\- \*\*Tools\*\*: Krita and Photoshop

\- \*\*Music\*\*: Pixabay (royalty-free music)



---



\## For Developers



\### Open in Godot



\#### Requirements

\- Godot Engine 4.5.1 or newer

\- Git (optional)



\#### Setup

1\. Clone the repository:

```bash

git clone https://github.com/Annabeth176/The-Odyssey.git

cd The-Odyssey

```



2\. Open Godot Engine 4.5.1

3\. Click "Import"

4\. Select the project.godot file

5\. Click "Import \& Edit"

6\. Press F5 to run the game



\### Project Structure

```

The-Odyssey/

├── res://

│   ├── addons/

│   │   └── godot\_super-wakatime/     # Plugin for time tracking

│   ├── Audio/

│   │   └── Music/

│   │       ├── Level1.mp3             # Level 1 music

│   │       ├── Level2.mp3             # Level 2 music

│   │       └── Menu.mp3               # Menu music

│   ├── Background/

│   │   ├── BackgroundLevel1.1.PNG

│   │   ├── BackgroundLevel1.2.jpg

│   │   ├── BackgroundLevel1.3.jpg

│   │   ├── BackgroundLevel1.4.jpg

│   │   ├── DirtLevel1.PNG

│   │   ├── Hallway(1).png

│   │   ├── Hallway.png

│   │   ├── Nivel 1 Scena 1..PNG

│   │   ├── Nivel 1 Scena 2..PNG

│   │   ├── Nivel 1 Scena 3..PNG

│   │   ├── Nivel 1 Scena 5.PNG

│   │   ├── Podea.jpeg

│   │   ├── podea.png

│   │   ├── Portal.png

│   │   └── Screenshot 2025-12-27 235137.png

│   ├── images/

│   │   ├── godot\_logo.png

│   │   └── icon.jpg

│   ├── Scenes/

│   │   ├── Graund/

│   │   │   └── graund.tscn

│   │   ├── Levels/

│   │   │   ├── Level1.tscn

│   │   │   ├── level\_1.gd

│   │   │   ├── level\_2.gd

│   │   │   ├── level\_2.tscn

│   │   │   └── texture\_progress\_bar.gd

│   │   ├── Meniuri/

│   │   │   ├── game\_over\_screen.gd

│   │   │   ├── game\_over\_screen.tscn

│   │   │   ├── instructions\_level1.tscn

│   │   │   ├── instructions\_level1.tscn

│   │   │   ├── instructions\_level2.tscn

│   │   │   ├── instructions\_level\_1.gd

│   │   │   ├── instructions\_level\_2.gd

│   │   │   ├── main\_menu.gd

│   │   │   ├── main\_menu.tscn

│   │   │   ├── pause\_menu.gd

│   │   │   ├── pause\_menu.tscn

│   │   │   ├── settings\_menu.gd

│   │   │   ├── settings\_menu.tscn

│   │   │   ├── win\_screen.gd

│   │   │   └── win\_screen.tscn

│   │   ├── Obstacle/

│   │   │   ├── Arrow/

│   │   │   │   ├── arrow.gd

│   │   │   │   └── arrow.tscn

│   │   │   ├── Dead/

│   │   │   │   └── Dead.tscn

│   │   │   ├── Fire/

│   │   │   │   ├── animated\_sprite\_2d.gd

│   │   │   │   └── fire.tscn

│   │   │   ├── sword and shield/

│   │   │   │   └── character\_body\_2d.tscn

│   │   │   ├── Table/

│   │   │   │   └── table.tscn

│   │   │   └── Vase/

│   │   ├── Player/

│   │   │   ├── player.gd

│   │   │   └── Player.tscn

│   │   ├── Player2/

│   │   │   ├── player2.tscn

│   │   │   └── player\_2.gd

│   │   ├── Portal/

│   │   │   ├── portal.gd

│   │   │   └── portal.tscn

│   │   ├── Score/

│   │   │   └── Score.tscn

│   │   └── UI/

│   │       └── sprite\_2d.gd

│   ├── Sprites/

│   │   ├── Arrow.png

│   │   ├── Dead1.png

│   │   ├── healthbarProgress.png

│   │   ├── healthbarUnder.png

│   │   ├── Player1.PNG

│   │   ├── Player2 jos.png

│   │   ├── Player2.png

│   │   ├── Player3.png

│   │   ├── Shadow.png

│   │   ├── Shield.png

│   │   ├── Sprite-sheet-campfire.png

│   │   ├── sword.png

│   │   ├── Table.png

│   │   └── vase.png

│   ├── audio\_manager.gd

│   ├── export\_presets.cfg

│   ├── fire.gd

│   ├── icon.gd

│   ├── icon.svg

│   ├── index.apple-touch-icon.png

│   ├── index.icon.png

│   ├── index.png

│   ├── project.godot              # Main project file

│   ├── README.md                  # This file

│   ├── save\_manager.gd

│   ├── Test.tscn

│   ├── The-Odyssey.apple-touch-icon.png

│   ├── The-Odyssey.icon.png

│   └── The-Odyssey.png

```



\### Contributing

If you would like to contribute:

1\. Fork the repository

2\. Create a feature branch (`git checkout -b feature/NewFeature`)

3\. Commit your changes (`git commit -m 'Add NewFeature'`)

4\. Push to the branch (`git push origin feature/NewFeature`)

5\. Open a Pull Request



---



\## Known Bugs



\- Performance may vary on older systems

\- Level 2 difficulty curve is very steep - feedback welcome!



Report new bugs at: https://github.com/Annabeth176/The-Odyssey/issues



---



\## Future Plans



\- Add more levels with different historical settings

\- Implement difficulty settings (Easy, Normal, Hard)

\- Add achievement system

\- Create mobile version for Android and iOS

\- Add more enemy types and boss battles

\- Improve visual effects and animations

\- Add sound effects

\- Implement save/load system



---



\## Credits



\*\*Development\*\*: Annabeth176

\- Game design and programming

\- Level design



\*\*Art\*\*: Annabeth176

\- Created using Krita and Photoshop

\- Additional assets from PNGEgg



\*\*Music\*\*: Pixabay (royalty-free music)



\*\*Engine\*\*: Godot Engine 4.5.1



---



\## License



\### Code

This project's code is licensed under the \*\*MIT License\*\*.

You are free to use, modify, and distribute the code with attribution.



\### Art \& Assets

All original artwork and sprites are \*\*© 2024 Annabeth176. All Rights Reserved.\*\*

The visual assets may not be used, reproduced, or distributed without explicit permission.



Assets sourced from PNGEgg are used under their respective licenses.



\### Music

Music is sourced from Pixabay under their royalty-free license.



See the LICENSE file for full details.



---



\## Contact



\- \*\*Itch.io\*\*: https://annabeth176.itch.io/odyssey

\- \*\*GitHub\*\*: https://github.com/Annabeth176/The-Odyssey

\- \*\*Profile\*\*: https://annabeth176.itch.io



---



\## Support



If you enjoyed the game:

\- Star the repository on GitHub

\- Leave a rating and review on Itch.io

\- Share with friends who love indie games

\- Report bugs to help improve the game



---



\*\*Made using Godot Engine 4.5.1\*\*



\[⬆ Back to top](#the-odyssey)

