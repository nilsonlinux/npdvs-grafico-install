 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
######################################################## 
  STREAM='http://servidor29-3.brlogic.com:8586/live'
  NRADIO='Rádio RocKMetal'
  pkill mpv
  pkill mplayer
########################################################
${OPEN}
########################################################
(
echo "Testando conexão com a webradio - ${NRADIO}" ; sleep 1
) |
zenity --progress \
  --title="Acessando ${NRADIO}." \
  --text="Verificando conexão com ${NRADIO} ..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################   
if ! ping -c 1 8.8.8.8 >> /dev/null ; then
${ERRO} | yad --form --title="VOCÊ ESTÁ SEM CONEXÃO A INTERNET" --height=10 --width=600 \
--center --image=$DIR/img/erro.svg \
--borders=10 \
--button="Sair:" 'exit' \
--text="<span font_weight='bold' font='10' color='#1C1C1C'>ERRO! SEM CONEXÃO.</span>
<span font_weight='bold' font='20' color='#FF0000'>Reveja suas configurações de conexão</span>
<span font_weight='bold' font='10' color='#1C1C1C'>Sem internet! ou servidor indisponível...</span>" \
########################################################
else
########################################################
${CONECTADO} | mplayer ${STREAM} -msglevel all=4 | yad --text-info --window-icon "audio-x-generic.png" --title "Rádio - ${NRADIO}" --center --height 300 --width 750 --tail --margins 4 --button="gtk-close"
fi
      break
####################################################################################
${CLOSE}