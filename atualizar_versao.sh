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
  #####################################################################################
  ${OPEN} | while true
  do
    IP1=
    IP2=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIR/img/atualizar_versao.svg" --item-separator=","  \
          --title "Atualizador de versão (NPDVs)"                                      \
          --form                                                                       \
          --field="IP DO PDV COM PROBLEMA" $IP1 ""            \
          --field="IP DE UM PDV FUNCIONANDO 100%" $IP2 ""                                    \
          --text="================================================================= Atualizador de versão. Desenvolvido por: Nilsonlinux Preencha os campos abaixo, referêntes aos ips dos PDVs que deseja copiar os arquivos. ================================================================="  \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      IP1=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
      IP2=$(echo $FORMULARY     | awk -F '|' '{ print $2 }')
########################################################
(
# =================================================================
${CONECTADO} | echo "INICIANDO PROCESSO..." ; sleep 1
# =================================================================
echo "Copiando a pasta bin do Terminal ${IP1} para o local ${IP2}/mpos/maxipos/pos/bin/" ; sleep 1
tempoinicial=`date +%s`
sshpass -p '1' ssh root@$IP1 sshpass -p '1' scp -o \"StrictHostKeyChecking no\"  /mpos/maxipos/pos/bin/* root@$IP2:/mpos/maxipos/pos/bin/
# =================================================================
echo "Copiando a pasta lib do Terminal IP ${IP1} para o local ${IP2}/mpos/maxipos/pos/lib/" ; sleep 1
sshpass -p '1' ssh root@$IP1 sshpass -p '1' scp /mpos/maxipos/pos/lib/*  root@$IP2:/mpos/maxipos/pos/lib/
# =================================================================
echo "Reiniciando Terminal IP - ${IP1}" ; sleep 1
sshpass -p '1' ssh root@$IP1 "reboot && exit"
sleep 1
echo "Concluíndo..." ; sleep 1
sleep 1
echo "Feito! Pastas copiadas para o Terminal com IP - $IP1" ; sleep 1
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