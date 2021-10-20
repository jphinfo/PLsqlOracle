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


SELECT (USER_NAME)
FROM USERS

SELECT * FROM EXPEDICAO

DELETE FROM USERS WHERE USER_ID = 3;

INSERT INTO USERS VALUES (6, 'TAYNARAH')
        (1, 'JOSEPH'), 
        (2, 'THAYS'),
        (3, 'SANTANA'),
        (4, 'TOBIAS'),
        (5, 'YARAH');
INSERT INTO EXPEDICAO (user_id, separator, helper) VALUES (3, 68555, '');

--retorna toda a string depois do parâmetro JO
SELECT USER_NAME, REGEXP_SUBSTR(USER_NAME, 'JO[^.]*')
    FROM USERS
        --WHERE SUBSTR(USER_NAME, 1, 2) = 'TH'
    
        WHERE user_name LIKE '%BI%' OR user_name LIKE '%PH%'

WITH PESSOA AS (
SELECT USER_NAME as NOME FROM USERS
WHERE USER_ID = 1
)

SELECT USER_ID, NOME FROM PESSOA, USERS;

SELECT *  FROM USERS 
WHERE USER_ID > 5
FETCH NEXT 2 ROWS ONLY;




SELECT USER_ID,
            CASE TO_CHAR(SYSDATE, 'DY')
            WHEN 'SEG' THEN USER_NAME
            ELSE ' '
            END AS "NOME"
FROM USERS, DUAL;

SELECT DECODE (USER_ID, 1, USER_ID * 8,
                          USER_ID * 5
) AS TESTE
FROM USERS

SELECT EXTRACT(HOUR FROM LOCALTIMESTAMP) FROM DUAL;
SELECT USER_ID,
            CASE 
                    WHEN EXTRACT(HOUR FROM LOCALTIMESTAMP) < 18
                        THEN EXTRACT(HOUR FROM LOCALTIMESTAMP) - 1
                    ELSE EXTRACT(HOUR FROM LOCALTIMESTAMP)
            END AS HORA
FROM USERS, DUAL


SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL;

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
SELECT TO_CHAR(112499.1025413, 'L99999999D99') FROM DUAL

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
 
 SELECT TO_CHAR(LOCALTIMESTAMP, 'HH24') + 1 FROM DUAL;
 
SELECT 
        CASE  
                WHEN EXTRACT(HOUR FROM LOCALTIMESTAMP) <= 23  
                           THEN  
                                    CASE TO_CHAR(SYSDATE, 'DY')
                                                WHEN 'DOM' 
                                                        THEN (9 * 9)
                                                ELSE 9
                                    END

                ELSE 0
        END AS "DIA DA SEMANA"
FROM DUAL;


--------------------------------------------------------------------------------------------------------------------------------
WITH HORA_ATUAL AS (
        SELECT 
                    CASE 
                            WHEN (EXTRACT(HOUR FROM LOCALTIMESTAMP) < 12) THEN (EXTRACT(HOUR FROM LOCALTIMESTAMP) - 1)
                            ELSE EXTRACT(HOUR FROM LOCALTIMESTAMP)
                    END AS HORA

        FROM DUAL
)


SELECT 'G1' AS "GALPÃO",
             COUNT(e.nu_contenedor) AS "TOTAL DE ETQ'S PENDENTES", 
             TO_CHAR((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))),'99990D99') AS "CUBAGEM",
             '4,4' AS "META (m³/h)",
             '24' AS "META (etiqueta/h)",
             CASE TO_CHAR(SYSDATE, 'DY')
                    WHEN 'SEX' THEN TO_CHAR((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((16)-(HORA))),'99990D99')                            
                    ELSE TO_CHAR((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((17)-(HORA))),'99990D99')
            END AS "SEP. NEC. P/ CUBAGEM",
            
            CASE TO_CHAR(SYSDATE, 'DY')
                    WHEN 'SEX' THEN TO_CHAR(COUNT(e.nu_contenedor) / (24 * ((16)-(HORA))), '99990D99')                            
                    ELSE TO_CHAR(COUNT(e.nu_contenedor) / (24 * ((17)-(HORA))), '99990D99')
            END AS "SEP. NECESS�?RIO POR ETQ.",
            
            CASE TO_CHAR(SYSDATE, 'DY')
                    WHEN 'SEX' THEN TO_CHAR((((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((16)-(HORA)))) + (COUNT(e.nu_contenedor) / (24 * ((16)-(HORA)))))/2,'99990D99')                             
                    ELSE TO_CHAR((((SUM((vl_altura * vl_largura * vl_profundidade) * (e.qt_produto))) / (4.4*((17)-(HORA)))) + (COUNT(e.nu_contenedor) / (24 * ((17)-(HORA)))))/2,'99990D99')
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

