CREATE TABLE USERS(
    user_id int not null,
    user_name varchar(15),
    CONSTRAINT PK_USERS PRIMARY KEY(USER_ID)
);



CREATE TABLE EXPEDICAO(
    user_id int not null,
    separator int,
    helper int,
    CONSTRAINT FK_USERS FOREIGN KEY (user_id) REFERENCES users(user_id)
);

SELECT * FROM USERS
SELECT * FROM EXPEDICAO


SELECT U.USER_ID, U.USER_NAME, E.SEPARATOR, E.HELPER
FROM USERS U
    INNER JOIN EXPEDICAO E
        ON U.USER_ID = E.USER_ID;

DELETE FROM USERS WHERE USER_ID = 3;

INSERT INTO USERS VALUES (6, 'TAYNARAH')
        (1, 'JOSEPH'), 
        (2, 'THAYS'),
        (3, 'SANTANA'),
        (4, 'TOBIAS'),
        (5, 'YARAH');
INSERT INTO EXPEDICAO (user_id, separator, helper) VALUES (2, 68222, '68333');

--retorna toda a string depois do parâmetro JO
SELECT USER_NAME, REGEXP_SUBSTR(USER_NAME, 'JO[^.]*')
    FROM USERS
        --WHERE SUBSTR(USER_NAME, 1, 2) = 'TH'
    
        WHERE user_name LIKE '%BI%' OR user_name LIKE '%PH%'


        SELECT e.user_id, 
                    e.separator,  
                    u.user_name,
                    
                    (SELECT separator
                    FROM EXPEDICAO
                    WHERE helper = e.user_id
                    ) AS "REGISTRO_AJUD",
                    
                    e.helper,
            
                    (SELECT user_name
                    FROM USERS
                    WHERE user_id = u.user_id
                    ) AS "AJUDANTE"
            
        FROM USERS U, EXPEDICAO E
        WHERE e.user_id = u.user_id

SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;


SELECT TO_CHAR(SYSDATE, 'DY') day FROM dual; --extrai o dia da semana referente a data do computador

select to_char(112499.1025413) from dual;
SELECT TO_CHAR(112499.1025413,'FM99999999990.99') FROM DUAL;
SELECT TO_CHAR(112499.1025413,'9999999999.99') FROM DUAL;
SELECT TO_CHAR(112499.1025413, '999999999D99') FROM DUAL

SELECT TO_CHAR(0.1025413, '999999990D99') FROM DUAL
SELECT TO_CHAR(0.1025413,'FM99999999990.99') FROM DUAL;
SELECT TO_CHAR(DOUBLE PRECISION, 112499.1025413,'99999D99') FROM DUAL;

/* 
String	Descrição	                                                                            Resultado

9	        Determina a largura de exibição	                                            9999 = 1234
0	        Exibe zeros a esquerda	                                                        09999 = 01234
$	        Exibe dolar ( UAUU! ) * qquer posicao fica na frente	                $9999 = $1234
L	        Exibe a moeda	                                                                    L9999 = R$1234
D	        Caractere decimal	                                                                9999D99 = 1234,00
.	        Mostra uma virgula ou ponto	                                                9999.99  = 1234.00
G       	Separado de grupos	                                                            999G9 = 123.4
,	        Ponto / virgula na posicao	                                                    999,9 = 123,4
MI	        Sinal negativo à direita*	                                                        9999MI = 1234-*
PR	        poe valores negativos entre <>*                                         	9999PR = <1234>*
EEEE    	informa no padrao cientifico	                                                9999EEEE = 1E+03
U	        Retorna um simbolo monetário fora da casinha	                    U9999 = Cr$1234
V	        Multiplica por 10 x o numero de noves.	                                1234V9 = 12340
S	        Informa o sinal	                                                                    S9999 = +1234
B	        Troca valores zero por vazio**	                                            B9999 = ‘ ‘ **

 */

DEFINE H1 = 17
DEFINE H2 = 16

