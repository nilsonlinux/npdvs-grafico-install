 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  export DIR="$(dirname "$(readlink -f "$0")")"
  #### Nilsonlinux
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
#####################################################################################
 ${OPEN} | while true
  do
    IP=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/ping.svg" --item-separator=","             \
          --title "PING TESTE"                                                                           \
          --form                                                                                         \
          --field="DIGITE O LINK OU IP QUE DESEJA" $IP ""                                                \
          --text="Teste de ping. Desenvolvido por: Nilsonlinux."                                         \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      IP=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
(
echo "# Testando conexão com o Host IP - ${IP}" ;
) |
zenity --progress \
  --title="Teste de conexão." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################

#######################################################
if ! ping -c 1 $IP >> /dev/null ; then 
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM HOST.</span>
<span font_weight='bold' font='20' color='#FF0000'>IP/LINK - $IP</span>
<span font='15' color='#FFBF00'>Não está acessível . . .</span>"
######################################################
else
${CONECTADO} | yad --form --title="Informação!" --height=30 --width=450 --auto-close \
--center --image=$DIR/img/ok.svg \
--borders=10 --button="Continuar:0"  \
--text="<span font='15' color='#FFBF00'>SUCESSO. HOST CONECTADO.</span>
<span font_weight='bold' font='20' color='#00FF00'>IP/LINK - $IP </span>
<span font='15' color='#FFBF00'>Clique no botão Continuar para prosseguir com teste de ping. </span>"
################################################
ping -c 7 ${IP} | yad --text-info --window-icon "audio-x-generic.png" --title "IP - ${IP}" --center --height 300 --width 600 --tail --margins 4 --button="gtk-close"
############ COMANDOS #################################
fi
      break
  done
####################################################################################
${CLOSE}