------------------------------------------------------------------------------------------
(EXTRACT(HOUR FROM LOCALTIMESTAMP) --

WITH HORA_ATUAL AS (
        SELECT 
                    CASE 
                            WHEN (TO_CHAR(SYSDATE, 'DY') = 'SEG') AND (EXTRACT(HOUR FROM LOCALTIMESTAMP) < 18) THEN 1
                            ELSE 0
                    END AS HORA

        FROM DUAL
)

SELECT HORA FROM HORA_ATUAL;
------------------------------------------------------------------------------------------------------------

SELECT 'Hoje ' || 'é' || TO_CHAR(SYSDATE, 'DD:MM:YYYY')
FROM dual;

SELECT 'Let' || '''' || 's' || ' learn Oracle'
FROM dual;


SELECT SUBSTR('EU GOSTO DE PROGRAMAR', 1, 9) AS TESTE FROM DUAL

SELECT
  REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA',
                ',[^,]+,') "REGEXPR_SUBSTR"
  FROM DUAL;

SELECT SUBSTR(CURRENT_TIMESTAMP, 1, 5)
FROM DUAL;


DECLARE
          a int := 30;
          b int := 20;
BEGIN
          dbms_output.put_line('Value of A is ' || a);
          dbms_output.put_line('value of B is ' || b);
          dbms_output.put_line('A soma de A + B é igual a: ' || (a + b));
        
END;


DECLARE
    v_text VARCHAR2(10); -- declare
BEGIN
    v_text := 'Hello';  --assign
    dbms_output.Put_line(v_text); --display
END; 

declare
  n number(10):=1;
begin
  while n<=10
 loop
   dbms_output.put_line(n);
   n:=n+1;
 end loop;
end;


DECLARE
        N INT := 10;
BEGIN
    IF (N / 2) < 20
    THEN DBMS_OUTPUT.PUT_LINE('TRUE');
    
    END IF;

END;


DECLARE
        A INT := 10;
BEGIN
    A := (A %  2);
    DBMS_OUTPUT.PUT_LINE(A);
    
END;

CREATE OR REPLACE PROCEDURE SP_FACTORIAL(FAT INTEGER) 
IS
            X INTEGER := 1;
            Y INTEGER := 1;


BEGIN
        WHILE(X <= FAT)
        LOOP
        DBMS_OUTPUT.PUT_LINE('The factorial of  ' || x || ' is ' || Y);
        X := X + 1;
        Y := Y * X;
        
        END LOOP;
END;


DEFINE NUM_A := A@NUMBER;
DEFINE NUM_B := B@NUMBER;
CREATE OR REPLACE PROCEDURE SP_CALC(NUM1 INT, NUM2 INT)
IS
            SOMA INT := (NUM1 + NUM2);  
BEGIN
            DBMS_OUTPUT.PUT_LINE('A soma de ' || NUM1 || ' + ' || NUM2 || ' � igual a ' || SOMA);

END;

BEGIN
        SP_CALC(&A,&B);
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------

DEFINE FATORIAL := F@INTEGER;
CREATE OR REPLACE PROCEDURE SP_FACTORIAL(FAT INTEGER)
IS
        X INTEGER := 1;
        Y INTEGER := 1;
BEGIN
        WHILE(X < FAT)
        LOOP        
        X := X + 1;
        Y := Y * X;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('O fatorial de ' || X || ' �: ' || Y);
END;
/

EXECUTE SP_FACTORIAL(&F);

COMMIT;

------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE
            X INTEGER := 10;
BEGIN
        WHILE(X >= 0)
        LOOP
            DBMS_LOCK.SLEEP(1);
            DBMS_OUTPUT.PUT_LINE(X);
            X := X - 1;
        END LOOP;
END;
/



DECLARE
        X int := 1;
        Y INT := 1;
BEGIN
        WHILE X <= 10
        LOOP
            DBMS_OUTPUT.PUT_LINE(rpad(x, x, x));
            X := X + 1;
        END LOOP;
END;