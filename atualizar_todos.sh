 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  PDVS_IPS='6 100'
  IPSERV='192.168'
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
  #####################################################################################
  ${OPEN} | while true
  do
    FAIXA=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/atualizar_pdvs.svg" --item-separator=","   \
          --title "ATUALIZAÇÃO DE PDVS (NPDVs)" \
          --form \
          --field="FAIXA DA FILIAL QUE DESEJA ATUALIZAR" $FAIXA ""  \
          --text="Atualização de PDVs. Desenvolvido por: Nilsonlinux."  \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      FAIXA=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
(
  ${PDVS_IPS}
for PDVS_IPS in ${PDVS_IPS}
do
sleep 1
${CONECTADO} | echo "============== INICIANDO COMANDO [TERMINAL IP - ${IPSERV}.${FAIXA}.${PDVS_IPS}] ==============" ; sleep 1
echo "[`date`] ==== Inicio de atualização PDV IP - ((( ${IPSERV}.${FAIXA}.${PDVS_IPS} ))) ..." >> $LOG
echo "Atualizando PDV IP - ((( ${IPSERV}.${FAIXA}.${PDVS_IPS} ))) ⏳" ; >> $LOG
tempoinicial=`date +%s`
sshpass -p 1 ssh -o "StrictHostKeyChecking no" root@${IPSERV}.${FAIXA}.${PDVS_IPS} "it-update-pdv.sh"; >> $LOG
echo "----------------------------------------------" ; sleep 1
echo "Reiniciando PDV IP - ((( ${IPSERV}.${FAIXA}.${PDVS_IPS} ))) ⌛️" ; >> $LOG
echo "==============================================" ; sleep 1
sshpass -p 1 ssh -o "StrictHostKeyChecking no" root@${IPSERV}.${FAIXA}.${PDVS_IPS} "reboot"; >> $LOG
echo "[`date`] ==== Fim de atualização PDV IP - ((( ${IPSERV}.${FAIXA}.${PDVS_IPS} ))) ..." >> $LOG
echo && echo " " 
done
sleep 1
echo "Concluíndo..." ; sleep 1
sleep 1
echo "Feito! Terminais atualizados e reiniciados" ; sleep 1
echo
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "---------------- COMANDO FINALIZADO COM SUCESSO ----------------"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "-- By: Nilsonlinux ---------------------------------------------"
tempofinal=`date +%s`
soma=`expr $tempofinal - $tempoinicial`
resultado=`expr 10800 + $soma`
tempo=`date -d @$resultado +%H:%M:%S`
echo
${CONECTADO} | echo "🕠 Tempo de atualização: $tempo "
) | yad --text-info --window-icon "audio-x-generic.png" --title "Informação de processo de atualização. Terminais" --center --height 500 --width 850 --tail --margins 4 --button="gtk-close"
################################################
      break
  done
################################################
${CLOSE}