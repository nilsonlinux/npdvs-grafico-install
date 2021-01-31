 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
  #### Nilsonlinux
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"
  ERRO="play $DIRETORIO/sounds-alert/erro.oga"
  CONECTADO="play $DIRETORIO/sounds-alert/ok.oga"
  #####################################################################################
${OPEN} | yad --title="ACOMPANHAMENTO LOJAS" --height=600 --width=450 --center --borders=5 --no-buttons --form --field="SUPORTE REGIONAL:TXT" "========================================
== ACOMPANHAMENTO ABERTURA - LOJAS  ==
========================================
03 - 
32 - 
39 - 
41 - 
42 - 
47 - 
48 - 
91 - 
99 - 
202-
251-
252-
431-
433-
435-
434-
436-
439-
445-
447-


========================================
=====  PAINEL TERMINAL ELETRO-LOJAS  =====
========================================
55 - 
65 - 
68 - 
69 - 
79 - 
131-
163-
164-
165-
170-
173-
176-
177-
182-
183-


========================================
======  CONSISTENCIA ELETRO-LOJAS   ======
========================================
55 - 
65 - 
68 - 
69 - 
79 - 
131-
163-
164-
165-
170-
173-
176-
177-
182-
183-
"
${CLOSE}