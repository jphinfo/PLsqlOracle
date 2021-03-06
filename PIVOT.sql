CREATE TABLE T_ESTOQUE(
    CD_ENDERECO VARCHAR(15),
    CD_PRODUTO VARCHAR(20),
    QT_ESTOQUE INT
);

DROP TABLE T_ESTOQUE

INSERT INTO T_ESTOQUE VALUES ('206K07000', '189909.01058889', 12);
INSERT INTO T_ESTOQUE VALUES ('206K08300', '189909.01058889', 20);
INSERT INTO T_ESTOQUE VALUES ('206K09300', '190909.01058889', 10);
INSERT INTO T_ESTOQUE VALUES ('101X03000', '188895.01054611', 13);
INSERT INTO T_ESTOQUE VALUES ('109T24000', '108483.18020015', 29);
INSERT INTO T_ESTOQUE VALUES ('102D20300', '190850.01030003', 44);
INSERT INTO T_ESTOQUE VALUES ('502D20300', '192457.01030003', 15);
INSERT INTO T_ESTOQUE VALUES ('502C05000', '180240.01030353', 35);
INSERT INTO T_ESTOQUE VALUES ('902D02200', '190156.01030016', 15);
INSERT INTO T_ESTOQUE VALUES ('903F01100', '188350.01030038', 10);
INSERT INTO T_ESTOQUE VALUES ('604H01000', '190156.01030016', 35);
INSERT INTO T_ESTOQUE VALUES ('603F11100', '188350.01030038', 63);



SELECT * FROM T_ESTOQUE2


SELECT 'G' || SUBSTR(CD_ENDERECO, 1, 1) AS "GALPAO",
             SUM(QT_ESTOQUE) AS "TOTAL"
FROM T_ESTOQUE2
WHERE NOT REGEXP_LIKE(CD_ENDERECO, '([X])')
GROUP BY SUBSTR(CD_ENDERECO, 1, 1)

UNION

SELECT 'TOTAL' AS "GALPAO",
             SUM(QT_ESTOQUE) AS "TOTAL"
FROM T_ESTOQUE2
WHERE NOT REGEXP_LIKE(CD_ENDERECO, '([X])')
ORDER BY 1

-----------------------------------------------------------------------------------------------------------------------------------------------------------

WITH T_TEMP AS (
                   SELECT 'Total' AS "GALPAO",
                                 'G' || SUBSTR(CD_ENDERECO, 1, 1) AS T_GALPAO,
                                  QT_ESTOQUE
    FROM T_ESTOQUE2
    WHERE NOT REGEXP_LIKE(CD_ENDERECO, '([X])')
    )
    
    SELECT * FROM T_TEMP
    
    PIVOT
    (
    SUM(QT_ESTOQUE)
    FOR T_GALPAO  IN ('G1', 'G2', 'G5', 'G6', 'G9')  



    
    
    
    
WITH T_STK AS (
    SELECT   'TOTAL' AS "GALPAO",
                    'G' || SUBSTR(CD_ENDERECO,1, 1) AS GALP,
                    QT_ESTOQUE
        FROM T_ESTOQUE2
     WHERE NOT REGEXP_LIKE (CD_ENDERECO, '([X])')
    
)

SELECT * FROM T_STK
PIVOT
(
SUM(QT_ESTOQUE)
FOR GALP IN ( 'G5','G9')
)
    
    
    
    
    
    
    
    
    
    
    
    
    
