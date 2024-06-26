-----------------
--CONSULTAS SQL--
-----------------


SELECT T.NOME, COUNT(*)
FROM CAMINHAOMOTORISTA C INNER JOIN TRANSPORTADORA T
     ON C.CIPJTRANS = T.CIPJTRANS
GROUP BY T.NOME
HAVING COUNT(*) > 2;

SELECT PLACA, NOME
FROM CAMINHAOMOTORISTA C INNER JOIN TRANSPORTADORA T
	ON C.CIPJTRANS = T.CIPJTRANS;

SELECT CIPJDEP, CIPJLOJA, NOME
FROM DEPLOJA DL LEFT OUTER JOIN TRANSPORTADORA T
	ON DL.CIPJTRANS = T.CIPJTRANS;

SELECT T.CIPJTRANS
FROM TRANSPORTADORA T
WHERE EXISTS
	(SELECT *
	 FROM CAMINHAOMOTORISTA C
	 WHERE C.CIPJTRANS = T.CIPJTRANS);

SELECT T.CIPJTRANS
FROM TRANSPORTADORA T
WHERE NOT EXISTS
	(SELECT *
	 FROM CAMINHAOMOTORISTA C
	 WHERE C.CIPJTRANS = T.CIPJTRANS);

SELECT C.PLACA
FROM CAMINHAOMOTORISTA C
WHERE C.CIPJTRANS =
	(SELECT CIPJTRANS
	 FROM TRANSPORTADORA
	 WHERE NOME = 'LOGGI');

SELECT CIPJDEP
FROM DEPLOJA D INNER JOIN LOJA L
     ON D.CIPJLOJA = L.CIPJLOJA
WHERE (END_ESTADO, END_RUA) =
	(SELECT END_ESTADO, END_RUA
	 FROM LOJA
	 WHERE CIPJLOJA = '1223');

SELECT L.NOME
FROM LOJA L
WHERE L.CIPJLOJA IN 
	(SELECT C.CIPJLOJA
	 FROM COMPRA C
	 WHERE C.CPFCLI = '1100');

SELECT *
FROM
(SELECT CIPJMARK
 FROM MARKETING
 WHERE CIPJMATRIZ IS NOT NULL
)
INTERSECT
(SELECT CIPJMARK
 FROM ANUNCIO
 WHERE TIPO = 'Instagram'
);
