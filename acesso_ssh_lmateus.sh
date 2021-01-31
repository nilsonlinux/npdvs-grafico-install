 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"  
  #####################################################################################
  #### Get informations
  ${OPEN} | while true
  do
    FAIXA_IP=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/ssh.svg" --item-separator=","           \
          --title "ACESSO SSH (GMLINUX)"                                                                   \
          --form                                                                                         \
          --field="DIGITE A FAIXA E O FINAL DO IP máquina com GMLINUX" $FAIXA_IP ""                    \
          --text="Acesso SSH por faixa e ip para GMLINUX. Desenvolvido por: Nilsonlinux."                             \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      FAIXA_IP=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
(
echo "# Testando conexão com o IP - ${IPSERV}.${FAIXA_IP}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Aguarde..." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
if ! ping -c 1 ${IPSERV}.${FAIXA_IP} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=10 --width=450 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="
<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM ESTA MÁQUINA GMLINUX.</span>
<span font_weight='bold' font='20' color='#FF0000'>IP - ${IPSERV}.${FAIXA_IP} </span>
<span font='15' color='#FFBF00'>IP offline! </span> " 
######################################################
else
################################################
${CONECTADO} | gnome-terminal -x bash -c "sshpass -p netuno23 ssh -oStrictHostKeyChecking=no admin@${IPSERV}.${FAIXA_IP}; bash"
fi
      break
  done
#####################################################################################
${CLOSE}