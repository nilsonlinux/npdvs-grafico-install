 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  #####################################################################################
  export DIR="$(dirname "$(readlink -f "$0")")"
  ########## VARIÁVEIS ################################################################
  GW1="254"
  GW="254:3390"
  RES="1366x768"
  IPSERV='192.168'
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"  
  #####################################################################################
  ${OPEN} | while true
  do
    IP1=
      FORMULARY=$(yad --center --width=380                                                                                          \
          --window-icon="gtk-execute" --image="$DIR/img/gateway.svg" --item-separator=","                                \
          --title "ACESSO AO SERVIDOR (GATEWAY)"                                                                                    \
          --form                                                                                                                    \
          --field="DIGITE A FAIXA DO GATEWAY" $FAIXA ""                                                                             \
          --text="Gateway filiais."  \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      FAIXA=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
######################################################
(
echo "# Testando conexão com Gateway - ${IPSERV}.${FAIXA}.${GW1}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Acesso gateway." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
if ! ping -c 1 ${IPSERV}.${FAIXA}.${GW1} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=npdvs-grafico/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM GATEWAY SOLICITADO.</span>
<span font_weight='bold' font='20' color='#FF0000'>GATEWAY - ${IPSERV}.${FAIXA}.${GW}</span>
<span font='15' color='#FFBF00'>Não está acessível . . .</span>"
######################################################
else
######################################################
${CONECTADO} | rdesktop -g ${RES} ${IPSERV}.${FAIXA}.${GW} -T GATEWAY
######################################################
fi
      break
  done
######################################################
${CLOSE}