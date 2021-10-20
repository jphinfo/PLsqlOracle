WITH T_TEMP AS (
                   SELECT 
                                 CASE TP_PEDIDO 
                                       WHEN 'T' THEN  'TRANSFERÊNCIA'
                                       WHEN 'V' THEN 'VENDA'
                                       WHEN 'Q' THEN 'REQUISICAO'
                                       WHEN 'I' THEN   'CARTA'
                                       WHEN 'TI' THEN 'REQ.TI'
                                       WHEN 'R' THEN 'REMANEJO'
                                       ELSE '--'
                                 END AS "PEDIDO",
                                 'G' || SUBSTR(CD_ENDERECO, 1, 1) AS T_GALPAO,
                                  TP_PEDIDO AS PED
                                        
    FROM v_monitor_separacao_expedicao
    WHERE NOT REGEXP_LIKE (tp_pedido, '[X]')
                AND qt_separado is null
                AND qt_conferido is null
                AND qt_cancelada is null
                AND cd_situacao_pedido = 57

    
    )    
    SELECT * FROM T_TEMP

    PIVOT
    (
    COUNT(PED)
    FOR T_GALPAO  IN ('G1', 'G2', 'G5', 'G6', 'G9')
    ) 
    
UNION ALL
       
 SELECT * FROM
                   (SELECT   'TOTAL' AS PEDIDO,
                                  'G' || SUBSTR(CD_ENDERECO, 1, 1) AS GALP,
                                  TP_PEDIDO
                                  
    FROM v_monitor_separacao_expedicao  
        WHERE NOT REGEXP_LIKE (tp_pedido, '[X]')
                AND qt_separado is null
                AND qt_conferido is null
                AND qt_cancelada is null
                AND cd_situacao_pedido = 57
)
    PIVOT
    (
    COUNT(TP_PEDIDO)
    FOR GALP  IN ('G1', 'G2', 'G5', 'G6', 'G9')
    ) 
    
             