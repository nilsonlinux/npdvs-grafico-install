 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  IMG="/home/$USER/npdvs-grafico/radio/icons"
  #####################################################################################
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
######################################################## 
  STREAM='http://stream.zeno.fm/swfzb6sw1f8uv'
  NRADIO='Nilsonlinux Web Radio'
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
  --image-on-top             \
--center --image=$IMG/quit.png \
--borders=10 \
--button="Sair:" 'exit' \
--text="<span font_weight='bold' font='10' color='#1C1C1C'>ERRO! SEM CONEXÃO.</span>
<span font_weight='bold' font='20' color='#FF0000'>Reveja suas configurações de conexão</span>
<span font_weight='bold' font='10' color='#1C1C1C'>Sem internet! ou servidor indisponível...</span>" \
########################################################
else
########################################################
${CONECTADO} | mplayer ${STREAM} -msglevel all=0 | yad --form --title="${NRADIO}" --height=495 --width=300 \
--center --borders=5 --no-buttons \
--image-on-top             \
--image="$IMG/nilsonlinux.jpg" \
--columns=3 \
--field="   !$IMG/pause_play.png!<span color='#5CF30B' font_weight='bold'>Acesso MGV Server</span>":BTN $DIR/radio_off.sh \
--field="   !$IMG/quit.png!<span color='#5CF30B' font_weight='bold'>Acesso MGV Server</span>":BTN $DIR/radio_off.sh \
--field="   !$IMG/pause_play.png!<span color='#5CF30B' font_weight='bold'>Acesso MGV Server</span>":BTN $DIR/radio_off.sh \
--scroll "auto" /
fi 
break
 ${CLOSE}
 