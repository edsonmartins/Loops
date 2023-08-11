-- Correções solicitadas por Danielle - Ticket 270971

-- 1º - Adiiona '1' na frente da descrição
DECLARE
 i INTEGER := 0;
 BEGIN
   FOR t IN (
SELECT * FROM CONSINCO.MAP_PRODUTO X WHERE SEQFAMILIA IN (20570,59934,68084,53688,53660,81803,68637,52492,29081,52534,28531,58983,52473,52231,89900,51733,86199,59320,504621,54101,28138,84582,83703,84952,46216,28401,54677,81802,54773,54796,60558,29008,78219,81699,59682,56524,60119,86503,60238,52444,82246,53493,82249,53595,54794,54678,41500,62557,82262,41499,54792,62574,54790,83702,52448,58685,84946,77528,78456,67043,52229,60559,54597,71903,56606,51687,78413,76741,67066,59714,89041,67479,74296,62394,53888,56735,61661,46218,29046,52228,52552,54648,81720,76628,54798,60118,54770,83719,52493,79840,57843,82863,53349,52554,30133,54649,59715,52547,84950,88720,52548,78303,57840,74955,53348,82243,29007,84979,63822,82245,84947,54767,52409,61014,54872,53597,84999,49892,90208,52446,54449,29166,94861,52533,54675,52555,46217,54439,68085,68083,71576,67202,52477,99444,77875,64437,54795,78176,47115,85185,82250,54800,61664,53351,54769,78175,99445,51328,56534,54854,54771,51434,84943,53714,57847,56602,82251,504867,54674,53889,64436,52556,67007,53890,52506,51838,54787,54801,65468,81463,65282,30149,57846,85183,54774,54448,29080,61643,53887,84948,30147,60794,71851,54679,86241,66124,52478,59683,56599,57842,54793,80166,52494,60117,74634,51851,68814,59915,82584,58487,59681,60120,58291,82252,61662,82279,53598,82388,82299,63615,77524,82300,29072,54460,66671,872959,90102,62616,29371,59225,71478,67775,855303,66724,51777,885775,73336,76984,50793,50652,76959,54647,350105)
            )
    LOOP
 BEGIN
       i := i+1;
       UPDATE CONSINCO.MAP_PRODUTO X SET DESCCOMPLETA = '1'||T.DESCCOMPLETA
                                   WHERE X.SEQPRODUTO = T.SEQPRODUTO
                                     AND X.DESCCOMPLETA NOT LIKE '1%';
       IF i = 10 THEN COMMIT;
       i:= 0;
       END IF;
       END;
   END LOOP;
   COMMIT;
END;  

