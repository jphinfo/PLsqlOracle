WITH VMSE AS (
	SELECT nu_pedido_origem,
	       nu_separacao,
		   qt_produto,
		   qt_separado,
		   id_distribuicao,
		   qt_conferido,
		   dt_conferencia

		FROM v_monitor_separacao_expedicao

			WHERE dt_liberacao_onda BETWEEN (SYSDATE - 21) AND SYSDATE
)


SELECT SUBSTR(v.nu_pedido_origem, 1, 3) AS "PDV",
       TO_CHAR(v.nu_separacao) AS "ONDA",
	   TO_CHAR(SUM(v.qt_produto)) AS "QTD PEDIDO",
	   TO_CHAR(SUM(v.qt_separado)) AS "QTD SEPARADO",
	   'LACRACAO' AS "LACRADO",
       TO_CHAR(COUNT(v.id_distribuicao)) AS "DISTRIBUIDO",
	   TO_CHAR(SUM(v.qt_conferido)) AS "QTD CONFERIDO",
       TO_CHAR(MAX(v.dt_conferencia)) AS "ULTIMA CONFERÊNCIA"
	   

  FROM VMSE v

GROUP BY SUBSTR(v.nu_pedido_origem, 1, 3), v.nu_separacao

HAVING SUM(v.qt_separado) != SUM(qt_conferido)

UNION

SELECT '------',
	   '------',
	   '------',
	   '------',
	   '------',
	   '------',
	   '------',
	   '------  '
  FROM DUAL

UNION

SELECT 'TOTAL: ' || TO_CHAR(COUNT(DISTINCT(SUBSTR(vv.nu_pedido_origem, 1, 3)))),
	   ' ',
	   ' ',
	   ' ',
	   ' ',
	   ' ',
	   ' ',
	   ' '
  FROM VMSE vv, DUAL
  WHERE vv.qt_separado is not null
        AND  vv.qt_conferido is not null
  
ORDER BY 8 DESC


