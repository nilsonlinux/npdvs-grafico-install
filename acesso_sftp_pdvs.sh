 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  VERMELHO="<span font_weight='bold' font='14' color='#FE2E2E'>" #VERMELHO
  VERDE="<span font_weight='bold' font='10' color='#298A08'>" #VERDE
  CIANO="<span font_weight='bold' font='10' color='#4A90D9'>" #AZUL - CIANNO
  AMARELO="<span font_weight='bold' font='10' color='#FFBF00'>" #AMARELO
  LARANJA="<span font_weight='bold' font='10' color='#FFBF00'>" #DF7401
  AZUL="<span font_weight='bold' font='10' color='#045FB4'>" #DF7401 
  VERDEE="<span font_weight='bold' font='17' color='#5CF30B'>" #verde escuro
  END="</span>"
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"  
  #####################################################################################
${OPEN} | while true
  do
    FAIXA=
      FORMULARY=$(yad --center --width=480 \
          --window-icon="gtk-execute" --image="$DIR/img/sftp.svg" --item-separator=","        \
          --title "ACESSO TERMINAIS SFTP (PASTA MAXIPOS)"                                           \
          --form                                                                                    \
          --field="DIGITE A FAIXA DA FILIAL E IP.  192.168." $FAIXA ""                              \
          --text="Acesso sftp terminais. Desenvolvido por: Nilsonlinux."                            \
          --button="CANCELAR":1 --button="ABRIR":0)
      [ $? != 0 ] && exit
      FAIXA=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
#####################################################################################
(
echo "# Testando conexão com o Terminal IP - ${IPSERV}.${FAIXA}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Acesso SFTP MaxiPOS." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################
if ! ping -c 1 ${IPSERV}.${FAIXA} >> /dev/null ; then
########################################################
${ERRO} | yad --form --title="SEM CONEXÃO" --height=10 --width=450 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="
<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM ESTE TERMINAL.</span>
<span font_weight='bold' font='20' color='#FF0000'>IP - ${IPSERV}.${FAIXA} </span>
<span font='15' color='#FFBF00'>Terminal offline! </span> " 
#####################################################################################
else
${CONECTADO} | nautilus sftp://root@${IPSERV}.${FAIXA}/mpos/maxipos/
fi
      break
  done
#####################################################################################
${CLOSE}