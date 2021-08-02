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
