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
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `DataNascimento` DATE NULL,
  `Genero` VARCHAR(40) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `Categoria` VARCHAR(3) NOT NULL,
  `Kilometragem` INT NOT NULL,
  `TipoCombustivel` VARCHAR(45) NOT NULL,
  `DataProximaInspecao` DATE NOT NULL,
  `EstadoOperacional` TINYINT NOT NULL DEFAULT 1,
  `IUC` DOUBLE NOT NULL,
  `Matricula` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idVeiculo`));


-- -----------------------------------------------------
-- Table `mydb`.`Percurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Percurso` (
  `idpercurso` INT NOT NULL,
  `HoraChegada` DATETIME NOT NULL DEFAULT "1000-01-01",
  `HoraPartida` DATETIME NOT NULL,
  `DistanciaTotal` DOUBLE NOT NULL DEFAULT 0.0,
  `Veiculo_idVeiculo` INT NOT NULL,
  PRIMARY KEY (`idpercurso`),
  INDEX `fk_Percurso_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_Percurso_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Designacao` VARCHAR(30) NOT NULL,
  `Contribuinte` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `idEndereco` INT NOT NULL,
  `NumeroPorta` INT NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `CodPostal` VARCHAR(45) NOT NULL,
  `Fornecedor_idFornecedor` INT NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `fk_Endereco_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Encomenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Encomenda` (
  `idEncomenda` INT NOT NULL,
  `CustoTotal` DOUBLE NOT NULL DEFAULT 0.0,
  `EstadoPagamento` TINYINT NOT NULL DEFAULT 0,
  `DataRegisto` DATETIME NOT NULL,
  `EstadoEntrega` TINYINT NOT NULL DEFAULT 0,
  `DistanciaParcial` DOUBLE NOT NULL DEFAULT 0.0,
  `HoraEntrega` DATETIME NOT NULL DEFAULT "1000-01-01 00:00",
  `HoraPrevista` DATETIME NOT NULL DEFAULT "1000-01-01 00:00",
  `HoraEnvio` DATETIME NOT NULL DEFAULT "1000-01-01 00:00",
  `Percurso_idpercurso` INT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  PRIMARY KEY (`idEncomenda`),
  INDEX `fk_Encomenda_Percurso1_idx` (`Percurso_idpercurso` ASC) VISIBLE,
  INDEX `fk_Encomenda_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Encomenda_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Encomenda_Percurso1`
    FOREIGN KEY (`Percurso_idpercurso`)
    REFERENCES `mydb`.`Percurso` (`idpercurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Encomenda_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Encomenda_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `idFuncionario` INT NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  `Salario` DOUBLE NOT NULL,
  `HabilitacaoAuto` VARCHAR(3) NULL,
  `DataEntrada` DATE NOT NULL,
  `DataExpiracaoHabilitacao` DATE NULL,
  `Posicao` VARCHAR(20) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  PRIMARY KEY (`idFuncionario`));


