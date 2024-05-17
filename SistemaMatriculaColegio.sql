DELIMITER ;

DROP TABLE IF EXISTS PalabrasXUsuario;
DROP TABLE IF EXISTS PalabrasXEstudiante;
DROP TABLE IF EXISTS Palabras;
DROP TABLE IF EXISTS CaracteresXPalabraSemejante;
DROP TABLE IF EXISTS PalabrasSemejantes;
DROP TABLE IF EXISTS Usuarios;
DROP TABLE IF EXISTS CalificacionesXEstudiante;
DROP TABLE IF EXISTS MateriasXNivel;
DROP TABLE IF EXISTS NivelesXCursoLectivoXEstudiante;
DROP TABLE IF EXISTS SeccionesXCursoLectivoXEstudiante;
DROP TABLE IF EXISTS GruposXCursoLectivo;
DROP TABLE IF EXISTS SeccionesXNivel;
DROP TABLE IF EXISTS Niveles;
DROP TABLE IF EXISTS TiposSecciones;
DROP TABLE IF EXISTS CursosLectivos;
DROP TABLE IF EXISTS PeriodosLectivos;
DROP TABLE IF EXISTS Materias;
ALTER TABLE Estudiantes DROP INDEX IX_CarneEstudiante;
DROP TABLE IF EXISTS Estudiantes;

CREATE TABLE IF NOT EXISTS PalabrasSemejantes (
    IdPalabraSemejante INT NOT NULL,
    PalabraSemejante VARCHAR(100) NOT NULL,
    EstaLibre BIT NOT NULL,
    PRIMARY KEY (IdPalabraSemejante),
    CONSTRAINT IX_PalabraSemejante UNIQUE (PalabraSemejante)
);

CREATE TABLE IF NOT EXISTS CaracteresXPalabraSemejante (
    IdPalabraSemejante INT NOT NULL,
    Caracter VARCHAR(1) NOT NULL,
    PRIMARY KEY (IdPalabraSemejante, Caracter),
    FOREIGN KEY (IdPalabraSemejante) REFERENCES PalabrasSemejantes(IdPalabraSemejante)
);

CREATE TABLE IF NOT EXISTS Palabras (
    IdPalabra INT NOT NULL,
    Palabra VARCHAR(100) NOT NULL,
    EstaLibre BIT NOT NULL,
    IdPalabraSemejante INT NOT NULL,
    PRIMARY KEY (IdPalabra),
    CONSTRAINT IX_Palabra UNIQUE (Palabra),
    FOREIGN KEY (IdPalabraSemejante) REFERENCES PalabrasSemejantes(IdPalabraSemejante)
);

CREATE TABLE IF NOT EXISTS Usuarios (
    IdUsuario INT NOT NULL,
    Usuario VARCHAR(50) NOT NULL,
    Cedula VARCHAR(100) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Contrasena VARCHAR(50) NOT NULL,    
    EsAdministrador BIT NOT NULL,
    PRIMARY KEY (IdUsuario),
    CONSTRAINT IX_Usuario UNIQUE (Usuario)
);

CREATE TABLE IF NOT EXISTS PalabrasXUsuario (
    IdUsuario INT NOT NULL,
    IdPalabra INT NOT NULL,
    PRIMARY KEY (IdUsuario, IdPalabra),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    FOREIGN KEY (IdPalabra) REFERENCES Palabras(IdPalabra)
);

CREATE TABLE IF NOT EXISTS Niveles (
    IdNivel INT NOT NULL,
    Nivel VARCHAR(50) NOT NULL,
    PRIMARY KEY (IdNivel),
    CONSTRAINT IX_Nivel UNIQUE (Nivel)
);

CREATE TABLE IF NOT EXISTS TiposSecciones (
    IdTipoSeccion INT NOT NULL,
    TipoSeccion VARCHAR(50) NOT NULL,
    PRIMARY KEY (IdTipoSeccion),
    CONSTRAINT IX_TipoSeccion UNIQUE (TipoSeccion)
);

CREATE TABLE IF NOT EXISTS SeccionesXNivel (
    IdSeccion INT NOT NULL,        
    Seccion VARCHAR(50) NOT NULL,    
    IdNivel INT NOT NULL,    
    IdTipoSeccion INT NOT NULL,
    PRIMARY KEY (IdSeccion),
    CONSTRAINT IX_Seccion UNIQUE (Seccion),
    CONSTRAINT IX_NivelSeccion UNIQUE (IdSeccion, IdNivel),    
    CONSTRAINT IX_TipoSeccionXSeccion UNIQUE (IdSeccion, IdTipoSeccion),        
    FOREIGN KEY (IdNivel) REFERENCES Niveles(IdNivel),    
    FOREIGN KEY (IdTipoSeccion) REFERENCES TiposSecciones(IdTipoSeccion)     
);

CREATE TABLE IF NOT EXISTS CursosLectivos (
    Curso INT NOT NULL,        
    PRIMARY KEY (Curso)
);

CREATE TABLE IF NOT EXISTS PeriodosLectivos (
    IdPeriodo INT NOT NULL,        
    Periodo VARCHAR(50) NOT NULL,    
    PRIMARY KEY (IdPeriodo),
    CONSTRAINT IX_PeriodoLectivo UNIQUE (Periodo)
);

CREATE TABLE IF NOT EXISTS Materias (
    IdMateria INT NOT NULL,
    Materia VARCHAR(50) NOT NULL,
    PRIMARY KEY (IdMateria),
    CONSTRAINT IX_Materia UNIQUE (Materia)
);

CREATE TABLE IF NOT EXISTS MateriasXNivel (
    IdNivel INT NOT NULL,    
    IdMateria INT NOT NULL,        
    PRIMARY KEY (IdNivel, IdMateria),
    FOREIGN KEY (IdNivel) REFERENCES Niveles(IdNivel),
    FOREIGN KEY (IdMateria) REFERENCES Materias(IdMateria)
);

