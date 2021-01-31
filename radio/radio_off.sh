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
  STREAM1='http://playerservices.streamtheworld.com/api/livestream-redirect/KINK.mp3'
########################################################
${OPEN}
pkill mpv
pkill mplayer && exit
####################################################################################
${CLOSE}