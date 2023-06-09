-- MySQL Script generated by MySQL Workbench
-- Mon May 15 19:45:06 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizza
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza` DEFAULT CHARACTER SET utf8mb4 ;
USE `pizza` ;

-- -----------------------------------------------------
-- Table `pizza`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`cliente` (
  `idcliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido1` VARCHAR(25) NOT NULL,
  `apellido2` VARCHAR(25) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `codigo_postal` INT(5) NOT NULL,
  `localidad` VARCHAR(65) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `numero_telefono` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`tienda` (
  `idtienda` INT(11) NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(125) NOT NULL,
  `cp` INT(5) NOT NULL,
  `localidad` VARCHAR(75) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtienda`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`empleado` (
  `idempleado` INT(11) NOT NULL AUTO_INCREMENT,
  `apellido1` VARCHAR(25) NOT NULL,
  `apellido2` VARCHAR(25) NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(12) NULL DEFAULT NULL,
  `tipo` ENUM('cocinero', 'repartidor') NOT NULL,
  `tienda_idtienda` INT(11) NOT NULL,
  PRIMARY KEY (`idempleado`, `tienda_idtienda`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_empleado_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizza`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`pedidos` (
  `idpedidos` INT(11) NOT NULL AUTO_INCREMENT,
  `pedido` ENUM('domicilio', 'tienda') NOT NULL,
  `date` DATE NOT NULL,
  `precio` DOUBLE UNSIGNED ZEROFILL NOT NULL,
  `idcliente` INT(11) NOT NULL,
  `iditenda` INT(11) NOT NULL,
  `idempleado` INT(11) NOT NULL,
  PRIMARY KEY (`idpedidos`, `idcliente`),
  INDEX `fk_id_tienda_idx` (`iditenda` ASC) VISIBLE,
  INDEX `fk_id_empleado_idx` (`idempleado` ASC) VISIBLE,
  INDEX `fk_id_cliente_idx` (`idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_id_cliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `pizza`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_empleado`
    FOREIGN KEY (`idempleado`)
    REFERENCES `pizza`.`empleado` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_tienda`
    FOREIGN KEY (`iditenda`)
    REFERENCES `pizza`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`cantidad_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`cantidad_pedidos` (
  `idcantidad_pedidos` INT(11) NOT NULL AUTO_INCREMENT,
  `cantidad_pedidos` INT(11) NULL DEFAULT NULL,
  `cant_idpedidos` INT(11) NOT NULL,
  PRIMARY KEY (`idcantidad_pedidos`),
  INDEX `fk_id_pedidos_idx` (`cant_idpedidos` ASC) VISIBLE,
  CONSTRAINT `fk_id_pedidos`
    FOREIGN KEY (`cant_idpedidos`)
    REFERENCES `pizza`.`pedidos` (`idpedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`categoria` (
  `idcategoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`producto` (
  `idproducto` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  `img` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DOUBLE NOT NULL,
  `producto_id_pedido` INT(11) NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_producto_id_pedido_idx` (`producto_id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_producto_id_pedido`
    FOREIGN KEY (`producto_id_pedido`)
    REFERENCES `pizza`.`pedidos` (`idpedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizza`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`pizza` (
  `idpizza` INT(11) NOT NULL AUTO_INCREMENT,
  `tamaño` ENUM('mediana', 'familiar') NOT NULL,
  `idcategoria` INT(11) NOT NULL,
  `idproducto` INT(11) NOT NULL,
  PRIMARY KEY (`idpizza`),
  INDEX `fk_id_categoria_idx` (`idcategoria` ASC) VISIBLE,
  INDEX `fk_id_producto_idx` (`idproducto` ASC) VISIBLE,
  CONSTRAINT `fk_id_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `pizza`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `pizza`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
