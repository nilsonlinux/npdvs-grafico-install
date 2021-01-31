 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  GT="254"
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"  
  #####################################################################################
  ${OPEN} | while true
  do
    FAIXA=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/ssh_gateway.svg" --item-separator=","       \
          --title "ACESSO SSH (GATEWAY)"                                                                     \
          --form                                                                                             \
          --field="DIGITE A FAIXA DO GATEWAY QUE DESEJA ACESSO SSH" $FAIXA ""                                \
          --text="Acesso SSH por faixa Gateway. Desenvolvido por: Nilsonlinux."                              \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      FAIXA=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
########################################################
(
echo "# Testando conexão com o IP - ${IPSERV}.${FAIXA}.${GT}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Aguarde..." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
#######################################################
if ! ping -c 1 ${IPSERV}.${FAIXA}.${GT} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM HOST.</span>
<span font_weight='bold' font='20' color='#FF0000'>GATEWAY - ${IPSERV}.${FAIXA}.${GT}</span>
<span font='15' color='#FFBF00'>Não está acessível . . .</span>"
######################################################
else
${CONECTADO} | gnome-terminal -x bash -c "sshpass -p 'aser1515' ssh -oStrictHostKeyChecking=no suporte@${IPSERV}.${FAIXA}.${GT}; bash"
#####################################################################################
fi
 break
done
#####################################################################################
${CLOSE}