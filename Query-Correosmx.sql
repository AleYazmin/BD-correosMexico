CREATE DATABASE CORREOSMex

USE [CORREOSMex]
GO

/****** Object:  Table [dbo].[CPdescarga]    Script Date: 30/01/2024 1:03:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CPdescarga](
	[d_codigo] [int] NULL,
	[d_asenta] [nvarchar](max) NULL,
	[d_tipo_asenta] [nvarchar](max) NULL,
	[D_mnpio] [nvarchar](max) NULL,
	[d_estado] [nvarchar](max) NULL,
	[d_ciudad] [nvarchar](max) NULL,
	[d_CP] [int] NULL,
	[c_estado] [int] NULL,
	[c_oficina] [int] NULL,
	[c_CP] [nvarchar](max) NULL,
	[c_tipo_asenta] [int] NULL,
	[c_mnpio] [int] NULL,
	[id_asenta_cpcons] [int] NULL,
	[d_zona] [nvarchar](max) NULL,
	[c_cve_ciudad] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
--###################################################
--CREAR TABLA ESTADOS
CREATE TABLE Estados(
id_Estados INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
Estados NVARCHAR(MAX) NOT NULL
)
--INSERTA
INSERT INTO Estados(Estados)
SELECT DISTINCT d_estado FROM CPdescarga
--CONSULTAR
SELECT * FROM Estados

--####################################################

--CREAR TABLA MUNICIPIOS
CREATE TABLE Municipios(
id_Municipio INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
Municipios NVARCHAR(MAX),
ClaveC INT NULL,
id_estado INTEGER FOREIGN KEY (id_estado) REFERENCES Estados(id_Estados)
)
--INSERTAR
INSERT INTO Municipios(Municipios, ClaveC, id_estado)
SELECT DISTINCT D_mnpio, c_mnpio, c_estado FROM CPdescarga
--CONSULTA
SELECT * FROM Municipios

--####################################################

--CREAR TABLA CODIGO POSTAL
CREATE TABLE CodigoP(
id_CodigoP INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
Cpostal INT,
Colonia NVARCHAR(MAX) NULL,
id_estado INTEGER FOREIGN KEY (id_estado) REFERENCES Municipios(id_Municipio)
)
--INSERTAR
INSERT INTO CodigoP(Cpostal, Colonia, id_estado)
SELECT DISTINCT d_codigo, d_asenta, c_mnpio FROM CPdescarga
--CONSULTA
SELECT * FROM CodigoP

--#######################################################

--CREAR TABLA ASENTAMIENTO
CREATE TABLE Asentamiento(
id_Asentamiento INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
Nombre NVARCHAR(MAX) NULL,
Tipo NVARCHAR(MAX) NULL,
T_Asenta INT NULL,
idCP INTEGER FOREIGN KEY (idCP) REFERENCES CodigoP(id_CodigoP)
)
--INSERTAR
INSERT INTO Asentamiento(Nombre, Tipo, T_Asenta, idCP)
SELECT DISTINCT d_asenta, d_tipo_asenta, c_tipo_asenta, id_asenta_cpcons FROM CPdescarga
--CONSULTA
SELECT * FROM Asentamiento

--#####################################################

--CREAR TABLA ZONA
CREATE TABLE Zona(
id_Zona INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
Zona NVARCHAR(MAX) NULL,
Oficina INT NULL,
idAsent INTEGER FOREIGN KEY (idAsent) REFERENCES Asentamiento(id_Asentamiento)
)
--INSERTAR
INSERT INTO Zona(Zona, Oficina, idAsent)
SELECT DISTINCT d_zona, c_oficina, id_asenta_cpcons FROM CPdescarga
--CONSULTAR
SELECT * FROM Zona