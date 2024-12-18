INSERT INTO doctor VALUES
 (null,'KOSTAS', 'PAPADOPOULOS', 'Male', 'AΒ012345', 'Ag. Nikolaou', 1, 'Patra', '26221', 12),
 (null, 'Georgios', 'Brokos', 'Male', 'AA21345', 'Maizonos', 24, 'Patra', '12345',1);


INSERT INTO clinic VALUES
('Pathologiki', 200, 'A', '2', 1, '2010-1-1', null),
('Kardiologiki', 110, 'A', '1',2, '2010-1-1', null);


INSERT INTO patient VALUES
(null, 'Nikos', 'Pogkas', 'Male', 'AA987654', 'Karaiskaki', 2, 'Patra', '26223', 'Pathologiki'),
(null, 'Elen', 'Koba', 'Female', 'AX456789', 'Filikis Etaireias', 4 , 'Korinthos', 32649, 'Kardiologiki');


INSERT INTO diploma VALUES
(1,'Medicine Degree', '2000-04-05', 'Pathologos,Xeirourgos'),
(2,'PhD in Medicine','1998-12-05','Kardiologos');


INSERT INTO treatment VALUES
(1,1),
(1,2),
(2,2);


INSERT INTO nurse VALUES
(null, 'Dimitra', 'Pougoura', 'Female', 'AA987654', 'Karaiskaki', 32, 'Patra', 26223, 2610523223),
(null, 'Nikos' , 'Karas', 'Male', 'AM013456', 'Lefkosias', 14, 'Patra', 26300, 2610452321);


INSERT INTO doctor_works VALUES
(1,'Pathologiki'),
(2,'Kardiologiki');


INSERT INTO nurse_works VALUES
(2,'Pathologiki'),
(1,'Kardiologiki');


INSERT INTO drugs VALUES
('augmentin', 1),
('amoxil',1),
('salospir', 2),
('aspirin', 2);


INSERT INTO telephones VALUES
(261020097,1),
(2610123459,2),(2610452555,2);
