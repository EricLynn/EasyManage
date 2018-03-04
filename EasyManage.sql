-- MySQL Script generated by MySQL Workbench
-- Sat Mar  3 18:54:46 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema EasyManage
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EasyManage
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EasyManage` DEFAULT CHARACTER SET utf8 ;
USE `EasyManage` ;

-- -----------------------------------------------------
-- Table `EasyManage`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(64) NULL,
  `password_hash_value` CHAR(64) NULL,
  `access` INT NOT NULL,
  `google_client_id` VARCHAR(45) NULL,
  `d_type` VARCHAR(10) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`organization` (
  `organization_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `organization_name` VARCHAR(256) NULL,
  PRIMARY KEY (`organization_id`),
  UNIQUE INDEX `organization_id_UNIQUE` (`organization_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `organization_id` INT NOT NULL,
  `first_name` VARCHAR(64) NULL,
  `last_name` VARCHAR(64) NULL,
  `posistion` VARCHAR(256) NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC),
  INDEX `organization_id_idx` (`organization_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `organization_id` INT NOT NULL,
  `name` VARCHAR(256) NULL,
  `company_name` VARCHAR(256) NULL,
  `d_type` VARCHAR(16) NULL,
  UNIQUE INDEX `contact_id_UNIQUE` (`contact_id` ASC),
  PRIMARY KEY (`contact_id`),
  INDEX `organization_id_idx` (`organization_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(80) NULL,
  `zipcode` VARCHAR(20) NULL,
  `city` VARCHAR(64) NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`phone_number` (
  `phone_number_id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(20) NULL,
  `type` VARCHAR(15) NULL,
  PRIMARY KEY (`phone_number_id`),
  UNIQUE INDEX `phone_number_id_UNIQUE` (`phone_number_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`email` (
  `email_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE INDEX `email_id_UNIQUE` (`email_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`employee_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`employee_address` (
  `employee_address_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `Priority` INT(10) NULL,
  PRIMARY KEY (`employee_address_id`),
  UNIQUE INDEX `employee_address_id_UNIQUE` (`employee_address_id` ASC),
  INDEX `address_id_idx` (`address_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`employee_phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`employee_phone_number` (
  `employee_phone_number_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `phone_number_id` INT NOT NULL,
  `priority` INT(10) NULL,
  PRIMARY KEY (`employee_phone_number_id`),
  UNIQUE INDEX `employee_phone_number_id_UNIQUE` (`employee_phone_number_id` ASC),
  INDEX `employee_id_idx` (`employee_id` ASC),
  INDEX `phone_number_id_idx` (`phone_number_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`employee_email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`employee_email` (
  `employee_email_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `email_id` INT NOT NULL,
  `priority` INT(10) NULL,
  PRIMARY KEY (`employee_email_id`),
  UNIQUE INDEX `employee_email_id_UNIQUE` (`employee_email_id` ASC),
  INDEX `employee_id_idx` (`employee_id` ASC),
  INDEX `email_id_idx` (`email_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contact_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contact_address` (
  `contact_address_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `priority` INT(10) NULL,
  PRIMARY KEY (`contact_address_id`),
  UNIQUE INDEX `idcontact_address_id_UNIQUE` (`contact_address_id` ASC),
  INDEX `contact_id_idx` (`contact_id` ASC),
  INDEX `address_id_idx` (`address_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contact_phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contact_phone_number` (
  `contact_phone_number_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id` INT NOT NULL,
  `phone_number_id` INT NOT NULL,
  `priority` INT(10) NULL,
  PRIMARY KEY (`contact_phone_number_id`),
  UNIQUE INDEX `contact_phone_number_id_UNIQUE` (`contact_phone_number_id` ASC),
  INDEX `contact_id_idx` (`contact_id` ASC),
  INDEX `phone_number_id_idx` (`phone_number_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contact_email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contact_email` (
  `contact_email_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id` INT NOT NULL,
  `email_id` INT NOT NULL,
  `priority` INT(10) NULL,
  PRIMARY KEY (`contact_email_id`),
  UNIQUE INDEX `contact_email_id_UNIQUE` (`contact_email_id` ASC),
  INDEX `contact_id_idx` (`contact_id` ASC),
  INDEX `email_id_idx` (`email_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`entry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`entry` (
  `entry_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `organization_id` INT NOT NULL,
  `title` VARCHAR(75) NULL,
  `date_created` DATE NULL,
  `description` VARCHAR(4096) NULL,
  `d_type` VARCHAR(20) NULL,
  PRIMARY KEY (`entry_id`),
  UNIQUE INDEX `entry_id_UNIQUE` (`entry_id` ASC),
  INDEX `employee_id_idx` (`employee_id` ASC),
  INDEX `organization_id_idx` (`organization_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`work_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`work_order` (
  `work_order_id` INT NOT NULL AUTO_INCREMENT,
  `entry_id` INT NOT NULL,
  `status` VARCHAR(64) NULL,
  `completion_date` DATE NULL,
  PRIMARY KEY (`work_order_id`),
  UNIQUE INDEX `work_order_id_UNIQUE` (`work_order_id` ASC),
  INDEX `entry_id_idx` (`entry_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`purchase_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`purchase_order` (
  `purchase_order_id` INT NOT NULL AUTO_INCREMENT,
  `entry_id` INT NOT NULL,
  `status` VARCHAR(64) NULL,
  `purchase_ordercol` VARCHAR(45) NULL,
  PRIMARY KEY (`purchase_order_id`),
  UNIQUE INDEX `purchase_order_id_UNIQUE` (`purchase_order_id` ASC),
  INDEX `entry_id_idx` (`entry_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`supplier` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id` INT NOT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `supplier_id_UNIQUE` (`supplier_id` ASC),
  INDEX `contact_id_idx` (`contact_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contractor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contractor` (
  `contractor_id` INT NOT NULL AUTO_INCREMENT,
  `contact_id` INT NOT NULL,
  PRIMARY KEY (`contractor_id`),
  UNIQUE INDEX `contractor_id_UNIQUE` (`contractor_id` ASC),
  INDEX `contact_id_idx` (`contact_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`pdf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`pdf` (
  `pdf_id` INT NOT NULL AUTO_INCREMENT,
  `entry_id` INT NOT NULL,
  `pdf` BLOB NULL,
  PRIMARY KEY (`pdf_id`),
  UNIQUE INDEX `pdf_id_UNIQUE` (`pdf_id` ASC),
  INDEX `entry_id_idx` (`entry_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`supplies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`supplies` (
  `supplies_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `purchase_order_id` INT NOT NULL,
  `arrival_date` DATE NULL,
  PRIMARY KEY (`supplies_id`),
  UNIQUE INDEX `supplies_id_UNIQUE` (`supplies_id` ASC),
  INDEX `supplier_id_idx` (`supplier_id` ASC),
  INDEX `purchase_order_id_idx` (`purchase_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`items_supplied`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`items_supplied` (
  `items_supplied_id` INT NOT NULL AUTO_INCREMENT,
  `supplies_id` INT NOT NULL,
  `item_name` VARCHAR(256) NULL,
  `price` INT NULL,
  `currency_type` VARCHAR(20) NULL,
  `number_of_items_sold` INT NULL,
  PRIMARY KEY (`items_supplied_id`),
  UNIQUE INDEX `items_supplied_id_UNIQUE` (`items_supplied_id` ASC),
  INDEX `supplies_id_idx` (`supplies_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`in_house_performs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`in_house_performs` (
  `in_house_performs_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `work_order_id` INT NOT NULL,
  `hours_worked` INT NULL,
  `pay_rate` INT NULL,
  `currency_type` VARCHAR(20) NULL,
  PRIMARY KEY (`in_house_performs_id`),
  UNIQUE INDEX `in_house_performs_id_UNIQUE` (`in_house_performs_id` ASC),
  INDEX `employee_id_idx` (`employee_id` ASC),
  INDEX `work_order_id_idx` (`work_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`out_of_house_performs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`out_of_house_performs` (
  `out_of_house_performs_id` INT NOT NULL AUTO_INCREMENT,
  `contractor_id` INT NOT NULL,
  `work_order_id` INT NOT NULL,
  `cost` INT NULL,
  `currency_type` VARCHAR(20) NULL,
  PRIMARY KEY (`out_of_house_performs_id`),
  UNIQUE INDEX `out_of_house_performs_id_UNIQUE` (`out_of_house_performs_id` ASC),
  INDEX `contractor_id_idx` (`contractor_id` ASC),
  INDEX `work_order_id_idx` (`work_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`employee_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`employee_user` (
  `employee_user_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_user_id`),
  UNIQUE INDEX `employee_user_id_UNIQUE` (`employee_user_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `employee_id_idx` (`employee_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`entry_modification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`entry_modification` (
  `entry_modification_id` INT NOT NULL AUTO_INCREMENT,
  `employee_user_id` INT NOT NULL,
  `entry_id` INT NOT NULL,
  `time_stamp` DATETIME NULL,
  PRIMARY KEY (`entry_modification_id`),
  UNIQUE INDEX `entry_modification_id_UNIQUE` (`entry_modification_id` ASC),
  INDEX `employee_user_id_idx` (`employee_user_id` ASC),
  INDEX `entry_id_idx` (`entry_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contact_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contact_user` (
  `contact_user_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  PRIMARY KEY (`contact_user_id`),
  UNIQUE INDEX `contact_user_id_UNIQUE` (`contact_user_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `contact_id_idx` (`contact_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`type_of_supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`type_of_supplier` (
  `type_of_supplier_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_type` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`type_of_supplier_id`),
  UNIQUE INDEX `type_of_supplier_id_UNIQUE` (`type_of_supplier_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`supplier_to_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`supplier_to_type` (
  `supplier_to_type_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `type_of_supplier_id` INT NOT NULL,
  PRIMARY KEY (`supplier_to_type_id`),
  UNIQUE INDEX `supplier_to_type_id_UNIQUE` (`supplier_to_type_id` ASC),
  INDEX `supplier_id_idx` (`supplier_id` ASC, `type_of_supplier_id` ASC),
  INDEX `type_of_supplier_id_idx` (`type_of_supplier_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`type_of_contractor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`type_of_contractor` (
  `type_of_contractor_id` INT NOT NULL AUTO_INCREMENT,
  `contractor_type` VARCHAR(64) NULL,
  PRIMARY KEY (`type_of_contractor_id`),
  UNIQUE INDEX `type_of_contractor_id_UNIQUE` (`type_of_contractor_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EasyManage`.`contractor_to_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`contractor_to_type` (
  `contractor_to_type_id` INT NOT NULL AUTO_INCREMENT,
  `contractor_id` INT NOT NULL,
  `type_of_contractor_id` INT NOT NULL,
  PRIMARY KEY (`contractor_to_type_id`),
  UNIQUE INDEX `contractor_to_type_id_UNIQUE` (`contractor_to_type_id` ASC),
  INDEX `contractor_id_idx` (`contractor_id` ASC),
  INDEX `type_of_contractor_id_idx` (`type_of_contractor_id` ASC))
ENGINE = InnoDB;

USE `EasyManage` ;

-- -----------------------------------------------------
-- Placeholder table for view `EasyManage`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EasyManage`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `EasyManage`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EasyManage`.`view1`;
USE `EasyManage`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
