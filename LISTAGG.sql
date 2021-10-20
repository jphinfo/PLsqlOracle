WITH VMSE AS (

    SELECT * 
        FROM v_monitor_separacao_expedicao
    WHERE nu_separacao = 16815
          AND cd_empresa = 1001
)

SELECT  LISTAGG(cd_carga,  ', ')  WITHIN GROUP (ORDER BY cd_carga) from (select distinct cd_carga 
FROM VMSE v) 


SELECT LISTAGG(cd_carga, ', ') WITHIN GROUP (ORDER BY cd_carga) AS "TESTE"
FROM (SELECT DISTINCT cd_carga
    FROM v_monitor_separacao_expedicao
WHERE nu_separacao = '16815');