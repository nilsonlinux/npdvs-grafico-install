 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
IPSERV='192.168'
MGVSERV="6.45"
MGVUSER="moura"
MGVPASS="1712"
#MGVUSER="leandro"
#MGVPASS="150491leo"
RES="1366x725"
OPEN="play $DIR/sounds-alert/window-new.oga"
CLOSE="play $DIR/sounds-alert/window-close.oga"
ERRO="play $DIR/sounds-alert/erro.oga"
CONECTADO="play $DIR/sounds-alert/ok.oga"
########################################################
${OPEN}
########################################################
(
echo "# Testando conexão com MGV SERVER IP - ${IPSERV}.${MGVSERV}" ;
sleep 1
) |
zenity --progress \
  --title="Acesso MGV Server." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################  
if ! ping -c 1 ${IPSERV}.${MGVSERV} >> /dev/null  ; then
${ERRO} | yad --form --title="Informação!" --height=10 --width=500 \
--center --image=$DIR/img/computer-fail.svg \
--borders=10 --button="Sair:0"  \
--text="<span font_weight='bold' font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM MGV.</span>
<span font='20' color='#FF0000'>IP - ${IPSERV}.${MGVSERV} </span>
<span font='15' color='#FFBF00'>O IP solicitado não está acessível para sua conexão.</span>" \
######################################################
else
${CONECTADO} | yad --form --title="Informação!" --height=10 --width=450 \
--center --image=$DIR/img/ok.svg \
--borders=10 --button="Continuar:0"  \
--text="<span font='15' color='#FFBF00'>SUCESSO. MGV CONECTADO.</span>
<span font_weight='bold' font='20' color='#00FF00'>IP - ${IPSERV}.${MGVSERV} </span>
<span font='15' color='#FFBF00'>Abrindo... </span>" \
--timeout=2 --timeout-indicator=left
################################################
rdesktop -g ${RES} -u ${MGVUSER} -p ${MGVPASS} ${IPSERV}.${MGVSERV} -T MGV-SERVER
fi
      break
####################################################################################
${CLOSE}