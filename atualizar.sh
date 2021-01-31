 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  export DIR="$(dirname "$(readlink -f "$0")")"
  #### Nilsonlinux
  IPSERV='192.168'
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
  #####################################################################################
  ${OPEN} | while true
  do
    IP=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/atualizar_pdvs.svg" --item-separator=","   \
          --title "ATUALIZAÇÃO DE PDVS (NPDVs)" \
          --form \
          --field="FAIXA E IP DO PDV QUE DESEJA ATUALIZAR" $IP ""  \
          --text="Atualização de PDVs. Desenvolvido por: Nilsonlinux."  \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      IP=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
(
echo "# Testando conexão com o Terminal IP - ${IPSERV}.${IP}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Teste de conexão." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################
if ! ping -c 1 ${IPSERV}.${IP} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM TERMINAL.</span>
<span font_weight='bold' font='20' color='#FF0000'>TERMINAL IP - ${IPSERV}.${IP}</span>
<span font='15' color='#FFBF00'>Não está acessível . . .</span>"
########################################################
else
########################################################
(
${CONECTADO}
echo "-------------------- INICIANDO COMANDO [TERMINAL IP - ${IPSERV}.${IP}] -------------------" ; sleep 1
echo "Inicializando comando para atualização do terminal. ⏳" ; sleep 1
echo "----------------------------------------------------------------" ; sleep 1
echo "Atualizando Terminal IP - ${IPSERV}.${IP}" ; sleep 1
echo "----------------------------------------------------------------" ; sleep 1
tempoinicial=`date +%s`
sshpass -p 1 ssh -o "StrictHostKeyChecking no" root@${IPSERV}.${IP} "it-update-pdv.sh";
echo "Terminal atualizado com sucesso..." ; sleep 1
echo "Processo de atualização finalizado." ; sleep 1
echo "----------------------------------------------------------------" ; sleep 1
echo "Reiniciando Terminal IP - ${IPSERV}.${IP}" ; sleep 1
sshpass -p 1 ssh -o "StrictHostKeyChecking no" root@${IPSERV}.${IP} "reboot";
echo "Terminal reiniciado com sucesso. Por favor aguarde o processo de reinicialização. ⌛️" ; sleep 1
echo "----------------------------------------------------------------" ; sleep 1
echo "Feito! Terminal com IP - ${IPSERV}.${IP} Atualizado." ; sleep 1
echo "----------------------------------------------------------------" ; sleep 1
echo
echo "****************************************************************"
echo "***** COMANDO FINALIZADO COM SUCESSO ***** By: Nilsonlinux *****"
echo "****************************************************************"
echo
tempofinal=`date +%s`
soma=`expr $tempofinal - $tempoinicial`
resultado=`expr 10800 + $soma`
tempo=`date -d @$resultado +%H:%M:%S`
echo
${CONECTADO} | echo "🕠 Tempo de atualização: $tempo "
) | yad --text-info --window-icon "audio-x-generic.png" --title "Informação de processo de atualização. IP - ${IPSERV}.${IP}" --center --height 250 --width 850 --tail --margins 4 --button="gtk-close"
########################################################
    fi
      break
  done
########################################################
${CLOSE}