-- 2º - Inativa Produtos para VENDA
DECLARE
 i INTEGER := 0;
 BEGIN
   FOR t IN (
SELECT * FROM CONSINCO.MRL_PRODEMPSEG X WHERE SEQPRODUTO IN (SELECT SEQPRODUTO FROM CONSINCO.MAP_PRODUTO WHERE 
       SEQFAMILIA IN (20570,59934,68084,53688,53660,81803,68637,52492,29081,52534,28531,58983,52473,52231,89900,51733,86199,59320,504621,54101,28138,84582,83703,84952,46216,28401,54677,81802,54773,54796,60558,29008,78219,81699,59682,56524,60119,86503,60238,52444,82246,53493,82249,53595,54794,54678,41500,62557,82262,41499,54792,62574,54790,83702,52448,58685,84946,77528,78456,67043,52229,60559,54597,71903,56606,51687,78413,76741,67066,59714,89041,67479,74296,62394,53888,56735,61661,46218,29046,52228,52552,54648,81720,76628,54798,60118,54770,83719,52493,79840,57843,82863,53349,52554,30133,54649,59715,52547,84950,88720,52548,78303,57840,74955,53348,82243,29007,84979,63822,82245,84947,54767,52409,61014,54872,53597,84999,49892,90208,52446,54449,29166,94861,52533,54675,52555,46217,54439,68085,68083,71576,67202,52477,99444,77875,64437,54795,78176,47115,85185,82250,54800,61664,53351,54769,78175,99445,51328,56534,54854,54771,51434,84943,53714,57847,56602,82251,504867,54674,53889,64436,52556,67007,53890,52506,51838,54787,54801,65468,81463,65282,30149,57846,85183,54774,54448,29080,61643,53887,84948,30147,60794,71851,54679,86241,66124,52478,59683,56599,57842,54793,80166,52494,60117,74634,51851,68814,59915,82584,58487,59681,60120,58291,82252,61662,82279,53598,82388,82299,63615,77524,82300,29072,54460,66671,872959,90102,62616,29371,59225,71478,67775,855303,66724,51777,885775,73336,76984,50793,50652,76959,54647,350105)
               ) AND X.STATUSVENDA = 'A')
    LOOP
 BEGIN
       i := i+1;
       UPDATE CONSINCO.MRL_PRODEMPSEG X SET STATUSVENDA = 'I'
                                      WHERE X.SEQPRODUTO = T.SEQPRODUTO
                                        AND X.NROEMPRESA = T.NROEMPRESA
                                        AND X.STATUSVENDA = 'A';
       IF i = 10 THEN COMMIT;
       i:= 0;
       END IF;
       END;
   END LOOP;
   COMMIT;
END;  

-- 3º - Inativa Produtos para COMPRA

DECLARE
 i INTEGER := 0;
 BEGIN
   FOR t IN (
SELECT * FROM CONSINCO.MRL_PRODUTOEMPRESA X WHERE SEQPRODUTO IN (SELECT SEQPRODUTO FROM CONSINCO.MAP_PRODUTO WHERE 
       SEQFAMILIA IN (20570,59934,68084,53688,53660,81803,68637,52492,29081,52534,28531,58983,52473,52231,89900,51733,86199,59320,504621,54101,28138,84582,83703,84952,46216,28401,54677,81802,54773,54796,60558,29008,78219,81699,59682,56524,60119,86503,60238,52444,82246,53493,82249,53595,54794,54678,41500,62557,82262,41499,54792,62574,54790,83702,52448,58685,84946,77528,78456,67043,52229,60559,54597,71903,56606,51687,78413,76741,67066,59714,89041,67479,74296,62394,53888,56735,61661,46218,29046,52228,52552,54648,81720,76628,54798,60118,54770,83719,52493,79840,57843,82863,53349,52554,30133,54649,59715,52547,84950,88720,52548,78303,57840,74955,53348,82243,29007,84979,63822,82245,84947,54767,52409,61014,54872,53597,84999,49892,90208,52446,54449,29166,94861,52533,54675,52555,46217,54439,68085,68083,71576,67202,52477,99444,77875,64437,54795,78176,47115,85185,82250,54800,61664,53351,54769,78175,99445,51328,56534,54854,54771,51434,84943,53714,57847,56602,82251,504867,54674,53889,64436,52556,67007,53890,52506,51838,54787,54801,65468,81463,65282,30149,57846,85183,54774,54448,29080,61643,53887,84948,30147,60794,71851,54679,86241,66124,52478,59683,56599,57842,54793,80166,52494,60117,74634,51851,68814,59915,82584,58487,59681,60120,58291,82252,61662,82279,53598,82388,82299,63615,77524,82300,29072,54460,66671,872959,90102,62616,29371,59225,71478,67775,855303,66724,51777,885775,73336,76984,50793,50652,76959,54647,350105)
               ) AND X.STATUSCOMPRA = 'A')
    LOOP
 BEGIN
       i := i+1;
       UPDATE CONSINCO.MRL_PRODUTOEMPRESA X SET STATUSCOMPRA = 'I'
                                          WHERE X.SEQPRODUTO = T.SEQPRODUTO
                                            AND X.NROEMPRESA = T.NROEMPRESA
                                            AND X.STATUSCOMPRA = 'A';
       IF i = 10 THEN COMMIT;
       i:= 0;
       END IF;
       END;
   END LOOP;
   COMMIT;
