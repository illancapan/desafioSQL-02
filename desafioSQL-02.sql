-- Active: 1716070295308@@127.0.0.1@5432@desafio_igor_llancapan_123@public
 SELECT * 
FROM 
    inscritos;


-- 1. ¿Cuántos registros hay?

SELECT 
    COUNT(*) AS TOTAL_INSCRITOS 
FROM inscritos;

-- 2. ¿Cuántos inscritos hay en total?

SELECT 
    sum(cantidad) AS cantidad_inscritos 
FROM inscritos;

-- 3. ¿Cuál o cuáles son los registros de mayor antigüedad?

SELECT 
    cantidad                            AS cantidad_inscritos, 
    to_char(fecha, 'dd/mm/yyyy')        AS fecha_inscritos, 
    fuente                              AS fuente_inscritos
FROM inscritos 
WHERE fecha = (SELECT MIN(fecha) FROM inscritos)
ORDER BY fecha ASC;

-- 4. ¿Cuántos inscritos hay por día? (Indistintamente de la fuente de inscripción)

SELECT 
    to_char(fecha, 'dd/mm/yyyy')    AS fecha_inscritos,  
    SUM(cantidad)                   AS inscritos_por_dia 
FROM inscritos 
GROUP BY fecha 
ORDER BY fecha;


-- 5. ¿Cuántos inscritos hay por fuente?

SELECT
        fuente          AS fuente_inscritos, 
        SUM(cantidad)   AS inscritos_por_fuente
FROM    inscritos
GROUP BY fuente
ORDER BY fuente;

-- 6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se
-- inscribieron en ese día?

SELECT 
    to_char(fecha, 'dd/mm/yyyy')    AS inscritos_por_dia,
    SUM(cantidad)                   AS total_inscritos 
FROM inscritos 
GROUP BY fecha
ORDER BY total_inscritos DESC
LIMIT 1;


-- 7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas
-- personas fueron?

SELECT 
    to_char(fecha, 'dd/mm/yyyy')    AS fecha_inscritos, 
    cantidad                        AS cantidad_usuarios 
FROM inscritos 
WHERE fuente = 'Blog' 
ORDER BY cantidad DESC
LIMIT 1;

-- 8. ¿Cuál es el promedio de personas inscritas por día? Toma en consideración que la
-- base de datos tiene un registro de 8 días, es decir, se obtendrán 8 promedios.

SELECT 
    to_char(fecha, 'dd/mm/yyyy')            AS fecha_inscritos, 
    ROUND(SUM(cantidad) / COUNT(fuente), 3) AS inscritos_por_dia
FROM inscritos
GROUP BY fecha
ORDER BY fecha;

-- fecha inscritos_por_dia
-- 01-01-2021 50.00000
-- 01-02-2021 60.00000

-- 9. ¿Qué días se inscribieron más de 50 personas?
SELECT 
    to_char(fecha, 'dd/mm/yyyy') AS fecha_inscritos,  
    SUM(cantidad) AS total_inscritos 
FROM inscritos 
GROUP BY fecha  
HAVING SUM(cantidad) > 50;
 --ORDER BY fecha_inscritos ASC; --ORDEN OPCIONAL


-- 10. ¿Cuál es el promedio por día de personas inscritas?
-- Considerando sólo calcular desde el tercer día.

SELECT 
    to_char(fecha, 'dd/mm/yyyy') AS fecha_inscritos,
    ROUND(AVG(cantidad), 1) AS cantidad_inscritos
FROM inscritos
WHERE fecha >= '01/03/2021'
GROUP BY fecha
ORDER BY fecha ASC;

-- fecha promedio_diario
-- 01-03-2021 51.5
-- 01-04-2021 46.5