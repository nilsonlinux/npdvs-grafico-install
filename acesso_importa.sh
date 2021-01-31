 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IMPORTA="pdvmaxipos.mateus"
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"  
  #####################################################################################
  #### Get informations
  ${OPEN}
########################################################
(
echo "# Testando conexão com o servidor - ${IMPORTA}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Aguarde..." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
if ! ping -c 1 ${IMPORTA} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=10 --width=450 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="
<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM IMPORTA.</span>
<span font_weight='bold' font='20' color='#FF0000'>IP - ${IPSERV}.${FAIXA_IP} </span>
<span font='15' color='#FFBF00'>Terminal offline! </span> " 
######################################################
else
################################################
${CONECTADO} | gnome-terminal -x bash -c "sshpass -p importa ssh -oStrictHostKeyChecking=no importa@${IMPORTA}; bash"
fi
      break
  done
#####################################################################################
${CLOSE}