END;  

-- 4º - Deleta fornecedores (não principais)

DECLARE
 i INTEGER := 0;
 BEGIN
   FOR t IN (
     SELECT * FROM CONSINCO.MAP_FAMFORNEC AX WHERE PRINCIPAL != 'S' AND SEQFAMILIA IN (20570,59934,68084,53688,53660,81803,68637,52492,29081,52534,28531,58983,52473,52231,89900,51733,86199,59320,504621,54101,28138,84582,83703,84952,46216,28401,54677,81802,54773,54796,60558,29008,78219,81699,59682,56524,60119,86503,60238,52444,82246,53493,82249,53595,54794,54678,41500,62557,82262,41499,54792,62574,54790,83702,52448,58685,84946,77528,78456,67043,52229,60559,54597,71903,56606,51687,78413,76741,67066,59714,89041,67479,74296,62394,53888,56735,61661,46218,29046,52228,52552,54648,81720,76628,54798,60118,54770,83719,52493,79840,57843,82863,53349,52554,30133,54649,59715,52547,84950,88720,52548,78303,57840,74955,53348,82243,29007,84979,63822,82245,84947,54767,52409,61014,54872,53597,84999,49892,90208,52446,54449,29166,94861,52533,54675,52555,46217,54439,68085,68083,71576,67202,52477,99444,77875,64437,54795,78176,47115,85185,82250,54800,61664,53351,54769,78175,99445,51328,56534,54854,54771,51434,84943,53714,57847,56602,82251,504867,54674,53889,64436,52556,67007,53890,52506,51838,54787,54801,65468,81463,65282,30149,57846,85183,54774,54448,29080,61643,53887,84948,30147,60794,71851,54679,86241,66124,52478,59683,56599,57842,54793,80166,52494,60117,74634,51851,68814,59915,82584,58487,59681,60120,58291,82252,61662,82279,53598,82388,82299,63615,77524,82300,29072,54460,66671,872959,90102,62616,29371,59225,71478,67775,855303,66724,51777,885775,73336,76984,50793,50652,76959,54647,350105)
            )
    LOOP
 BEGIN
       i := i+1;
       DELETE FROM CONSINCO.MAP_FAMFORNEC X WHERE X.SEQFAMILIA = T.SEQFAMILIA
                                              AND X.PRINCIPAL != 'S';
       IF i = 10 THEN COMMIT;
       i:= 0;
       END IF;
       END;
   END LOOP;
   COMMIT;
END;  
 
-- 5º - Altera fornec principal para o Fornec 114241

