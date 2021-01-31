 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  FX='254'
  CUPS='254:631/'
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
  #####################################################################################
  ${OPEN} | while true
  do
    FAIXA=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/cups.svg" --item-separator=","              \
          --title "ACESSO CUPS (NPDVs)"                                                                   \
          --form                                                                                          \
          --field="DIGITE A FAIXA DA FILIAL QUE DESEJA ACESSO AO CUPS" $FAIXA ""                          \
          --text="Acesso CUPS por faixa. Desenvolvido por: Nilsonlinux."                                  \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      FAIXA=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
########################################################
(
echo "# Testando conexão com CUPS - ${IPSERV}.${FAIXA}.${FX}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Acesso CUPS." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################  
########################################################  
if ! ping -c 1 ${IPSERV}.${FAIXA}.${FX} >> /dev/null  ; then
${ERRO} | yad --form --title="Informação" --height=10 --width=500 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#00BFFF'>ERRO! SEM CONEXÃO COM CUPS INFORMADO.</span>
<span font='15' color='#00BFFF'>--------------------------------------------------------</span>
<span font_weight='bold' font='20' color='#FF0000'>${IPSERV}.${FAIXA}.${CUPS} </span>
<span font='15' color='#00BFFF'>--------------------------------------------------------</span>
<span font='15' color='#00BFFF'>O IP do CUPS solicitado não está acessível para sua conexão.</span>" \
######################################################
else
#################PROGRESSO BAR##########################
${CONECTADO} | xdg-open http://${IPSERV}.${FAIXA}.${CUPS}
fi
      break
  done
#####################################################################################
${CLOSE}