CREATE TABLE IF NOT EXISTS Estudiantes (
    IdEstudiante INT NOT NULL,    
    Cedula VARCHAR(50) NOT NULL, 
    Carne VARCHAR(50) NOT NULL,             
    Nombre VARCHAR(100) NOT NULL,     
    PRIMARY KEY (IdEstudiante),
    CONSTRAINT IX_CedulaEstudiante UNIQUE (Cedula)
);

CREATE INDEX IX_CarneEstudiante ON Estudiantes(Carne);

CREATE TABLE IF NOT EXISTS PalabrasXEstudiante (
    IdEstudiante INT NOT NULL,
    IdPalabra INT NOT NULL,
    PRIMARY KEY (IdEstudiante, IdPalabra),
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),
    FOREIGN KEY (IdPalabra) REFERENCES Palabras(IdPalabra)
);

CREATE TABLE IF NOT EXISTS GruposXCursoLectivo (
    Curso INT NOT NULL,
    IdNivel INT NOT NULL,  
    IdSeccion INT NOT NULL,      
    PRIMARY KEY (Curso, IdNivel, IdSeccion),
    FOREIGN KEY (Curso) REFERENCES CursosLectivos(Curso),    
    FOREIGN KEY (IdSeccion, IdNivel) REFERENCES SeccionesXNivel(IdSeccion, IdNivel)
);

CREATE TABLE IF NOT EXISTS NivelesXCursoLectivoXEstudiante (
    IdEstudiante INT NOT NULL,    
    Curso INT NOT NULL,        
    IdNivel INT NOT NULL,      
    PRIMARY KEY (IdEstudiante, Curso),
    CONSTRAINT IX_NivelXEstudianteXCurso UNIQUE (IdEstudiante, Curso, IdNivel),
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),    
    FOREIGN KEY (Curso) REFERENCES CursosLectivos(Curso),        
    FOREIGN KEY (IdNivel) REFERENCES Niveles(IdNivel)
);

CREATE TABLE IF NOT EXISTS SeccionesXCursoLectivoXEstudiante (
    IdEstudiante INT NOT NULL,    
    Curso INT NOT NULL,        
    IdTipoSeccion INT NOT NULL,                         
    IdSeccion INT NOT NULL,    
    IdNivel INT NOT NULL,    
    PRIMARY KEY (IdEstudiante, Curso, IdTipoSeccion),
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),    
    FOREIGN KEY (IdSeccion, IdTipoSeccion) REFERENCES SeccionesXNivel(IdSeccion, IdTipoSeccion),
    FOREIGN KEY (Curso, IdNivel, IdSeccion) REFERENCES GruposXCursoLectivo(Curso, IdNivel, IdSeccion)
);

CREATE TABLE IF NOT EXISTS CalificacionesXEstudiante (
    IdEstudiante INT NOT NULL,    
    Curso INT NOT NULL,                 
    IdPeriodo INT NOT NULL,                    
    IdMateria INT NOT NULL,                
    IdNivel INT NOT NULL,     
    Calificacion INT NOT NULL,                     
    PRIMARY KEY (IdEstudiante, Curso, IdPeriodo, IdMateria),
    FOREIGN KEY (IdEstudiante, Curso, IdNivel) REFERENCES NivelesXCursoLectivoXEstudiante(IdEstudiante, Curso, IdNivel),    
    FOREIGN KEY (IdPeriodo) REFERENCES PeriodosLectivos(IdPeriodo),
    FOREIGN KEY (IdNivel, IdMateria) REFERENCES MateriasXNivel(IdNivel, IdMateria)    
);

DROP PROCEDURE IF EXISTS DemeSiguientePalabra;
DROP PROCEDURE IF EXISTS DemePalabraSemejante;
DROP PROCEDURE IF EXISTS ValidarContrasena;
DROP PROCEDURE IF EXISTS Encriptar;
DROP PROCEDURE IF EXISTS SonHilerasIdenticasBitXBit;
DROP PROCEDURE IF EXISTS CambiarContrasena;
DROP PROCEDURE IF EXISTS ValidarLogin;
DROP PROCEDURE IF EXISTS IndexarCaracteresXPalabraSemejante;
DROP PROCEDURE IF EXISTS IndexarPalabraSemejante;
DROP PROCEDURE IF EXISTS LiberarPalabrasSemejantesNoUtilizadas;
DROP PROCEDURE IF EXISTS IndexarPalabra;
DROP PROCEDURE IF EXISTS LiberarPalabrasNoUtilizadas;

DROP PROCEDURE IF EXISTS IndexarUsuario;
DROP PROCEDURE IF EXISTS IndexarTodosUsuarios;
DROP PROCEDURE IF EXISTS ValidarCamposUsuario;
DROP PROCEDURE IF EXISTS AltaUsuario;
DROP PROCEDURE IF EXISTS CambioUsuario;

DROP PROCEDURE IF EXISTS IndexarEstudiante;
DROP PROCEDURE IF EXISTS IndexarTodosEstudiantes;
DROP PROCEDURE IF EXISTS ValidarCamposEstudiante;
DROP PROCEDURE IF EXISTS AltaEstudiante;

DELIMITER $$

