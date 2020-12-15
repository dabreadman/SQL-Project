INSERT INTO Elements 
VALUES (DEFAULT,'Pyro','Applies Burning'),
(DEFAULT,'Hyro','Slows enemies'),
(DEFAULT,'Dendro','Applies flamable'),
(DEFAULT,'Anemo','Spreads elemental effects'),
(DEFAULT,'Elctro','Paralyses enemies'),
(DEFAULT,'Geo','Creates shields');

INSERT INTO Weapon_types
VALUES (DEFAULT,'Claymore'),(DEFAULT,'Bow'),(DEFAULT,'Sword'),(DEFAULT,'Catalyst'),(DEFAULT,'Polearm');

INSERT INTO Weapons
VALUES 
(DEFAULT,'Skyrider Claymore',1,30),(DEFAULT,'Sacrificial Claymore',1,40),(DEFAULT,'Claymore Prime',1,50),
(DEFAULT,'Skyrider Bow',2,30),(DEFAULT,'Sacrificial Bow',2,40),(DEFAULT,'Bow Prime',2,50),
(DEFAULT,'Skyrider Sword',3,30),(DEFAULT,'Sacrificial Sword',3,40),(DEFAULT,'Sword Prime',3,50),
(DEFAULT,'Skyrider Catalyst',4,30),(DEFAULT,'Sacrificial Catalyst',4,40),(DEFAULT,'Catalyst Prime',4,50),
(DEFAULT,'Skyrider Polearm',5,30),(DEFAULT,'Sacrificial Polearm',5,40),(DEFAULT,'Polearm Prime',5,60);

INSERT INTO Forge
VALUES
(DEFAULT,1,530,50),(DEFAULT,2,1200,30),(DEFAULT,3,1700,20),
(DEFAULT,4,510,42),(DEFAULT,5,1030,31),(DEFAULT,6,1800,25),
(DEFAULT,7,550,40),(DEFAULT,8,1070,37),(DEFAULT,9,1850,20),
(DEFAULT,10,570,52),(DEFAULT,11,1300,32),(DEFAULT,12,1500,24),
(DEFAULT,13,530,53),(DEFAULT,14,1020,33),(DEFAULT,15,1900,23);

INSERT INTO Artefact_types
VALUES (DEFAULT,'Blessing'),(DEFAULT,'Charm'),(DEFAULT,'Obession');

INSERT INTO Artefacts
VALUES 
(DEFAULT,'Hunter\'s Blessing',1,30),(DEFAULT,'Warden\'s Blessing',1,40),(DEFAULT,'Cursed Blessing',1,50),
(DEFAULT,'Hunter\'s Charm',2,30),(DEFAULT,'Warden\'s Charm',2,40),(DEFAULT,'Cursed Charm',2,50),
(DEFAULT,'Hunter\'s Obession',3,30),(DEFAULT,'Warden\'s Obession',3,40),(DEFAULT,'Cursed Obession',3,50);

INSERT INTO Domains
VALUES
(DEFAULT,'Dragon\'s Den',null,1000,0),
(DEFAULT,'Hunter\'s Altar',1,0,50),(DEFAULT,'Warden\'s Altar',2,-100,30),(DEFAULT,'Cursed Altar',3,-1000,30),
(DEFAULT,'Hunter\'s Treasury',4,0,40),(DEFAULT,'Warden\'s Treasury',5,-150,35),(DEFAULT,'Cursed Treasury',6,-1200,35),
(DEFAULT,'Hunter\'s Husk',7,0,45),(DEFAULT,'Warden\'s Husk',8,-250,35),(DEFAULT,'Cursed Husk',9,0,5);

INSERT INTO Characters
VALUES 
(DEFAULT,'Diluc',60,1,1,2),
(DEFAULT,'Xinyan',40,1,1,1),
(DEFAULT,'Razor',40,5,1,2),
(DEFAULT,'Sucrose',40,4,4,3),
(DEFAULT,'Zhongli',60,6,5,1),
(DEFAULT,'Slimy',30,3,3,3),
(DEFAULT,'Traveller',60,null,3,1),
(DEFAULT,'Childe',60,2,2,3),
(DEFAULT,'Fischl',40,4,2,1);

INSERT INTO Players
VALUES 
(DEFAULT,'xcalibur2',0,null,null,null),
(DEFAULT,'dilucmain',670,1,3,5),
(DEFAULT,'electrojojo',400,3,1,5),
(DEFAULT,'chu2ni',2820,9,5,3),
(DEFAULT,'bigdaddy33',0,5,15,2),
(DEFAULT,'slime4life',44,6,9,9),
(DEFAULT,'unarmedman666',6600,7,null,9);

