DEFINE NU_SEP =: SEPARACAO@varchar2

WITH VMSE AS (
    SELECT *
       FROM v_monitor_separacao_expedicao 
            WHERE nu_separacao = 16817 
                         AND cd_empresa = 1001
),

T_PROD AS (
    SELECT * 
        FROM t_produto 
            WHERE cd_empresa = 1001

),

IEDPS AS (
    SELECT * 
        FROM int_e_det_pedido_saida 
            WHERE cd_situacao = 1
)



SELECT v.cd_carga AS "CARGA",
            v.nu_separacao AS "SEP",
            v.nu_pedido_origem AS "PEDIDO",
            v.nu_contenedor AS "ETIQUETA",
            p.cd_produto AS "PRODUTO",
            p.ds_produto AS "DESC",
            v.qt_produto AS "QT_PEDIDA",
            i.campanha AS "OBS",
            SUBSTR(v.cd_endereco, 1, 1) AS "GALP"

FROM VMSE v
   INNER JOIN T_PROD p 
      ON p.cd_produto = v.cd_produto
   INNER JOIN IEDPS i 
      ON i.cd_produto = p.cd_produto
      AND v.nu_pedido_origem = i.nu_pedido_origem

UNION 

SELECT DISTINCT(v.cd_carga) AS "CARGA",
             0 AS "SEP",
             '' AS "PEDIDO",
             0 AS "ETIQUETA",
            '' AS "PRODUTO",
            '' AS "DESC",
             0 AS "QT_PEDIDA",
            '' AS "OBS",
            '' AS "GALP"

FROM VMSE v
   INNER JOIN T_PROD p 
      ON p.cd_produto = v.cd_produto
   INNER JOIN IEDPS i 
      ON i.cd_produto = p.cd_produto
      AND v.nu_pedido_origem = i.nu_pedido_origem


ORDER BY  9, 6, 1