DECLARE
 i INTEGER := 0;
 BEGIN
   FOR t IN (
     SELECT * FROM CONSINCO.MAP_FAMFORNEC AX WHERE PRINCIPAL = 'S' AND SEQFAMILIA IN (20570,59934,68084,53688,53660,81803,68637,52492,29081,52534,28531,58983,52473,52231,89900,51733,86199,59320,504621,54101,28138,84582,83703,84952,46216,28401,54677,81802,54773,54796,60558,29008,78219,81699,59682,56524,60119,86503,60238,52444,82246,53493,82249,53595,54794,54678,41500,62557,82262,41499,54792,62574,54790,83702,52448,58685,84946,77528,78456,67043,52229,60559,54597,71903,56606,51687,78413,76741,67066,59714,89041,67479,74296,62394,53888,56735,61661,46218,29046,52228,52552,54648,81720,76628,54798,60118,54770,83719,52493,79840,57843,82863,53349,52554,30133,54649,59715,52547,84950,88720,52548,78303,57840,74955,53348,82243,29007,84979,63822,82245,84947,54767,52409,61014,54872,53597,84999,49892,90208,52446,54449,29166,94861,52533,54675,52555,46217,54439,68085,68083,71576,67202,52477,99444,77875,64437,54795,78176,47115,85185,82250,54800,61664,53351,54769,78175,99445,51328,56534,54854,54771,51434,84943,53714,57847,56602,82251,504867,54674,53889,64436,52556,67007,53890,52506,51838,54787,54801,65468,81463,65282,30149,57846,85183,54774,54448,29080,61643,53887,84948,30147,60794,71851,54679,86241,66124,52478,59683,56599,57842,54793,80166,52494,60117,74634,51851,68814,59915,82584,58487,59681,60120,58291,82252,61662,82279,53598,82388,82299,63615,77524,82300,29072,54460,66671,872959,90102,62616,29371,59225,71478,67775,855303,66724,51777,885775,73336,76984,50793,50652,76959,54647,350105)
            )
    LOOP
 BEGIN
       i := i+1;
       UPDATE CONSINCO.MAP_FAMFORNEC X SET SEQFORNECEDOR = 114241,
                                           USUARIOALTERACAO = 'GLPI270971',
                                           DATAHORAALTERACAO = SYSDATE
                                     WHERE X.SEQFAMILIA = T.SEQFAMILIA
                                       AND X.PRINCIPAL = 'S';
       IF i = 10 THEN COMMIT;
       i:= 0;
       END IF;
       END;
   END LOOP;
   COMMIT;
END;  
  
-- 5º - Remove Cad Cod Fornec

DECLARE
 i INTEGER := 0;
 BEGIN
   FOR t IN (
     SELECT * FROM CONSINCO.MAP_PRODCODIGO P WHERE SEQPRODUTO IN (SELECT SEQPRODUTO FROM CONSINCO.MAP_PRODUTO WHERE SEQFAMILIA IN (20570,59934,68084,53688,53660,81803,68637,52492,29081,52534,28531,58983,52473,52231,89900,51733,86199,59320,504621,54101,28138,84582,83703,84952,46216,28401,54677,81802,54773,54796,60558,29008,78219,81699,59682,56524,60119,86503,60238,52444,82246,53493,82249,53595,54794,54678,41500,62557,82262,41499,54792,62574,54790,83702,52448,58685,84946,77528,78456,67043,52229,60559,54597,71903,56606,51687,78413,76741,67066,59714,89041,67479,74296,62394,53888,56735,61661,46218,29046,52228,52552,54648,81720,76628,54798,60118,54770,83719,52493,79840,57843,82863,53349,52554,30133,54649,59715,52547,84950,88720,52548,78303,57840,74955,53348,82243,29007,84979,63822,82245,84947,54767,52409,61014,54872,53597,84999,49892,90208,52446,54449,29166,94861,52533,54675,52555,46217,54439,68085,68083,71576,67202,52477,99444,77875,64437,54795,78176,47115,85185,82250,54800,61664,53351,54769,78175,99445,51328,56534,54854,54771,51434,84943,53714,57847,56602,82251,504867,54674,53889,64436,52556,67007,53890,52506,51838,54787,54801,65468,81463,65282,30149,57846,85183,54774,54448,29080,61643,53887,84948,30147,60794,71851,54679,86241,66124,52478,59683,56599,57842,54793,80166,52494,60117,74634,51851,68814,59915,82584,58487,59681,60120,58291,82252,61662,82279,53598,82388,82299,63615,77524,82300,29072,54460,66671,872959,90102,62616,29371,59225,71478,67775,855303,66724,51777,885775,73336,76984,50793,50652,76959,54647,350105)
           ) AND P.TIPCODIGO = 'F')
    LOOP
 BEGIN
       i := i+1;
       DELETE FROM CONSINCO.MAP_PRODCODIGO X WHERE X.SEQPRODUTO = T.SEQPRODUTO
                                               AND X.TIPCODIGO  = 'F';
       
       IF i = 10 THEN COMMIT;
       i:= 0;
       END IF;
       END;
   END LOOP;
   COMMIT;
END;  