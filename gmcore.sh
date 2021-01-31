 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  GMCORE='6.36'
  RES="1310x750"
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
  LOG=$DIR/log/gmcore.log
########################################################
${OPEN}
########################################################
(
echo "# Testando conexão com Gmcore IP - ${IPSERV}.${GMCORE}" ; sleep 1
) |
zenity --progress \
  --title="Acesso GMCORE." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################   
if ! ping -c 1 ${IPSERV}.${GMCORE} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=10 --width=300 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM GMCORE.</span>
<span font_weight='bold' font='20' color='#FF0000'>IP - ${IPSERV}.${GMCORE} </span>
<span font='15' color='#FFBF00'>O IP solicitado não está acessível para sua conexão.</span>" \
######################################################
else
${CONECTADO} | yad --form --title="Informação!" --height=10 --width=450 \
--center --image=$DIR/img/ok.svg \
--borders=10 --button="Continuar:0"  \
--text="<span font='15' color='#FFBF00'>SUCESSO. GMCORE CONECTADO.</span>
<span font_weight='bold' font='20' color='#00FF00'>IP - ${IPSERV}.${GMCORE} </span>
<span font='15' color='#FFBF00'>Clique no botão Continuar para prosseguir com acesso GMCORE. </span>" \
--timeout=2 --timeout-indicator=right
################################################
rdesktop -g ${RES} ${IPSERV}.${GMCORE} -T GMCORE >> $LOG
fi
      break
####################################################################################
${CLOSE}