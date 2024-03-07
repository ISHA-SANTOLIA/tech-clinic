-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `Item_num` INT NOT NULL,
  `Customer_num` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `Unit` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Item_num`, `Customer_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `Item_num` INT NOT NULL,
  `Item_type` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `Vendor` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  `Customer_Item_num` INT NOT NULL,
  `Customer_Customer_num` INT NOT NULL,
  PRIMARY KEY (`Item_num`),
  INDEX `fk_Item_Customer1_idx` (`Customer_Item_num` ASC, `Customer_Customer_num` ASC) VISIBLE,
  CONSTRAINT `fk_Item_Customer1`
    FOREIGN KEY (`Customer_Item_num` , `Customer_Customer_num`)
    REFERENCES `mydb`.`Customer` (`Item_num` , `Customer_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Details` (
  `Item_num` INT NOT NULL,
  `Quantity_on_hand` INT NOT NULL,
  `cost` INT NOT NULL,
  `price` INT NOT NULL,
  `purchase_date` DATE NOT NULL,
  `date_sold` DATE NOT NULL,
  PRIMARY KEY (`Item_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Items` (
  `Item_num` INT NOT NULL,
  `Details_Item_num` INT NOT NULL,
  PRIMARY KEY (`Item_num`),
  INDEX `fk_Item_has_Item_Item1_idx` (`Item_num` ASC) VISIBLE,
  INDEX `fk_Items_Details1_idx` (`Details_Item_num` ASC) VISIBLE,
  CONSTRAINT `fk_Item_has_Item_Item1`
    FOREIGN KEY (`Item_num`)
    REFERENCES `mydb`.`Item` (`Item_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Items_Details1`
    FOREIGN KEY (`Details_Item_num`)
    REFERENCES `mydb`.`Details` (`Item_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
