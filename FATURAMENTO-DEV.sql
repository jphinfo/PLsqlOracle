DEFINE XONDA =:SEPARACAO@INTEGER

WITH VMSE AS (

    SELECT * 
        FROM v_monitor_separacao_expedicao
    WHERE nu_separacao = &SEPARACAO
          AND cd_empresa = 1001
),

T_PROD AS (

    SELECT * 
        FROM t_produto 
        WHERE cd_empresa = 1001
                     AND TP_ARMAZENAGEM_PRODUTO = 'P'
)


SELECT SUBSTR(a.nu_pedido_origem,1, 3) AS "LOJA",
           a.nu_separacao AS ONDA, 
           a.cd_produto AS NCE,
           b.ds_produto AS DESCRICAO,
           SUM(a.qt_produto) AS QT_PEDIDO,   
           SUM(a.qt_separado) AS QT_SEPARADO, 
           SUM(a.qt_conferido) AS QT_CONFERIDO,                   
           NVL(SUM(a.qt_cancelada), 0) AS QT_CANCELADA,
           a.id_separado AS SEPARADO,
           a.id_conferido AS CONFERIDO,
           a.id_embarcado AS EMBARCADO,
           a.id_cancelado AS ETIQUETA_CANCELADA,
           a.nu_nota AS NOTA,
           a.nu_pedido_origem AS PEDIDO,
           a.nu_contenedor AS ETIQUETA,
           a.cd_carga AS CARGA, 
           a.ds_observacao AS OBS, 
           NVL(a.nu_lacre_separacao, 0) AS LACRE,
           TO_CHAR(a.dt_liberacao_onda) AS DT_ONDA, 
           TO_CHAR(a.dt_conferencia) AS DT_CONFERENCIA

FROM VMSE a
    INNER JOIN  T_PROD b
        ON a.cd_produto = b.cd_produto  

GROUP BY a.nu_separacao, 
         a.cd_produto, 
         b.ds_produto, 
         a.id_separado, 
         a.id_conferido, 
         a.id_embarcado, 
         a.id_cancelado, 
         a.nu_nota, 
         a.nu_pedido_origem, 
         a.nu_contenedor, 
         a.cd_carga, 
         a.ds_observacao, 
         a.nu_lacre_separacao, 
         a.dt_liberacao_onda, 
         a.dt_conferencia

UNION

SELECT ' TOTAL' AS "     ",
        COUNT(DISTINCT(b.nu_separacao)) AS "ONDA",
        '                      ' || TO_CHAR(COUNT(DISTINCT(b.cd_produto))) AS "NCE",
        ' ' AS "DESCRICAO",
        SUM(b.qt_produto) AS "QT_PEDIDO", 
        SUM(b.qt_separado) AS "QT_SEPARADO", 
        SUM(b.qt_conferido)  AS "QT_CONFERIDO",          
        NVL(SUM(b.qt_cancelada), 0) AS "QT_CANCELADA",
        ' ' AS "SEPARADO",
        ' ' AS "CONFERIDO",
        ' ' AS "EMBARCADO",
        ' ' AS "ETIQUETA_CANCELADA",
        ' ' AS "NOTA",
        ' ' AS "PEDIDO",
         0  AS "ETIQUETA",
        ' ' AS "CARGA",
        ' ' AS "OBS",
         0  AS "LACRE",
        ' ' AS "DT_ONDA",
        ' ' AS "DT_CONFERENCIA"


      --    
FROM VMSE b
INNER JOIN  T_PROD c
        ON c.cd_produto = b.cd_produto  

ORDER BY 1 















