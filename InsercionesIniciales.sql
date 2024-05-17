DELIMITER ;

DELETE FROM GruposXCursoLectivo;

DELETE FROM SeccionesXNivel;
DELETE FROM MateriasXNivel;
DELETE FROM Niveles;

DELETE FROM TiposSecciones;

DELETE FROM CursosLectivos;
DELETE FROM PeriodosLectivos;

DELETE FROM Materias;

INSERT INTO Niveles(IdNivel, Nivel) VALUES(7, 'Sétimo');
INSERT INTO Niveles(IdNivel, Nivel) VALUES(8, 'Octavo');
INSERT INTO Niveles(IdNivel, Nivel) VALUES(9, 'Noveno');
INSERT INTO Niveles(IdNivel, Nivel) VALUES(10, 'Décimo');
INSERT INTO Niveles(IdNivel, Nivel) VALUES(11, 'Undécimo');

INSERT INTO TiposSecciones(IdTipoSeccion, TipoSeccion) VALUES(1, 'Regular');
INSERT INTO TiposSecciones(IdTipoSeccion, TipoSeccion) VALUES(2, 'Computación');
INSERT INTO TiposSecciones(IdTipoSeccion, TipoSeccion) VALUES(3, 'Olimpiadas');

INSERT INTO SeccionesXNivel(IdSeccion, Seccion, IdNivel, IdTipoSeccion) VALUES(1, '9-2', 9, 1);
INSERT INTO SeccionesXNivel(IdSeccion, Seccion, IdNivel, IdTipoSeccion) VALUES(2, '10-BIO1', 10, 3);

INSERT INTO PeriodosLectivos(IdPeriodo, Periodo) VALUES(1, 'Primer Trimestre');
INSERT INTO PeriodosLectivos(IdPeriodo, Periodo) VALUES(2, 'Segundo Trimestre');
INSERT INTO PeriodosLectivos(IdPeriodo, Periodo) VALUES(3, 'Tercer Trimestre');

INSERT INTO Materias(IdMateria, Materia) VALUES(1, 'Ciencias');
INSERT INTO Materias(IdMateria, Materia) VALUES(2, 'Biología');

INSERT INTO MateriasXNivel(IdNivel, IdMateria) VALUES(9, 1);
INSERT INTO MateriasXNivel(IdNivel, IdMateria) VALUES(10, 2);
