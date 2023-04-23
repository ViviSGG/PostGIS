CREATE EXTENSION postgis;

-- PRÁTICA01 DO POSTGIS --

-- 1. Criação de uma tabela com dados espaciais --
CREATE TABLE pontos (
id SERIAL PRIMARY KEY,
nome varchar(20),
geom geometry(Point, 4326)
);

-- 2. Inserção de dados na tabela --
INSERT INTO pontos (nome, geom) VALUES
('Ponto 1', ST_SetSRID(ST_MakePoint(-43.947, -19.917), 4326)),
('Ponto 2', ST_SetSRID(ST_MakePoint(-43.943, -19.915), 4326)),
('Ponto 3', ST_SetSRID(ST_MakePoint(-43.948, -19.916), 4326));

-- 3. Consulta de pontos próximos a uma determinada coordenada --
SELECT nome, ST_AsText(geom), ST_Distance(geom, ST_SetSRID(ST_MakePoint(-43.946, -
19.917), 4326)) AS distancia
FROM pontos
WHERE ST_DWithin(geom, ST_SetSRID(ST_MakePoint(-43.946, -19.917), 4326), 0.001);

-- PRÁTICA02 DO POSTGIS --

-- 1. Criação de uma tabela com dados espaciais no PostGIS --
CREATE TABLE cidades (
id SERIAL PRIMARY KEY,
nome varchar(50),
populacao bigint,
geom geometry(MultiPolygon, 4326)
);

-- 2. Inserção de dados na tabela -- 
INSERT INTO cidades(nome, populacao, geom) VALUES
('São Paulo', 12325232, ST_SetSRID(ST_GeomFromText('MULTIPOLYGON(((
-46.826171875 -23.6474988338,
-46.7724609375 -23.6474988338,
-46.7724609375 -23.5923936566,
-46.826171875 -23.5923936566,
-46.826171875 -23.6474988338)))'), 4326)),
('Rio de Janeiro', 6747815, ST_SetSRID(ST_GeomFromText('MULTIPOLYGON(((
-43.4240722656 -22.9973093535,
-43.1756591797 -22.9973093535,
-43.1756591797 -22.7847896349,
-43.4240722656 -22.7847896349,
-43.4240722656 -22.9973093535)))'), 4326)),
('Belo Horizonte', 2521564, ST_SetSRID(ST_GeomFromText('MULTIPOLYGON(((
-44.0814208984 -19.9100001913,
-43.9739990234 -19.9100001913,
-43.9739990234 -19.8324514855,
-44.0814208984 -19.8324514855,
-44.0814208984 -19.9100001913)))'), 4326)),
('Recife', 1645727, ST_SetSRID(ST_GeomFromText('MULTIPOLYGON(((
-34.931640625 -8.1006980657,
-34.8706054688 -8.1006980657,
-34.8706054688 -8.0266485532,
-34.931640625 -8.0266485532,
-34.931640625 -8.1006980657)))'), 4326)),
('Olinda', 391086, ST_SetSRID(ST_GeomFromText('MULTIPOLYGON(((
-34.8254394531 -7.9906481173,
-34.7964477539 -7.9906481173,
-34.7964477539 -7.9586478451,
-34.8254394531 -7.9586478451,
-34.8254394531 -7.9906481173)))'), 4326)),
('Paulista', 334184, ST_SetSRID(ST_GeomFromText('MULTIPOLYGON(((
-34.8999023438 -7.9446283891,
-34.868927002 -7.9446283891,
-34.868927002 -7.9099657821,
-34.8999023438 -7.9099657821,
-34.8999023438 -7.9446283891)))'), 4326));

-- 4. Consulta de dados no PostGis --
SELECT nome, ST_AsText(geom)
FROM cidades
WHERE ST_DWithin(geom, (SELECT geom FROM cidades WHERE nome = 'São Paulo' LIMIT 1), 50000);

