CREATE DATABASE VENDAS;
USE VENDAS;
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY AUTO_INCREMENT,
    NomeProduto VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Fornecedores (
    FornecedorID INT PRIMARY KEY AUTO_INCREMENT,
    NomeFornecedor VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20),
    Endereco TEXT 
);

CREATE TABLE Estoque (
    EstoqueID INT PRIMARY KEY AUTO_INCREMENT, 
    ProdutoID INT NOT NULL,
    FornecedorID INT NOT NULL, 
    Quantidade INT NOT NULL,
    DataEntrada DATE NOT NULL,          
    CONSTRAINT FK_Produto FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID),
    CONSTRAINT FK_Fornecedor FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(FornecedorID)
);

INSERT INTO Produtos (NomeProduto, Descricao, Preco) 
VALUES 
('Teclado Mecânico', 'Teclado mecânico com iluminação RGB', 250.00),
('Mouse Gamer', 'Mouse ergonômico com 7 botões', 150.00),
('Monitor Full HD', 'Monitor de 24 polegadas com resolução Full HD', 900.00);

INSERT INTO Fornecedores (NomeFornecedor, Telefone, Endereco) 
VALUES 
('Fornecedor A', '123456789', 'Rua A, 123'),
('Fornecedor B', '987654321', 'Avenida B, 456');

INSERT INTO Estoque (ProdutoID, FornecedorID, Quantidade, DataEntrada) 
VALUES 
(1, 1, 50, '2024-12-01'),
(2, 2, 30, '2024-12-02'),
(3, 1, 20, '2024-12-03');

SELECT 
    e.EstoqueID, 
    p.NomeProduto, 
    f.NomeFornecedor, 
    e.Quantidade, 
    e.DataEntrada
FROM Estoque e
LEFT JOIN Produtos p ON e.ProdutoID = p.ProdutoID
LEFT JOIN Fornecedores f ON e.FornecedorID = f.FornecedorID

UNION

SELECT 
    e.EstoqueID, 
    p.NomeProduto, 
    f.NomeFornecedor, 
    e.Quantidade, 
    e.DataEntrada
FROM Estoque e
RIGHT JOIN Produtos p ON e.ProdutoID = p.ProdutoID
RIGHT JOIN Fornecedores f ON e.FornecedorID = f.FornecedorID;

SELECT 
    f.NomeFornecedor, 
    SUM(e.Quantidade) AS TotalQuantidade
FROM Estoque e
INNER JOIN Fornecedores f ON e.FornecedorID = f.FornecedorID
GROUP BY f.NomeFornecedor;

ALTER TABLE Estoque ADD CustoTotal DECIMAL(10, 2);
