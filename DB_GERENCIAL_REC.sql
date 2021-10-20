WITH T_ETQ AS (
            SELECT cd_produto,
                   nu_nota,
                   cd_fornecedor,
                   cd_agenda,
                   dt_conferencia,
                   qt_conferido,
                   dt_addrow

            FROM t_det_etiqueta

                  WHERE TO_DATE(dt_conferencia) BETWEEN :DATA_INICIO@date AND :DATA_FIM@date
                        AND cd_empresa = 1001
),
    T_FOR AS (
            SELECT cd_fornecedor, 
                   ds_razao_social,
                   cd_uf

            FROM t_fornecedor

                  WHERE cd_empresa = 1001
                        AND NOT REGEXP_LIKE (ds_razao_social, '^A. L.|^CLAUDINO | ^SOCIC - SOCIEDADE | ^J. CLAUDINO')

),
    T_FIS AS (
            SELECT cd_empresa,
                   cd_produto,
                   nu_nota,
                   cd_fornecedor,
                   cd_agenda

            FROM t_det_nota_fiscal

                  WHERE cd_empresa = 1001
),
    T_CPD AS (
            SELECT cd_produto,
                   ds_produto,
                   TO_CHAR(vl_altura * vl_largura * vl_profundidade) AS "CUB"

            FROM  t_cab_produto

                  WHERE tp_produto != 'C'

)


SELECT TO_CHAR(MAX(e.dt_addrow)) AS "DATA DO RECEBIMENTO",
       f.cd_uf AS "UF",
       f.ds_razao_social AS "RAZÃO SOCIAL",
       c.ds_produto AS "DESCRIÇÃO DO PRODUTO",
       TO_CHAR(SUM(e.qt_conferido),'9999999990D99') AS "TOTAL",
       TO_CHAR(SUM(CUB * (e.qt_conferido)),'999999990D99') AS "CUBAGEM"
      
      FROM T_ETQ e
            INNER JOIN T_FOR f
                  ON f.cd_fornecedor = e.cd_fornecedor
            INNER JOIN T_FIS n
                  ON n.cd_fornecedor = f.cd_fornecedor
                  AND n.cd_agenda = e.cd_agenda
                  AND n.nu_nota = e.nu_nota
            INNER JOIN T_CPD c
                  ON c.cd_produto = e.cd_produto
                  AND c.cd_produto = n.cd_produto

GROUP BY f.ds_razao_social, e.cd_produto, c.ds_produto, f.cd_uf

UNION

SELECT ' ', 
       '-----', 
       '---------------------------------------------------------------------------', 
       '---------------------------------------------------------------------------', 
       '--------------------',
       '--------------------'
FROM DUAL

UNION

SELECT ' ', 
       ' ', 
       ' ', 
       '                                                   ' || '                                          TOTAL', 
       TO_CHAR(SUM(ee.qt_conferido), '9999999990D99') AS "TOTAL", 
       TO_CHAR(SUM(CUB * (ee.qt_conferido)),'999999990D99') || ' m³' AS "CUBAGEM"
FROM T_ETQ ee
      INNER JOIN T_FOR ff
            ON ff.cd_fornecedor = ee.cd_fornecedor
      INNER JOIN T_CPD cc
            ON cc.cd_produto = ee.cd_produto

ORDER BY 1 DESC, 3, 4