CREATE PROCEDURE DemeSiguientePalabra(IN HileraXAnalizar VARCHAR(500), IN CaracteresValidos VARCHAR(500), IN IndiceInicial INT, OUT SiguientePalabra VARCHAR(500), OUT NuevoIndice INT, IN TamanoMaximoPalabra INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET NuevoIndice = IndiceInicial;
  SET SiguientePalabra = '';

  WHILE NuevoIndice <= CHAR_LENGTH(HileraXAnalizar) AND POSITION(SUBSTRING(HileraXAnalizar, NuevoIndice, 1) IN CaracteresValidos) < 1 DO
    SET NuevoIndice = NuevoIndice + 1;
  END WHILE;

  WHILE NuevoIndice <= CHAR_LENGTH(HileraXAnalizar) AND POSITION(SUBSTRING(HileraXAnalizar, NuevoIndice, 1) IN CaracteresValidos) >= 1 DO
    SET SiguientePalabra = CONCAT(SiguientePalabra, SUBSTRING(HileraXAnalizar, NuevoIndice, 1));
    SET NuevoIndice = NuevoIndice + 1;
  END WHILE;

  IF TamanoMaximoPalabra >= 0 THEN
    IF TamanoMaximoPalabra = 0 THEN
      SET SiguientePalabra = '';
    ELSE
      SET SiguientePalabra = MID(SiguientePalabra, 1, TamanoMaximoPalabra);
    END IF;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT SiguientePalabra, NuevoIndice;
  END IF;
END;

DELIMITER $$

CREATE PROCEDURE DemePalabraSemejante(IN Palabra VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), OUT PalabraSemejante VARCHAR(500), IN RetornarResultadosEnSelect BIT(1))
BEGIN
/* Advertencia: La hilera 'TuplasReemplazos' debe contener espacios en blanco donde se requiera, pues este procedimiento no reemplaza ninguno */

  SET PalabraSemejante = LOWER(Palabra);
  SET TuplasReemplazos = LOWER(TuplasReemplazos);
  /* Los anteriores dos reemplazos son para que no se distinga entre caracteres en minúscula y mayúscula */

  SET @Tupla = SUBSTRING_INDEX(TuplasReemplazos, SeparadorTuplas, 1);
  
  WHILE CHAR_LENGTH(@Tupla) >= 1 DO
    SET @AReemplazar = SUBSTRING_INDEX(@Tupla, SeparadorColumnas, 1);
    
    IF CHAR_LENGTH(@AReemplazar) >= 1 AND INSTR(PalabraSemejante, @AReemplazar) >= 1 THEN
      SET @Reemplazo = SUBSTRING(@Tupla, CHAR_LENGTH(@AReemplazar) + CHAR_LENGTH(SeparadorColumnas) + 1);
      SET PalabraSemejante = REPLACE(PalabraSemejante, @AReemplazar, @Reemplazo);
    END IF;

    SET TuplasReemplazos = SUBSTRING(TuplasReemplazos, CHAR_LENGTH(@Tupla) + CHAR_LENGTH(SeparadorTuplas) + 1);
    SET @Tupla = SUBSTRING_INDEX(TuplasReemplazos, SeparadorTuplas, 1);
  END WHILE;
      
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT PalabraSemejante;
  END IF;
END;

DELIMITER $$

