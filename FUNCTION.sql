CREATE SEQUENCE SEQ_ID_USERS
START WITH 1
INCREMENT BY 1;


CREATE TABLE users(
	user_id integer,
	user_name varchar(20) not null,
	user_last_name varchar(100),
	user_documents varchar(15),
	user_email varchar(100),
	user_password varchar(15)
);

SELECT * FROM USERS;
DROP TABLE users;

ALTER TABLE users ADD user_pay DOUBLE PRECISION;


INSERT INTO USERS VALUES(SEQ_ID_USERS.NEXTVAL,'Joseph', 'Machado', '019.125.325-45', 'josephsk8@hotmail.com', '325698', 8000);
INSERT INTO USERS VALUES(SEQ_ID_USERS.NEXTVAL,'Thays', 'Moura', '016.175.361-55', 'thays.moura@gmail.com', '57698', 1100);
INSERT INTO USERS VALUES(SEQ_ID_USERS.NEXTVAL,'Maria', 'Luane', '021.195.457-99', 'maria@yahoo.com', '12457', 1200);
INSERT INTO USERS VALUES(SEQ_ID_USERS.NEXTVAL,'Gracy', 'Raiany', '017.325.412-13', 'gracyraiany@hotmail.com', '254198', 2500);
INSERT INTO USERS VALUES(SEQ_ID_USERS.NEXTVAL,'Pedro', 'Parker', '015.247.968-65', 'pparker@hotmail.com', '2549874', 4000);
INSERT INTO USERS VALUES(SEQ_ID_USERS.NEXTVAL,'Yarah', 'Flor', '014.474.298-15', 'yarah@uol.com', '325698', 6000);


CREATE OR REPLACE FUNCTION user_role_func (user_pay DOUBLE PRECISION)
RETURN VARCHAR2
IS NOTICE VARCHAR2(30);
BEGIN
        IF user_pay < 1100.55 THEN 
           NOTICE := 'Estagiário';
       ELSIF user_pay < 3000.00 THEN
           NOTICE := 'Auxiliar';
       ELSIF user_pay < 5000.00 THEN
           NOTICE := 'Técnico';
       ELSIF user_pay < 7000.00 THEN
           NOTICE := 'DBA';
       ELSIF user_pay < 9000.00 THEN
          NOTICE := 'Programador';
       ELSE
           NOTICE := 'Não parametrizado';
       END IF;
       RETURN NOTICE;
END;

select  user_role_func(8500.54) from dual;

SELECT * FROM USERS;

SELECT user_id, 
             user_name,
             user_pay,
             user_role_func(user_pay)
   FROM USERS;

UPDATE  USERS SET user_pay = 5000.32 where user_id = 2;

COMMIT;
----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION Type_it(numero INTEGER)
RETURN VARCHAR2
IS NOTICEee VARCHAR2(30);
BEGIN
            IF MOD(numero, 2) = 0 THEN 
                NOTICEee := 'The number ' || numero || ' is PAIR';
            ELSE
                NOTICEee := 'The number ' || numero || ' is ODD';
            END IF;
            RETURN NOTICEee;
END;
COMMIT;

SELECT type_it(16) FROM DUAL;

-----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SF_Type_it (numero INTEGER)
RETURN VARCHAR2
IS NOTICE VARCHAR2(30);

BEGIN
        
        IF MOD(numero, 2) = 0 THEN
                NOTICE := 'The number ' || numero || ' is PAIR.';
        ELSE
                NOTICE := 'The number ' || numero || ' is ODD.';
        END IF;
        
        RETURN NOTICE;
        
END;



SELECT SF_Type_it(552) FROM DUAL;

----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SF_FACTORIAL (FAT INTEGER)
RETURN VARCHAR2
IS NOTICE INTEGER;
        X INTEGER := 1;
        Y INTEGER := 1;
BEGIN
        WHILE(X <= FAT)
        LOOP        
        Y := Y * X;
        X := X + 1;
        NOTICE := Y;
        END LOOP;
        RETURN NOTICE;
END;

COMMIT;

SELECT SF_FACTORIAL(&FAT) FROM DUAL;

----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SF_LOCAL(cd_endereco VARCHAR2)
RETURN VARCHAR2
IS NOTICE VARCHAR2(50);

BEGIN
        IF REGEXP_LIKE(cd_endereco, '([A-H])')  THEN
            NOTICE := 'NA GAIOLA';
        ELSE
            NOTICE := 'EXTERNO';
            
        END IF;
        RETURN NOTICE;
    
END;

SELECT SUBSTR(nu_pedido_origem, 1, 3) AS "LOJA",
             nu_separacao AS "ONDA",
             sf_local(SUBSTR(cd_endereco, 4, 1)) AS "ÁREA"
            
            
    FROM v_monitor_separacao_expedicao

WHERE nu_separacao = 16155

GROUP BY sf_local(SUBSTR(cd_endereco, 4, 1)),
                  SUBSTR(nu_pedido_origem, 1, 3),
                  nu_separacao

ORDER BY 1

FETCH NEXT 100 ROWS ONLY








