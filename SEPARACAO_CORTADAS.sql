DEFINE SHED =: SHEDD@VARCHAR2
DEFINE DATA =: DATAA@VARCHAR2

WITH VMSE AS (
	SELECT dt_separacao,
		   cd_produto,
		   cd_endereco,
		   tp_pedido,
		   cd_situacao_contenedor,
		   cd_situacao_pedido,
		   qt_produto,
		   qt_separado,
		   qt_conferido,
		   qt_cancelada,
		   id_separado,
		   id_cancelado,
		   id_conferido,
		   dt_conferencia

	FROM v_monitor_separacao_expedicao

		WHERE  TO_CHAR(dt_liberacao_onda) BETWEEN '&DATAA@DataInicial' AND '&DATAA@DataFinal'
			   AND cd_situacao_pedido = 68 
			   AND qt_cancelada is not null
			   AND dt_separacao is not null
),

	T_CPD AS (

	SELECT cd_produto,
		   ds_produto,
		   TO_CHAR(vl_altura * vl_largura * vl_profundidade) AS "CUB"

	FROM t_cab_produto

		WHERE tp_produto != 'C'
)


SELECT 'G' || MAX(SUBSTR(v.cd_endereco, 1, 1)) AS "GALPÃO",
	   TO_CHAR(MAX(v.dt_separacao)) AS "DATA DO CORTE",
	   v.cd_produto AS "NCE",
	   c.ds_produto AS "DESCRIÇÃO DO PRODUTO",
	   TO_CHAR(SUM(v.qt_cancelada)) AS "TOTAL DE PRODUTOS CORTADOS",
	   TO_CHAR(SUM(CUB * (v.qt_cancelada)), '9999990D99') AS "CUBAGEM"

	FROM VMSE v
		INNER JOIN T_CPD c
			ON v.cd_produto = c.cd_produto

GROUP BY v.cd_produto,
		 c.ds_produto

UNION

SELECT '', 
	   ' ', 
	   '-------', 
	   '-------', 
	   '-------', 
	   '-------'

	FROM DUAL

UNION

SELECT '', 
	   ' ', 
	   ' ', 
	   'TOTAL', 
	    TO_CHAR(SUM(vv.qt_cancelada)) AS "TOTAL DE PRODUTOS CORTADOS", 
	    TO_CHAR(SUM(CUB * (qt_cancelada)), '9999990D99') AS "CUBAGEM"

	FROM VMSE vv
		INNER JOIN T_CPD cc
			ON vv.cd_produto = cc.cd_produto
         
ORDER BY 1, 2 DESC, 4