CREATE PROCEDURE ValidarContrasena(IN Contrasena VARCHAR(500), OUT NumError INT, IN LongitudMinimaContrasena INT, IN CaracteresEspeciales VARCHAR(500), IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET NumError = 0;
  
  SET @CaracteresAlfabeticos = "abcdefghijklmnñopqrstuvwxyzáéíóúü";
  SET @CaracteresAlfabeticosMayuscula = UPPER(@CaracteresAlfabeticos);
  SET @CaracteresAlfabeticosMinuscula = LOWER(@CaracteresAlfabeticos);
  SET @DigitosDecimales = "0123456789";
  
  SET @ContadorCaracteresAlfabeticosMayuscula = 0;
  SET @ContadorCaracteresAlfabeticosMinuscula = 0;
  SET @ContadorDigitosDecimales = 0;
  SET @ContadorCaracteresEspeciales = 0;
  
  IF (CHAR_LENGTH(Contrasena) < LongitudMinimaContrasena) THEN
    SET NumError = 1;
  ELSE
    SET @Indice = 1;

    WHILE @Indice <= CHAR_LENGTH(Contrasena) DO
      SET @SiguienteCaracter = MID(Contrasena, @Indice, 1);
    
      IF SUBSTRING_INDEX(@CaracteresAlfabeticosMayuscula, @SiguienteCaracter, 1) != @CaracteresAlfabeticosMayuscula THEN
        SET @ContadorCaracteresAlfabeticosMayuscula = @ContadorCaracteresAlfabeticosMayuscula + 1;
      
      ELSEIF SUBSTRING_INDEX(@CaracteresAlfabeticosMinuscula, @SiguienteCaracter, 1) != @CaracteresAlfabeticosMinuscula THEN
        SET @ContadorCaracteresAlfabeticosMinuscula = @ContadorCaracteresAlfabeticosMinuscula + 1;

      ELSEIF SUBSTRING_INDEX(@DigitosDecimales, @SiguienteCaracter, 1) != @DigitosDecimales THEN
        SET @ContadorDigitosDecimales = @ContadorDigitosDecimales + 1;

      ELSEIF SUBSTRING_INDEX(CaracteresEspeciales, @SiguienteCaracter, 1) != CaracteresEspeciales THEN
        SET @ContadorCaracteresEspeciales = @ContadorCaracteresEspeciales + 1;
      
      END IF;

      SET @Indice = @Indice + 1;
    END WHILE;
    
    IF @ContadorCaracteresAlfabeticosMayuscula < 1 OR @ContadorCaracteresAlfabeticosMinuscula < 1 OR @ContadorDigitosDecimales < 1 OR @ContadorCaracteresEspeciales < 1 THEN
      SET NumError = 2;
    END IF;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
      SELECT NumError;
  END IF;
END;

DELIMITER $$

CREATE PROCEDURE Encriptar(IN HileraXEncriptar VARCHAR(500), IN CodigoEncriptacion VARCHAR(500), OUT HileraEncriptada VARCHAR(500), IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET HileraEncriptada = '';
  
  IF CHAR_LENGTH(CodigoEncriptacion) > 0 THEN
    SET @MaximoNumeroCaracteresXCodificar = POWER(2, 7);
    SET @IndiceActual = 0;
    
    WHILE @IndiceActual < CHAR_LENGTH(HileraXEncriptar) DO
      SET @PosicionEnCodigoEncriptacion = MOD(@IndiceActual, CHAR_LENGTH(CodigoEncriptacion)) + 1;
      SET @SiguienteCaracterEnCodigoEncriptacion = MID(CodigoEncriptacion, @PosicionEnCodigoEncriptacion, 1);
      SET @SiguienteCaracterEnHileraXEncriptar = MID(HileraXEncriptar, @IndiceActual + 1, 1);
      SET @SiguienteCodigoEnHileraEncriptada = ORD(@SiguienteCaracterEnCodigoEncriptacion) + ORD(@SiguienteCaracterEnHileraXEncriptar);
      SET @SiguienteCodigoEnHileraEncriptada = MOD(@SiguienteCodigoEnHileraEncriptada, @MaximoNumeroCaracteresXCodificar);
      SET @SiguienteCaracterEnHileraEncriptada = CHAR(@SiguienteCodigoEnHileraEncriptada);
      SET HileraEncriptada = CONCAT(HileraEncriptada, @SiguienteCaracterEnHileraEncriptada);
      SET @IndiceActual = @IndiceActual + 1;
    END WHILE;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT HileraEncriptada;
  END IF;
END;

DELIMITER $$

CREATE PROCEDURE SonHilerasIdenticasBitXBit(IN HileraComparar1 VARCHAR(500), IN HileraComparar2 VARCHAR(500), OUT SonIguales BIT(1), IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET SonIguales = 1;
  
  IF CHAR_LENGTH(HileraComparar1) != CHAR_LENGTH(HileraComparar2) THEN
    SET SonIguales = 0;
  ELSE
    SET @IndiceActual = 1;
    
    WHILE SonIguales = 1 AND @IndiceActual <= CHAR_LENGTH(HileraComparar1) DO
      SET @SiguienteCaracterEnHilera1 = MID(HileraComparar1, @IndiceActual, 1);
      SET @SiguienteCaracterEnHilera2 = MID(HileraComparar2, @IndiceActual, 1);
      
      IF ORD(@SiguienteCaracterEnHilera1) != ORD(@SiguienteCaracterEnHilera2) THEN
          SET SonIguales = 0;
      END IF;
      
      SET @IndiceActual = @IndiceActual + 1;
    END WHILE;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT SonIguales;
  END IF;
END;

DELIMITER $$

CREATE PROCEDURE CambiarContrasena(IN UnIdUsuario INT, IN ContrasenaAnterior VARCHAR(500), IN NuevaContrasena VARCHAR(500), IN ConfirmacionNuevaContrasena VARCHAR(500), OUT NumError INT, IN CodigoEncriptacion VARCHAR(500), IN LongitudMinimaContrasena INT, IN CaracteresEspeciales VARCHAR(500), IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;

  SET NumError = 0;
  SET @IncrementosNumBaseError = 1000;
  SET @NumBaseError = @IncrementosNumBaseError;
  
  CALL Encriptar(ContrasenaAnterior, CodigoEncriptacion, @ContrasenaAnteriorEncriptada, 0);
  
  SELECT COUNT(1) FROM Usuarios WHERE IdUsuario = UnIdUsuario AND Contrasena = @ContrasenaAnteriorEncriptada INTO @CantidadUsuarios;
  
  IF @CantidadUsuarios != 1 THEN
    SET NumError = @NumBaseError + 1;
  ELSE
    SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;
    
    CALL SonHilerasIdenticasBitXBit(NuevaContrasena, ConfirmacionNuevaContrasena, @SonIguales, 0);
    
    IF @SonIguales = 0 THEN
      SET NumError = @NumBaseError + 1;
    ELSE
      SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;
      
      CALL ValidarContrasena(NuevaContrasena, NumError, LongitudMinimaContrasena, CaracteresEspeciales, 0);
      
      IF NumError != 0 THEN
        SET NumError = @NumBaseError + NumError;
      END IF;
    END IF;
  END IF;
  
  IF NumError = 0 THEN
    CALL Encriptar(NuevaContrasena, CodigoEncriptacion, @NuevaContrasenaEncriptada, 0);
    UPDATE Usuarios SET Contrasena = @NuevaContrasenaEncriptada WHERE IdUsuario = UnIdUsuario;
  END IF;

  IF RetornarResultadosEnSelect = 1 THEN
    SELECT NumError;
  END IF;

  COMMIT;
END;

DELIMITER $$

CREATE PROCEDURE ValidarLogin(IN UnUsuario VARCHAR(500), IN UnaContrasena VARCHAR(500), IN CodigoEncriptacion VARCHAR(500), OUT UsuarioContrasenaExiste BIT(1), OUT UnIdUsuario INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET UsuarioContrasenaExiste = 0;
  CALL Encriptar(UnaContrasena, CodigoEncriptacion, @UnaContrasenaEncriptada, 0);
  
  SELECT COUNT(1), MIN(IdUsuario) FROM Usuarios WHERE Usuario = UnUsuario AND Contrasena = @UnaContrasenaEncriptada INTO @CantidadUsuarios, UnIdUsuario;
  
  IF @CantidadUsuarios = 1 THEN
    SET UsuarioContrasenaExiste = 1;
  END IF;

  IF RetornarResultadosEnSelect = 1 THEN
    SELECT UsuarioContrasenaExiste, UnIdUsuario;
  END IF;
END;

DELIMITER $$

CREATE PROCEDURE IndexarCaracteresXPalabraSemejante(IN UnIdPalabraSemejante INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
  
  SET @ExistePalabraSemejante = 0;
  SELECT MIN(PalabraSemejante) FROM PalabrasSemejantes WHERE IdPalabraSemejante = UnIdPalabraSemejante INTO @PalabraSemejante;
    
  IF ISNULL(@PalabraSemejante) = 0 THEN
    SET @ExistePalabraSemejante = 1;
  END IF;
  
  IF @ExistePalabraSemejante = 1 THEN    
    DELETE FROM CaracteresXPalabraSemejante WHERE IdPalabraSemejante = UnIdPalabraSemejante;

    IF CHAR_LENGTH(@PalabraSemejante) = 0 THEN
      INSERT INTO CaracteresXPalabraSemejante(IdPalabraSemejante, Caracter) VALUES(UnIdPalabraSemejante, '');
    ELSE
      SET @IndiceActual = 1;
      SET @CaracteresInsertados = "";
      
      WHILE @IndiceActual <= CHAR_LENGTH(@PalabraSemejante) DO
        SET @SiguienteCaracter = MID(@PalabraSemejante, @IndiceActual, 1);
        
        IF INSTR(@CaracteresInsertados, @SiguienteCaracter) < 1 THEN
          INSERT INTO CaracteresXPalabraSemejante(IdPalabraSemejante, Caracter) VALUES(UnIdPalabraSemejante, @SiguienteCaracter);
          SET @CaracteresInsertados = CONCAT(@CaracteresInsertados, @SiguienteCaracter);
        END IF;
        
        SET @IndiceActual = @IndiceActual + 1;
      END WHILE;
    END IF;
  END IF;

  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdPalabraSemejante, a.PalabraSemejante, a.EstaLibre, b.Caracter
    FROM PalabrasSemejantes a, CaracteresXPalabraSemejante b
    WHERE a.IdPalabraSemejante = b.IdPalabraSemejante
    AND a.IdPalabraSemejante = UnIdPalabraSemejante;
  END IF;
        
  COMMIT;
END;

DELIMITER $$

CREATE PROCEDURE IndexarPalabraSemejante(IN UnaPalabraSemejante VARCHAR(500), IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
  
  SET @ExistePalabraSemejante = 1;
  SELECT MIN(IdPalabraSemejante) FROM PalabrasSemejantes WHERE PalabraSemejante = UnaPalabraSemejante INTO @IdPalabraSemejante;
  
  IF ISNULL(@IdPalabraSemejante) = 1 THEN
    SELECT MIN(IdPalabraSemejante) FROM PalabrasSemejantes WHERE EstaLibre = 1 INTO @IdPalabraSemejante;
  END IF;
  
  IF ISNULL(@IdPalabraSemejante) = 1 THEN
    SET @ExistePalabraSemejante = 0;
    SELECT MAX(IdPalabraSemejante) FROM PalabrasSemejantes INTO @IdPalabraSemejante;
      
    IF ISNULL(@IdPalabraSemejante) = 1 THEN
      SET @IdPalabraSemejante = 0;
    END IF;
    
    SET @IdPalabraSemejante = @IdPalabraSemejante + 1;
  END IF;
  
  IF @ExistePalabraSemejante = 0 THEN
    INSERT INTO PalabrasSemejantes(IdPalabraSemejante, PalabraSemejante, EstaLibre) VALUES(@IdPalabraSemejante, UnaPalabraSemejante, 0);
  ELSE
    UPDATE PalabrasSemejantes SET PalabraSemejante = UnaPalabraSemejante, EstaLibre = 0 WHERE IdPalabraSemejante = @IdPalabraSemejante;
  END IF;
    
  CALL IndexarCaracteresXPalabraSemejante(@IdPalabraSemejante, 0);
      
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdPalabraSemejante, a.PalabraSemejante, a.EstaLibre, b.Caracter
    FROM PalabrasSemejantes a, CaracteresXPalabraSemejante b
    WHERE a.IdPalabraSemejante = b.IdPalabraSemejante
    AND a.PalabraSemejante = UnaPalabraSemejante;
  END IF;
  
  COMMIT;
END;

DELIMITER $$

CREATE PROCEDURE LiberarPalabrasSemejantesNoUtilizadas()
BEGIN
  START TRANSACTION;
  
  UPDATE PalabrasSemejantes
  SET EstaLibre = 1
  WHERE NOT IdPalabraSemejante IN (SELECT IdPalabraSemejante FROM Palabras WHERE EstaLibre = 0);
  
  COMMIT;
END;

DELIMITER $$

CREATE PROCEDURE IndexarPalabra(IN UnaPalabra VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
  
  SET @ExistePalabra = 1;
  SELECT MIN(IdPalabra) FROM Palabras WHERE Palabra = UnaPalabra INTO @IdPalabra;
  
  IF ISNULL(@IdPalabra) = 1 THEN
    SELECT MIN(IdPalabra) FROM Palabras WHERE EstaLibre = 1 INTO @IdPalabra;
  END IF;
  
  IF ISNULL(@IdPalabra) = 1 THEN
    SET @ExistePalabra = 0;
    SELECT MAX(IdPalabra) FROM Palabras INTO @IdPalabra;
      
    IF ISNULL(@IdPalabra) = 1 THEN
      SET @IdPalabra = 0;
    END IF;
    
    SET @IdPalabra = @IdPalabra + 1;
  END IF;

  CALL DemePalabraSemejante(UnaPalabra, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, @PalabraSemejante, 0);
  CALL IndexarPalabraSemejante(@PalabraSemejante, 0);

  SELECT MIN(IdPalabraSemejante) FROM PalabrasSemejantes WHERE PalabraSemejante = @PalabraSemejante INTO @IdPalabraSemejante;

  IF @ExistePalabra = 0 THEN
    INSERT INTO Palabras(IdPalabra, Palabra, EstaLibre, IdPalabraSemejante) VALUES(@IdPalabra, UnaPalabra, 0, @IdPalabraSemejante);
  ELSE
    UPDATE Palabras SET Palabra = UnaPalabra, EstaLibre = 0, IdPalabraSemejante = @IdPalabraSemejante WHERE IdPalabra = @IdPalabra;
  END IF;
  
  CALL LiberarPalabrasSemejantesNoUtilizadas();

  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdPalabra, a.Palabra, a.EstaLibre, b.IdPalabraSemejante, b.PalabraSemejante, b.EstaLibre, c.Caracter
    FROM Palabras a, PalabrasSemejantes b, CaracteresXPalabraSemejante c
    WHERE a.IdPalabraSemejante = b.IdPalabraSemejante
    AND b.IdPalabraSemejante = c.IdPalabraSemejante
    AND a.Palabra = UnaPalabra;
  END IF;
  
  COMMIT;
END;

DELIMITER $$

CREATE PROCEDURE LiberarPalabrasNoUtilizadas()
BEGIN
  START TRANSACTION;
  
  UPDATE Palabras
  SET EstaLibre = 1
  WHERE NOT IdPalabra IN (SELECT IdPalabra FROM PalabrasXUsuario)
  AND NOT IdPalabra IN (SELECT IdPalabra FROM PalabrasXEstudiante);  
  COMMIT;
END;

DELIMITER $$
 
CREATE PROCEDURE IndexarUsuario(IN UnIdUsuario INT, IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
  
  DELETE FROM PalabrasXUsuario WHERE IdUsuario = UnIdUsuario;
  CALL LiberarPalabrasNoUtilizadas();
  
  SELECT COUNT(1) FROM Usuarios WHERE IdUsuario = UnIdUsuario INTO @CantidadUsuarios;
  
  IF (@CantidadUsuarios = 1) THEN
    SELECT LOWER(CONCAT(Usuario, SeparadorPalabras, Cedula, SeparadorPalabras, Nombre)) FROM Usuarios WHERE IdUsuario = UnIdUsuario GROUP BY Usuario, Cedula, Nombre INTO @PalabrasXIndexar;
  
    SET @PalabrasIndexadas = '';

    CALL DemeSiguientePalabra(@PalabrasXIndexar, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, TamanoMaximoPalabras, 0);
    
    WHILE CHAR_LENGTH(@SiguientePalabra) > 0 DO
      SET @SiguientePalabraXIndexarConSeparadoresPalabras = CONCAT(SeparadorPalabras, @SiguientePalabra, SeparadorPalabras);
      
      IF POSITION(@SiguientePalabraXIndexarConSeparadoresPalabras IN @PalabrasIndexadas) < 1 THEN
        CALL IndexarPalabra(@SiguientePalabra, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, 0);
        SELECT MIN(IdPalabra) FROM Palabras WHERE Palabra = @SiguientePalabra INTO @IdPalabra;
        INSERT INTO PalabrasXUsuario(IdUsuario, IdPalabra) VALUES(UnIdUsuario, @IdPalabra);
        SET @PalabrasIndexadas = CONCAT(@PalabrasIndexadas, @SiguientePalabraXIndexarConSeparadoresPalabras);
      END IF;

      CALL DemeSiguientePalabra(@PalabrasXIndexar, CaracteresValidos, @NuevoIndice, @SiguientePalabra, @NuevoIndice, TamanoMaximoPalabras, 0);
    END WHILE;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdUsuario, a.Usuario, a.Cedula, a.Nombre, c.IdPalabra, c.Palabra, c.EstaLibre, d.IdPalabraSemejante, d.PalabraSemejante, d.EstaLibre, e.Caracter
    FROM Usuarios a, PalabrasXUsuario b, Palabras c, PalabrasSemejantes d, CaracteresXPalabraSemejante e
    WHERE a.IdUsuario = b.IdUsuario
    AND b.IdPalabra = c.IdPalabra
    AND c.IdPalabraSemejante = d.IdPalabraSemejante
    AND d.IdPalabraSemejante = e.IdPalabraSemejante
    AND a.IdUsuario = UnIdUsuario;
  END IF;
  
  COMMIT;
END;

DELIMITER $$
 
CREATE PROCEDURE IndexarTodosUsuarios(IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
   
  CREATE TEMPORARY TABLE UsuariosXIndexar
  SELECT IdUsuario
  FROM Usuarios
  ORDER BY IdUsuario ASC;

  SELECT MIN(IdUsuario) FROM UsuariosXIndexar INTO @IdUsuario;
  
  WHILE ISNULL(@IdUsuario) = 0 DO
    CALL IndexarUsuario(@IdUsuario, CaracteresValidos, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, SeparadorPalabras, TamanoMaximoPalabras, 0);
    SELECT MIN(IdUsuario) FROM UsuariosXIndexar WHERE IdUsuario > @IdUsuario INTO @IdUsuario;
  END WHILE;
  
  DROP TEMPORARY TABLE UsuariosXIndexar;

  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdUsuario, a.Usuario, a.Cedula, a.Nombre, c.IdPalabra, c.Palabra, c.EstaLibre, d.IdPalabraSemejante, d.PalabraSemejante, d.EstaLibre, e.Caracter
    FROM Usuarios a, PalabrasXUsuario b, Palabras c, PalabrasSemejantes d, CaracteresXPalabraSemejante e
    WHERE a.IdUsuario = b.IdUsuario
    AND b.IdPalabra = c.IdPalabra
    AND c.IdPalabraSemejante = d.IdPalabraSemejante
    AND d.IdPalabraSemejante = e.IdPalabraSemejante;
  END IF;
  
  COMMIT; 
END;

DELIMITER $$
 
CREATE PROCEDURE ValidarCamposUsuario(IN UnUsuario VARCHAR(50), IN UnaCedula VARCHAR(100), IN UnNombre VARCHAR(100), IN CaracteresValidos VARCHAR(500), OUT NumError INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET NumError = 0;
  CALL DemeSiguientePalabra(UnUsuario, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, -1, 0);
  
  IF CHAR_LENGTH(@SiguientePalabra) = 0 OR CHAR_LENGTH(@SiguientePalabra) != CHAR_LENGTH(UnUsuario) THEN
    SET NumError = 1;
  ELSE
    CALL DemeSiguientePalabra(UnaCedula, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, -1, 0);

    IF CHAR_LENGTH(@SiguientePalabra) = 0 THEN
      SET NumError = 2;
    ELSE
      CALL DemeSiguientePalabra(UnNombre, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, -1, 0);

      IF CHAR_LENGTH(@SiguientePalabra) = 0 THEN
        SET NumError = 3;
      END IF;
    END IF;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT NumError;
  END IF;
END;

DELIMITER $$
 
CREATE PROCEDURE AltaUsuario(IN UnUsuario VARCHAR(50), IN UnaCedula VARCHAR(100), IN UnNombre VARCHAR(100), BitEsAdministrador BIT(1), IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
   
  SET @IncrementosNumBaseError = 1000;
  SET @NumBaseError = @IncrementosNumBaseError;

  SET @NumError = 0;
  SELECT MIN(IdUsuario) FROM Usuarios WHERE Usuario = UnUsuario INTO @IdUsuario;
  
  IF ISNULL(@IdUsuario) = 0 THEN
    SET @NumError = @NumBaseError + 1;
  ELSE
    SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;
    CALL ValidarCamposUsuario(UnUsuario, UnaCedula, UnNombre, CaracteresValidos, @NumError, 0);

    IF @NumError = 0 THEN
      SELECT MAX(IdUsuario) FROM Usuarios INTO @IdUsuario;
  
      IF ISNULL(@IdUsuario) = 1 THEN
        SET @IdUsuario = 0;
      END IF;
    
      SET @IdUsuario = @IdUsuario + 1;

      INSERT INTO Usuarios(IdUsuario, Usuario, Cedula, Nombre, Contrasena, EsAdministrador) VALUES(@IdUsuario, UnUsuario, UnaCedula, UnNombre, '', BitEsAdministrador);
      CALL IndexarUsuario(@IdUsuario, CaracteresValidos, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, SeparadorPalabras, TamanoMaximoPalabras, 0);
    ELSE
      SET @NumError = @NumBaseError + @NumError;
    END IF;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT @NumError, @IdUsuario;
  END IF;
  
  COMMIT; 
END;

DELIMITER $$
 
CREATE PROCEDURE CambioUsuario(IN UnIdUsuario INT, IN UnUsuario VARCHAR(50), IN UnaCedula VARCHAR(100), IN UnNombre VARCHAR(100), IN BitEsAdministrador BIT(1), BorrarContrasena BIT(1), IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;

  SET @IncrementosNumBaseError = 1000;
  SET @NumBaseError = @IncrementosNumBaseError;
   
  SET @NumError = 0;
  SELECT MIN(IdUsuario) FROM Usuarios WHERE IdUsuario <> UnIdUsuario AND Usuario = UnUsuario INTO @IdUsuario;
  
  IF ISNULL(@IdUsuario) = 0 THEN
    SET @NumError = @NumBaseError + 1;
  ELSE
    SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;

    SELECT MIN(IdUsuario) FROM Usuarios WHERE IdUsuario = UnIdUsuario INTO @IdUsuario;
    
    IF ISNULL(@IdUsuario) = 1 THEN
      SET @NumError = @NumBaseError + 1;
    ELSE
      SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;
      CALL ValidarCamposUsuario(UnUsuario, UnaCedula, UnNombre, CaracteresValidos, @NumError, 0);

      IF @NumError = 0 THEN
        UPDATE Usuarios SET Usuario = UnUsuario, Cedula = UnaCedula, Nombre = UnNombre, EsAdministrador = BitEsAdministrador WHERE IdUsuario = @IdUsuario;
      
        IF BorrarContrasena = 1 THEN
          UPDATE Usuarios SET Contrasena = '' WHERE IdUsuario = @IdUsuario;
        END IF;
      
        CALL IndexarUsuario(@IdUsuario, CaracteresValidos, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, SeparadorPalabras, TamanoMaximoPalabras, 0);
      ELSE
        SET @NumError = @NumBaseError + @NumError;
      END IF;
    END IF;    
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT @NumError;
  END IF;
  
  COMMIT; 
END;

DELIMITER $$
 
CREATE PROCEDURE IndexarEstudiante(IN UnIdEstudiante INT, IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
  
  DELETE FROM PalabrasXEstudiante WHERE IdEstudiante = UnIdEstudiante;
  CALL LiberarPalabrasNoUtilizadas();
  
  SELECT COUNT(1) FROM Estudiantes WHERE IdEstudiante = UnIdEstudiante INTO @CantidadEstudiantes;
  
  IF (@CantidadEstudiantes = 1) THEN
    SELECT LOWER(CONCAT(Cedula, SeparadorPalabras, Carne, SeparadorPalabras, Nombre)) FROM Estudiantes WHERE IdEstudiante = UnIdEstudiante GROUP BY Cedula, Carne, Nombre INTO @PalabrasXIndexar;
  
    SET @PalabrasIndexadas = '';

    CALL DemeSiguientePalabra(@PalabrasXIndexar, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, TamanoMaximoPalabras, 0);
    
    WHILE CHAR_LENGTH(@SiguientePalabra) > 0 DO
      SET @SiguientePalabraXIndexarConSeparadoresPalabras = CONCAT(SeparadorPalabras, @SiguientePalabra, SeparadorPalabras);
      
      IF POSITION(@SiguientePalabraXIndexarConSeparadoresPalabras IN @PalabrasIndexadas) < 1 THEN
        CALL IndexarPalabra(@SiguientePalabra, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, 0);
        SELECT MIN(IdPalabra) FROM Palabras WHERE Palabra = @SiguientePalabra INTO @IdPalabra;
        INSERT INTO PalabrasXEstudiante(IdEstudiante, IdPalabra) VALUES(UnIdEstudiante, @IdPalabra);
        SET @PalabrasIndexadas = CONCAT(@PalabrasIndexadas, @SiguientePalabraXIndexarConSeparadoresPalabras);
      END IF;

      CALL DemeSiguientePalabra(@PalabrasXIndexar, CaracteresValidos, @NuevoIndice, @SiguientePalabra, @NuevoIndice, TamanoMaximoPalabras, 0);
    END WHILE;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdEstudiante, a.Cedula, a.Carne, a.Nombre, c.IdPalabra, c.Palabra, c.EstaLibre, d.IdPalabraSemejante, d.PalabraSemejante, d.EstaLibre, e.Caracter
    FROM Estudiantes a, PalabrasXEstudiante b, Palabras c, PalabrasSemejantes d, CaracteresXPalabraSemejante e
    WHERE a.IdEstudiante = b.IdEstudiante
    AND b.IdPalabra = c.IdPalabra
    AND c.IdPalabraSemejante = d.IdPalabraSemejante
    AND d.IdPalabraSemejante = e.IdPalabraSemejante
    AND a.IdEstudiante = UnIdEstudiante;
  END IF;
  
  COMMIT;
END;

DELIMITER $$
 
CREATE PROCEDURE IndexarTodosEstudiantes(IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
   
  CREATE TEMPORARY TABLE EstudiantesXIndexar
  SELECT IdEstudiante
  FROM Estudiantes
  ORDER BY IdEstudiante ASC;

  SELECT MIN(IdEstudiante) FROM EstudiantesXIndexar INTO @IdEstudiante;
  
  WHILE ISNULL(@IdEstudiante) = 0 DO
    CALL IndexarEstudiante(@IdEstudiante, CaracteresValidos, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, SeparadorPalabras, TamanoMaximoPalabras, 0);
    SELECT MIN(IdEstudiante) FROM EstudiantesXIndexar WHERE IdEstudiante > @IdEstudiante INTO @IdEstudiante;
  END WHILE;
  
  DROP TEMPORARY TABLE EstudiantesXIndexar;

  IF RetornarResultadosEnSelect = 1 THEN
    SELECT a.IdEstudiante, a.Cedula, a.Carne, a.Nombre, c.IdPalabra, c.Palabra, c.EstaLibre, d.IdPalabraSemejante, d.PalabraSemejante, d.EstaLibre, e.Caracter
    FROM Estudiantes a, PalabrasXEstudiante b, Palabras c, PalabrasSemejantes d, CaracteresXPalabraSemejante e
    WHERE a.IdEstudiante = b.IdEstudiante
    AND b.IdPalabra = c.IdPalabra
    AND c.IdPalabraSemejante = d.IdPalabraSemejante
    AND d.IdPalabraSemejante = e.IdPalabraSemejante;
  END IF;
  
  COMMIT; 
END;

DELIMITER $$
 
CREATE PROCEDURE ValidarCamposEstudiante(IN UnaCedula VARCHAR(50), IN UnCarne VARCHAR(50), IN UnNombre VARCHAR(100), IN ValidarLongitudCarneMayorQue0 BIT(1), IN CaracteresValidos VARCHAR(500), OUT NumError INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  SET NumError = 0;
  CALL DemeSiguientePalabra(UnaCedula, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, -1, 0);
  
  IF CHAR_LENGTH(@SiguientePalabra) = 0 THEN
    SET NumError = 1;
  ELSE
    IF ValidarLongitudCarneMayorQue0 = 1 AND CHAR_LENGTH(UnCarne) = 0 THEN
      SET NumError = 2;
    ELSE
      CALL DemeSiguientePalabra(UnCarne, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, -1, 0);
      
      IF CHAR_LENGTH(UnCarne) > 0 AND CHAR_LENGTH(@SiguientePalabra) = 0 THEN
        SET NumError = 3;
      ELSE
        CALL DemeSiguientePalabra(UnNombre, CaracteresValidos, 1, @SiguientePalabra, @NuevoIndice, -1, 0);

        IF CHAR_LENGTH(@SiguientePalabra) = 0 THEN
          SET NumError = 4;
        END IF;
      END IF;
    END IF;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT NumError;
  END IF;
END;

DELIMITER $$
 
CREATE PROCEDURE AltaEstudiante(IN UnaCedula VARCHAR(50), IN UnCarne VARCHAR(50), IN UnNombre VARCHAR(100), IN CaracteresValidos VARCHAR(500), IN TuplasReemplazos VARCHAR(500), IN SeparadorTuplas VARCHAR(1), IN SeparadorColumnas VARCHAR(1), IN SeparadorPalabras VARCHAR(1), IN TamanoMaximoPalabras INT, IN RetornarResultadosEnSelect BIT(1))
BEGIN
  START TRANSACTION;
   
  SET @IncrementosNumBaseError = 1000;
  SET @NumBaseError = @IncrementosNumBaseError;
  
  SET @ValidarLongitudCarneMayorQue0 = 0;
  SET @NumError = 0;
  
  SELECT MIN(IdEstudiante) FROM Estudiantes WHERE Cedula = UnaCedula INTO @IdEstudiante;
  
  IF ISNULL(@IdEstudiante) = 0 THEN
    SET @NumError = @NumBaseError + 1;
  ELSE
    SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;    
    CALL ValidarCamposEstudiante(UnaCedula, UnCarne, UnNombre, @ValidarLongitudCarneMayorQue0, CaracteresValidos, @NumError, 0);

    IF @NumError = 0 THEN
      SET @NumBaseError = @NumBaseError + @IncrementosNumBaseError;
      SELECT MIN(IdEstudiante) FROM Estudiantes WHERE Carne = UnCarne INTO @IdEstudiante;
      
      IF CHAR_LENGTH(UnCarne) > 0 AND ISNULL(@IdEstudiante) = 0 THEN
        SET @NumError = @NumBaseError + 1;
      ELSE
        SELECT MAX(IdEstudiante) FROM Estudiantes INTO @IdEstudiante;
  
        IF ISNULL(@IdEstudiante) = 1 THEN
          SET @IdEstudiante = 0;
        END IF;
    
        SET @IdEstudiante = @IdEstudiante + 1;

        INSERT INTO Estudiantes(IdEstudiante, Cedula, Carne, Nombre) VALUES(@IdEstudiante, UnaCedula, UnCarne, UnNombre);
        CALL IndexarEstudiante(@IdEstudiante, CaracteresValidos, TuplasReemplazos, SeparadorTuplas, SeparadorColumnas, SeparadorPalabras, TamanoMaximoPalabras, 0);
      END IF;
    ELSE      
      SET @NumError = @NumBaseError + @NumError;
    END IF;
  END IF;
  
  IF RetornarResultadosEnSelect = 1 THEN
    SELECT @NumError, @ValidarLongitudCarneMayorQue0, @IdEstudiante;
  END IF;
  
  COMMIT; 
END;