WITH HORA_ATUAL AS (
        SELECT 
                    CASE 
                            WHEN (EXTRACT(HOUR FROM LOCALTIMESTAMP) < 12) THEN (EXTRACT(HOUR FROM LOCALTIMESTAMP) + 1)
                            ELSE EXTRACT(HOUR FROM LOCALTIMESTAMP)
                    END AS HORA,
                    
                    CASE
                            WHEN EXTRACT(HOUR FROM LOCALTIMESTAMP)  >= &H1 THEN (EXTRACT(HOUR FROM LOCALTIMESTAMP) + 1)
                            ELSE &H1
                    END AS HOUR_DAY,
                    
                    CASE
                            WHEN EXTRACT(HOUR FROM LOCALTIMESTAMP)  >= &H2 THEN (EXTRACT(HOUR FROM LOCALTIMESTAMP) + 1)
                            ELSE &H2
                    END AS HOUR_FRIDAY
        FROM DUAL
)
                                 
                                 
SELECT 'G1' AS "GALPÃO",
             COUNT(e.nu_contenedor) AS "TOTAL DE ETQ'S PENDENTES", 
             NVL(TO_CHAR((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))),'99990D9'),0) AS "CUBAGEM",
             '4,4' AS "META (m³/h)",
             '24' AS "META (etiqueta/h)",
             CASE TO_CHAR(SYSDATE, 'DY')
                    WHEN 'SEX' THEN TO_CHAR((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((HOUR_FRIDAY)-(HORA))),'99990D9')                            
                    ELSE NVL(TO_CHAR((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((HOUR_DAY)-(HORA))),'99990D9'), '0,0')
            END AS "SEP. NEC. P/ CUBAGEM",
            
            CASE TO_CHAR(SYSDATE, 'DY')
                    WHEN 'SEX' THEN TO_CHAR(COUNT(e.nu_contenedor) / (24 * ((HOUR_FRIDAY)-(HORA))), '99990D9')                            
                    ELSE TO_CHAR(COUNT(e.nu_contenedor) / (24 * ((HOUR_DAY)-(HORA))), '99990D9')
            END AS "SEP. NECESS�?RIO POR ETQ.",
            
            CASE TO_CHAR(SYSDATE, 'DY')
                    WHEN 'SEX' THEN TO_CHAR((((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((HOUR_FRIDAY)-(HORA)))) + (COUNT(e.nu_contenedor) / (24 * ((HOUR_FRIDAY)-(HORA)))))/2,'99990D9')                             
                    ELSE NVL(TO_CHAR((((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((HOUR_DAY)-(HORA)))) + (COUNT(e.nu_contenedor) / (24 * ((HOUR_DAY)-(HORA)))))/2,'99990D9'), 0.0)
            END AS "NECESSIDADE" 
                        
FROM v_monitor_separacao_expedicao e
    INNER JOIN t_cab_produto p
        ON e.cd_produto = p.cd_produto
    CROSS JOIN HORA_ATUAL
WHERE  qt_separado is null
             AND e.qt_conferido is null
             AND e.qt_cancelada is null
             AND e.cd_situacao_pedido = 57
             AND e.cd_endereco  LIKE '1%'         
             
   
             
             
SELECT TO_CHAR((((SUM((8 * 10 * 2) * (15))) / (4.4*((HOUR_FRIDAY)-(HORA)))) + (COUNT(e.nu_contenedor) / (24 * ((HOUR_FRIDAY)-(HORA)))))/2,'99990D99')       
             
---------------------------------------------------------------------------------------------------------------------------        
DEFINE XNUM =: XNU@INTEGER;

SELECT U.USER_ID,
              U.USER_NAME,
              E.SEPARATOR
FROM USERS U
    INNER JOIN EXPEDICAO E
        ON U.USER_ID = E.USER_ID
WHERE U.USER_ID =  &XNU 
             
             
        
        
             
             
             
             
             
             
             
             
             
             