-- -----------------------------------------------------
-- Table `mydb`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Compra` (
  `idCompra` INT NOT NULL,
  `CustoTotal` DOUBLE NOT NULL DEFAULT 0.0,
  `DataEmissao` DATETIME NOT NULL,
  `DataEntrega` DATETIME NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `fk_Compra_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `idItem` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Imposto` DOUBLE NOT NULL,
  `Descricao` VARCHAR(255) NOT NULL,
  `Custo` DOUBLE NOT NULL,
  `Quantidade` INT NOT NULL default 0,
  `Comparticipacao` DOUBLE NOT NULL,
  PRIMARY KEY (`idItem`));


-- -----------------------------------------------------
-- Table `mydb`.`EncomendaItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EncomendaItem` (
  `ValidacaoMedica` TINYINT NULL DEFAULT NULL,
  `Quantidade` INT NOT NULL,
  `CustoParcial` DOUBLE NOT NULL,
  `Item_idItem` INT NOT NULL,
  `Encomenda_idEncomenda` INT NOT NULL,
  PRIMARY KEY (`Item_idItem`, `Encomenda_idEncomenda`),
  INDEX `fk_EncomendaItem_Item1_idx` (`Item_idItem` ASC) VISIBLE,
  INDEX `fk_EncomendaItem_Encomenda1_idx` (`Encomenda_idEncomenda` ASC) VISIBLE,
  CONSTRAINT `fk_EncomendaItem_Item1`
    FOREIGN KEY (`Item_idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EncomendaItem_Encomenda1`
    FOREIGN KEY (`Encomenda_idEncomenda`)
    REFERENCES `mydb`.`Encomenda` (`idEncomenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`ItemCompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ItemCompra` (
  `PrazoDeValidade` DATE NULL,
  `CustoParcial` DOUBLE NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 0,
  `Disponiveis` INT NOT NULL DEFAULT 0,
  `Item_idItem` INT NOT NULL,
  `Compra_idCompra` INT NOT NULL,
  PRIMARY KEY (`Item_idItem`, `Compra_idCompra`),
  INDEX `fk_ItemCompra_Item_idx` (`Item_idItem` ASC) VISIBLE,
  INDEX `fk_ItemCompra_Compra1_idx` (`Compra_idCompra` ASC) VISIBLE,
  CONSTRAINT `fk_ItemCompra_Item`
    FOREIGN KEY (`Item_idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItemCompra_Compra1`
    FOREIGN KEY (`Compra_idCompra`)
    REFERENCES `mydb`.`Compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`TiposConservacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TiposConservacao` (
  `idTiposConservacao` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idTiposConservacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ItemTipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ItemTipo` (
  `TiposConservacao_idTiposConservacao` INT NOT NULL,
  `Item_idItem` INT NOT NULL,
  PRIMARY KEY (`TiposConservacao_idTiposConservacao`, `Item_idItem`),
  INDEX `fk_ItemTipo_Item1_idx` (`Item_idItem` ASC) VISIBLE,
  CONSTRAINT `fk_ItemTipo_TiposConservação1`
    FOREIGN KEY (`TiposConservacao_idTiposConservacao`)
    REFERENCES `mydb`.`TiposConservacao` (`idTiposConservacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItemTipo_Item1`
    FOREIGN KEY (`Item_idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contacto` (
  `Telemovel` VARCHAR(9) NOT NULL,
  `Telefone` VARCHAR(9) NULL,
  `Email` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NULL,
  `Fornecedor_idFornecedor` INT NULL,
  `Funcionario_idFuncionario` INT NULL,
  INDEX `fk_Contacto_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Contacto_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  PRIMARY KEY (`Telemovel`),
  INDEX `fk_Contacto_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Contacto_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contacto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contacto_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `mydb`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VeiculoTipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VeiculoTipo` (
  `TiposConservacao_idTiposConservacao` INT NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  PRIMARY KEY (`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`),
  INDEX `fk_VeiculoTipo_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_VeiculoTipo_TiposConservação1`
    FOREIGN KEY (`TiposConservacao_idTiposConservacao`)
    REFERENCES `mydb`.`TiposConservacao` (`idTiposConservacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VeiculoTipo_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relatorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relatorio` (
  `Funcionario_idFuncionario` INT NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Data` DATETIME NOT NULL,
  `EstadoResolucao` TINYINT NOT NULL DEFAULT 0,
  `Descricao` VARCHAR(200) NOT NULL,
  `Gravidade` VARCHAR(1) NOT NULL DEFAULT 'L',
  PRIMARY KEY (`Funcionario_idFuncionario`, `Veiculo_idVeiculo`, `Data`),
  INDEX `fk_Funcionario_has_Veiculo_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Veiculo_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Veiculo_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `mydb`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Veiculo_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`EnderecoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EnderecoCliente` (
  `Cliente_idCliente` INT NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Endereco_idEndereco`),
  INDEX `fk_Cliente_has_Endereco_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Endereco_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Endereco_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Endereco_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DataInspecaoPassada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DataInspecaoPassada` (
  `DataInspecaoPassada` DATE NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  PRIMARY KEY (`Veiculo_idVeiculo`, `DataInspecaoPassada`),
  CONSTRAINT `fk_DataInspecaoPassada_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FuncionarioPercurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FuncionarioPercurso` (
  `Funcionario_idFuncionario` INT NOT NULL,
  `Percurso_idpercurso` INT NOT NULL,
  `Condutor` TINYINT NOT NULL,
  PRIMARY KEY (`Funcionario_idFuncionario`, `Percurso_idpercurso`),
  INDEX `fk_FuncionarioPercurso_Percurso1_idx` (`Percurso_idpercurso` ASC) VISIBLE,
  CONSTRAINT `fk_FuncionarioPercurso_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `mydb`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FuncionarioPercurso_Percurso1`
    FOREIGN KEY (`Percurso_idpercurso`)
    REFERENCES `mydb`.`Percurso` (`idpercurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
