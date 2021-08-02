-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema herowb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `herodev` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema fkhero
-- -----------------------------------------------------

USE `herodev` ;

-- -----------------------------------------------------
-- Table `herodev`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`departamento` (
  `idDepartamento` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreDpto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`area` (
  `idArea` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreArea` VARCHAR(45) NOT NULL,
  `idDepartamento` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idArea`),
  INDEX `idDepartamento` (`idDepartamento` ASC) ,
  CONSTRAINT `idDepartamento`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `herodev`.`departamento` (`idDepartamento`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`equipo` (
  `idEquipo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreEquipo` VARCHAR(45) NOT NULL,
  `codEquipo` VARCHAR(45) NOT NULL,
  `emailEquipo` VARCHAR(45) NULL DEFAULT NULL,
  `idArea` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idEquipo`),
  INDEX `idArea` (`idArea` ASC) ,
  CONSTRAINT `idArea`
    FOREIGN KEY (`idArea`)
    REFERENCES `herodev`.`area` (`idArea`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`puesto` (
  `idPuesto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombrePuesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPuesto`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`sede` (
  `idSede` INT(11) NOT NULL AUTO_INCREMENT,
  `codSede` CHAR(3) NOT NULL,
  `nombreSede` VARCHAR(45) NOT NULL,
  `calleSede` VARCHAR(45) NOT NULL,
  `numeroExtSede` VARCHAR(45) NOT NULL,
  `numeroIntSede` VARCHAR(45) NULL DEFAULT NULL,
  `coloniaSede` VARCHAR(45) NOT NULL,
  `codPostalSede` VARCHAR(45) NOT NULL,
  `ciudadSede` VARCHAR(30) NOT NULL,
  `estadoSede` VARCHAR(30) NOT NULL,
  `paisSede` VARCHAR(45) NOT NULL,
  `telefonoSede` CHAR(10) NOT NULL,
  `estado` CHAR(1) NOT NULL DEFAULT '1',
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idSede`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`colaborador` (
  `idColaborador` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreCol` VARCHAR(45) NOT NULL,
  `ApPaternoCol` VARCHAR(45) NOT NULL,
  `ApMaterno` VARCHAR(45) NULL DEFAULT NULL,
  `numServidor` VARCHAR(45) NOT NULL,
  `fechaNacCol` DATE NOT NULL,
  `emailCol` VARCHAR(45) NULL DEFAULT NULL,
  `linkComodato` VARCHAR(100) NULL DEFAULT NULL,
  `estadoCol` CHAR(1) NOT NULL DEFAULT '1',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `updated_at` DATETIME NULL DEFAULT NULL,
  `idSede` INT(11) NOT NULL,
  `idEquipo` INT(11) NULL DEFAULT NULL,
  `idPuesto` INT(11) NOT NULL,
  `celular` VARCHAR(10) NULL DEFAULT NULL,
  `shortel` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`idColaborador`),
  INDEX `idSede` (`idSede` ASC) ,
  INDEX `idEquipo` (`idEquipo` ASC) ,
  INDEX `idPuestoC` (`idPuesto` ASC) ,
  CONSTRAINT `idEquipo`
    FOREIGN KEY (`idEquipo`)
    REFERENCES `herodev`.`equipo` (`idEquipo`),
  CONSTRAINT `idPuestoC`
    FOREIGN KEY (`idPuesto`)
    REFERENCES `herodev`.`puesto` (`idPuesto`),
  CONSTRAINT `idSede`
    FOREIGN KEY (`idSede`)
    REFERENCES `herodev`.`sede` (`idSede`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`compra` (
  `idCompra` INT(11) NOT NULL AUTO_INCREMENT,
  `cantidadCompra` INT(11) NOT NULL,
  `totalCompra` FLOAT NOT NULL,
  `descripcionCompra` VARCHAR(255) NOT NULL,
  `facturaCompra` VARCHAR(45) NULL DEFAULT NULL,
  `fechaCompra` DATE NULL DEFAULT NULL,
  `fechaRegistroCompra` DATE NOT NULL,
  `fechaActualizacionCompra` DATE NULL DEFAULT NULL,
  `idCompradorCompra` INT(11) NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `idCompradorCompra` (`idCompradorCompra` ASC) ,
  CONSTRAINT `idCompradorCompra`
    FOREIGN KEY (`idCompradorCompra`)
    REFERENCES `herodev`.`colaborador` (`idColaborador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`marca` (
  `idMarca` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreMarca` VARCHAR(45) NOT NULL,
  `statusMarca` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`modelo` (
  `idModelo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreModelo` VARCHAR(45) NOT NULL,
  `idMarca` INT(11) NOT NULL,
  `status` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idModelo`),
  INDEX `idMarca` (`idMarca` ASC) ,
  CONSTRAINT `idMarca`
    FOREIGN KEY (`idMarca`)
    REFERENCES `herodev`.`marca` (`idMarca`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`tipodispositivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`tipodispositivo` (
  `idTipoDispositivo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoRecurso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDispositivo`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`dispositivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`dispositivo` (
  `idDispositivo` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcionDispositivo` VARCHAR(45) NULL DEFAULT NULL,
  `serieDispositivo` VARCHAR(45) NOT NULL,
  `procesadorDisposito` VARCHAR(45) NULL DEFAULT NULL,
  `memoriaDispositivo` VARCHAR(45) NULL DEFAULT NULL,
  `almacenamientoDispositivo` VARCHAR(45) NULL DEFAULT NULL,
  `resolucionDispositivo` VARCHAR(45) NULL DEFAULT NULL,
  `puertosVideo` VARCHAR(45) NULL DEFAULT NULL,
  `tipoDispositivo` INT(11) NOT NULL,
  `modeloDispositivo` INT(11) NOT NULL,
  `estadoFisico` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idDispositivo`),
  INDEX `tipoDispositivo` (`tipoDispositivo` ASC) ,
  INDEX `modeloDispositivo` (`modeloDispositivo` ASC) ,
  CONSTRAINT `Dispositivo_ibfk_1`
    FOREIGN KEY (`modeloDispositivo`)
    REFERENCES `herodev`.`modelo` (`idModelo`),
  CONSTRAINT `tipoDispositivo`
    FOREIGN KEY (`tipoDispositivo`)
    REFERENCES `herodev`.`tipodispositivo` (`idTipoDispositivo`))
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`dpto_sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`dpto_sede` (
  `idDpto_Sede` INT(11) NOT NULL AUTO_INCREMENT,
  `idDpto` INT(11) NOT NULL,
  `idSede` INT(11) NOT NULL,
  PRIMARY KEY (`idDpto_Sede`),
  INDEX `idDpto` (`idDpto` ASC) ,
  INDEX `idSede3` (`idSede` ASC) ,
  CONSTRAINT `idDpto`
    FOREIGN KEY (`idDpto`)
    REFERENCES `herodev`.`departamento` (`idDepartamento`),
  CONSTRAINT `idSede3`
    FOREIGN KEY (`idSede`)
    REFERENCES `herodev`.`sede` (`idSede`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`recurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`recurso` (
  `idRecurso` INT(11) NOT NULL AUTO_INCREMENT,
  `codigoServicioRecurso` VARCHAR(45) NULL DEFAULT NULL,
  `precioRecurso` VARCHAR(45) NULL DEFAULT NULL,
  `fechaRegistroRecurso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `stockRecurso` INT(11) NULL DEFAULT 1,
  `estadoRecurso` INT(11) NOT NULL,
  `idColaboradorActual` INT(11) NULL DEFAULT NULL,
  `idUsuarioGestion` INT(11) NOT NULL,
  `idSede` INT(11) NOT NULL,
  `idDispositivoR` INT(11) NOT NULL,
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idRecurso`),
  INDEX `idColaboradorActual` (`idColaboradorActual` ASC) ,
  INDEX `idUsuarioGestion` (`idUsuarioGestion` ASC) ,
  INDEX `idSede2` (`idSede` ASC) ,
  INDEX `idDispositivoR` (`idDispositivoR` ASC) ,
  CONSTRAINT `idColaboradorActual`
    FOREIGN KEY (`idColaboradorActual`)
    REFERENCES `herodev`.`colaborador` (`idColaborador`),
  CONSTRAINT `idDispositivoR`
    FOREIGN KEY (`idDispositivoR`)
    REFERENCES `herodev`.`dispositivo` (`idDispositivo`),
  CONSTRAINT `idSede2`
    FOREIGN KEY (`idSede`)
    REFERENCES `herodev`.`sede` (`idSede`),
  CONSTRAINT `idUsuarioGestion`
    FOREIGN KEY (`idUsuarioGestion`)
    REFERENCES `herodev`.`colaborador` (`idColaborador`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`recurso_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`recurso_compra` (
  `idrecurso_compra` INT(11) NOT NULL AUTO_INCREMENT,
  `idRecursoRC` INT(11) NOT NULL,
  `idCompraRC` INT(11) NOT NULL,
  PRIMARY KEY (`idrecurso_compra`),
  INDEX `idRecursoRC` (`idRecursoRC` ASC) ,
  INDEX `idCompraRC` (`idCompraRC` ASC) ,
  CONSTRAINT `idCompraRC`
    FOREIGN KEY (`idCompraRC`)
    REFERENCES `herodev`.`compra` (`idCompra`),
  CONSTRAINT `idRecursoRC`
    FOREIGN KEY (`idRecursoRC`)
    REFERENCES `herodev`.`recurso` (`idRecurso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`tipomovimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`tipomovimiento` (
  `idtipoMovimiento` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoMovimiento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipoMovimiento`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`recursomovimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`recursomovimiento` (
  `idRecursoMovimiento` INT(11) NOT NULL AUTO_INCREMENT,
  `idRecurso` INT(11) NOT NULL,
  `idColaboradorAnterior` INT(11) NOT NULL,
  `idColaboradorCambio` INT(11) NOT NULL,
  `recursoMovimientoFecha` DATE NULL DEFAULT NULL,
  `idUsuarioGestion` INT(11) NOT NULL,
  `idTipoMovimiento` INT(11) NOT NULL,
  `motivoRecusoMovimiento` TEXT NOT NULL,
  `notaRecusoMovimiento` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idRecursoMovimiento`),
  INDEX `idRecurso` (`idRecurso` ASC) ,
  INDEX `idColaboradorAnterior` (`idColaboradorAnterior` ASC) ,
  INDEX `idColaboradorCambio` (`idColaboradorCambio` ASC) ,
  INDEX `idUsuarioGestion2` (`idUsuarioGestion` ASC) ,
  INDEX `idTipoMovimiento` (`idTipoMovimiento` ASC) ,
  CONSTRAINT `idColaboradorAnterior`
    FOREIGN KEY (`idColaboradorAnterior`)
    REFERENCES `herodev`.`recurso` (`idColaboradorActual`),
  CONSTRAINT `idColaboradorCambio`
    FOREIGN KEY (`idColaboradorCambio`)
    REFERENCES `herodev`.`colaborador` (`idColaborador`),
  CONSTRAINT `idRecurso`
    FOREIGN KEY (`idRecurso`)
    REFERENCES `herodev`.`recurso` (`idRecurso`),
  CONSTRAINT `idTipoMovimiento`
    FOREIGN KEY (`idTipoMovimiento`)
    REFERENCES `herodev`.`tipomovimiento` (`idtipoMovimiento`),
  CONSTRAINT `idUsuarioGestion2`
    FOREIGN KEY (`idUsuarioGestion`)
    REFERENCES `herodev`.`colaborador` (`idColaborador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`tipousuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`tipousuario` (
  `idTipoUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `plataforma` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipoUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `herodev`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `herodev`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `passwordUsuario` TEXT NOT NULL,
  `idColaborador` INT(11) NOT NULL,
  `idTipoUsuario` INT(11) NOT NULL,
  PRIMARY KEY (`idUsuario`, `nombreUsuario`),
  INDEX `idColaboradorU` (`idColaborador` ASC) ,
  INDEX `idTipoUsuarioU` (`idTipoUsuario` ASC) ,
  CONSTRAINT `idColaboradorU`
    FOREIGN KEY (`idColaborador`)
    REFERENCES `herodev`.`colaborador` (`idColaborador`),
  CONSTRAINT `idTipoUsuarioU`
    FOREIGN KEY (`idTipoUsuario`)
    REFERENCES `herodev`.`tipousuario` (`idTipoUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `departamento` (`idDepartamento`, `nombreDpto`) VALUES
(1, 'Tecnologias de la informacion');

INSERT INTO `sede` (`idSede`, `codSede`, `nombreSede`, `calleSede`, `numeroExtSede`, `numeroIntSede`, `coloniaSede`, `codPostalSede`, `ciudadSede`, `estadoSede`, `paisSede`, `telefonoSede`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'TJ', 'Tijuana-Office', 'Bellas artes', '412321', '1234', 'Otay', '23145', 'Tijuana', 'Baja california', 'Mexico', '6643124561', '1', NULL, NULL),
(2, '3PL', '3PL Pacifico', 'pacifico', '123', '23', 'pacifico', '223112', 'Tijuana', 'Baja California', 'Mexico', '6572543426', '1', NULL, NULL),
(3, 'CJ', 'Ciudad juarez', 'cdj', 'dfasf', '3241', 'aasdfsaf', '123213', 'adfadsf', 'adfasdf', 'asdfasfd', '6647767733', '1', NULL, NULL),
(4, '', '', '', '', '', '', '', '', '', '', '', '1', NULL, NULL),
(5, '', '', '', '', '', '', '', '', '', '', '', '1', NULL, NULL),
(6, '', '', '', '', '', '', '', '', '', '', '', '1', NULL, NULL),
(7, '', '', '', '', '', '', '', '', '', '', '', '1', NULL, NULL);

INSERT INTO `dpto_sede` (`idDpto_Sede`, `idDpto`, `idSede`) VALUES
(1, 1, 1);


INSERT INTO `tipomovimiento` (`idtipoMovimiento`, `tipoMovimiento`) VALUES
(1, 'asignacion'),
(2, 'cambio'),
(3, 'revocado'),
(4, 'prestamo'),
(5, 'en espera');

INSERT INTO `tipodispositivo` (`idTipoDispositivo`, `nombreTipoRecurso`) VALUES
(1, 'laptop'),
(2, 'desktop'),
(3, 'monitor'),
(4, 'teclado'),
(5, 'mouse'),
(6, 'telefono'),
(7, 'Mac');

INSERT INTO `tipousuario` (`idTipoUsuario`, `plataforma`) VALUES
(1, 'Equipo'),
(2, 'globalization'),
(3, 'darwin'),
(4, 'rackspace'),
(5, 'google'),
(6, 'sap'),
(7, 'Monday');

INSERT INTO `equipo` (`idEquipo`, `nombreEquipo`, `codEquipo`, `emailEquipo`, `idArea`) VALUES
(1, 'DevTI', 'DT', 'DevTI@g-global.com', 1),
(2, 'TI', 'TI', 'ti@g-global.com', 1);


INSERT INTO `marca` (`idMarca`, `nombreMarca`, `statusMarca`) VALUES
(1, 'delltest', 0),
(2, 'asus', 0),
(3, 'vorago2', 1),
(4, 'benq', 1),
(5, 'acer', 0),
(6, 'samsung', 0),
(7, 'Marca Test', 1),
(8, 'Hikvision', 1),
(9, 'test', 0),
(10, '', 0),
(11, 'NewRuta', 1),
(12, 'newRuta1', 1),
(13, 'newTest', 1),
(14, 'test', 1),
(15, '2', 1),
(16, 'marca', 1),
(17, 'PruebaMarca', 1),
(18, '22', 1),
(19, '2', 0),
(20, 'marca', 1),
(21, 'test2', 1),
(22, '2321321', 1),
(23, '213213', 1),
(24, '213213', 1);


INSERT INTO `modelo` (`idModelo`, `nombreModelo`, `idMarca`, `status`) VALUES
(1, 'TEEEEEEEEEEEST', 2, 1),
(2, 'GW2780', 2, 1),
(3, 'LED-W19-204', 1, 1),
(4, 'VA27EHE', 3, 1),
(5, 'G27C5', 2, 1),
(6, 'AS3241', 3, 1),
(7, 'afasdfaf', 1, 1),
(8, 'AZ1K', 4, 1),
(9, 'Modelo Test', 1, 1),
(10, 'modeloTest2', 3, 1);

INSERT INTO `puesto` (`idPuesto`, `nombrePuesto`) VALUES
(1, 'especialista'),
(2, 'coach'),
(3, 'coach g');

INSERT INTO `colaborador` (`idColaborador`, `nombreCol`, `ApPaternoCol`, `ApMaterno`, `numServidor`, `fechaNacCol`, `emailCol`, `linkComodato`, `estadoCol`, `created_at`, `updated_at`, `idSede`, `idEquipo`, `idPuesto`, `celular`, `shortel`) VALUES
(1, 'Juan', 'Vazquez', 'Jocobi', '100779', '2001-02-05', 'alexander.vazquez@g-global.com', 'https://drive.google.com/file/d/1-SJcsN0vqcB4Xovo3RPoBoIrnlsn7UzG/view?usp=sharing', '0', '2021-07-08 21:59:18', '2021-07-07 19:42:22', 1, 1, 2, '6645472727', '123'),
(2, 'Ileana', 'Verduzco', 'Escalera', '100315', '2001-02-05', 'ileana.verduzco@g-global.com', 'https://drive.google.com/file/d/1dN2McKy7nCtbAIP9MA9EtwX2LFlhZwM6/view?usp=sharing', '1', '2021-07-08 21:59:18', '2021-06-15 19:53:08', 1, 2, 2, NULL, NULL),
(3, 'Yobani', 'Vital', NULL, '100719', '1990-06-15', 'yobani.vital@g-global.com', 'https://drive.google.com/drive/u/0/folders/1BPx1HNyBVzJ7Ke9CMuS7mKEvX4VL3Bpe', '1', '2021-07-08 21:59:18', NULL, 1, 2, 1, NULL, NULL),
(4, 'yhovan', 'bojorquez', NULL, '100999', '1990-06-15', 'yhovan.borjorquez@g-global.com', 'https://drive.google.com/drive/u/0/folders/1BPx1HNyBVzJ7Ke9CMuS7mKEvX4VL3Bpe', '1', '2021-07-08 21:59:18', '2021-06-24 02:36:51', 1, 2, 1, NULL, NULL),
(5, 'uziel', 'Estrada', NULL, '100876', '1990-02-15', 'uziel.estrada@g-global.com', 'https://drive.google.com/drive/u/0/folders/1BPx1HNyBVzJ7Ke9CMuS7mKEvX4VL3Bpe', '1', '2021-07-08 21:59:18', NULL, 1, 1, 1, NULL, NULL),
(6, 'roman', 'tercero', NULL, '100546', '1999-06-15', 'roman.tercero@g-global.com', 'https://drive.google.com/drive/u/0/folders/1BPx1HNyBVzJ7Ke9CMuS7mKEvX4VL3Bpe', '1', '2021-07-08 21:59:18', NULL, 1, 1, 1, NULL, NULL),
(7, 'uziel', 'estrada', 'marin', '1000782', '2021-03-03', 'uziel.estrada@g-global.com', 'https://drive.google.com/file/d/199rfFgrUKa-QJ16b3D7iCgsWSeQk7AK2/view?usp=sharing', '1', '2021-07-08 21:59:18', NULL, 1, 1, 2, '6645472727', '123'),
(8, 'uziel', 'estrada', 'marin', '1000782', '2021-03-03', 'uziel.estrada@g-global.com', 'https://drive.google.com/file/d/199rfFgrUKa-QJ16b3D7iCgsWSeQk7AK2/view?usp=sharing', '1', '2021-07-08 21:59:18', NULL, 1, 1, 2, '6645472727', ''),
(9, 'Jessica', 'Rivera', 'Lopez', '100789', '2000-02-02', 'jessica.beltran@g-global.com', 'https://drive.google.com/file/d/1BtvUcPP0Gp3TR9ANajlwdqZ1Fh2_NiZx/view', '1', '2021-07-15 10:00:10', NULL, 1, 1, 1, '6647767636', '786'),
(10, 'pruebaMerge', 'merge', 'merge', '100000', '2000-02-01', 'merge@g-global.com', 'https://drive.google.com/file/d/1BtvUcPP0Gp3TR9ANajlwdqZ1Fh2_NiZx/view', '1', '2021-07-15 10:09:31', NULL, 1, 1, 2, '6647717711', '829'),
(11, 'Yobani', 'Vital', 'García', '100719', '1998-03-10', 'yobani.vital@g-global.com', '', '1', '2021-07-15 13:27:11', NULL, 1, 1, 2, '', '124'),
(12, 'Yhovan', 'Bojorquez', 'Lopez', '100722', '2000-10-10', 'yhovan.bojorquez@g-global.com', '', '1', '2021-07-16 09:06:40', NULL, 1, 2, 3, '(664) 134-', '');

INSERT INTO `usuario` (`idUsuario`, `nombreUsuario`, `passwordUsuario`, `idColaborador`, `idTipoUsuario`) VALUES
(1, 'avazquez', 'central.ti', 1, 1),
(2, 'iverduzco', 'ileana123', 2, 6),
(3, 'avazquez', 'Central.TI', 1, 6),
(4, 'avazquez', 'Central.TI', 1, 4),
(5, 'seck', '123', 1, 2),
(6, 'seck', '123', 1, 5),
(7, 'seck', '123', 1, 3),
(8, 'AJocobi1', '12345', 1, 7),
(9, 'vtal', 'vital02', 3, 1),
(10, 'vital', 'vital02', 3, 2),
(11, 'iverduzco', '213213', 2, 7);


INSERT INTO `area` (`idArea`, `nombreArea`, `idDepartamento`) VALUES
(1, 'TI', 1);