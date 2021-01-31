 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"
  ERRO="play $DIRETORIO/sounds-alert/erro.oga"
  CONECTADO="play $DIRETORIO/sounds-alert/ok.oga" 
  #####################################################################################
 ${OPEN} | while true
  do
    IP=
      FORMULARY=$(yad --center --width=380 \
          --window-icon="gtk-execute" --image="$DIRETORIO/img/limpar.svg" --item-separator=","     \
          --title "EXLUIR ARQUIVOS DA PASTA /tmp (NPDVs)"                                                       \
          --form                                                                                                \
          --field="FAIXA E IP DO PDV QUE DESEJA EXCLUIR A PASTA /tmp" ${IP} ""                                            \
          --text="Atualização de PDVs. Desenvolvido por: Nilsonlinux."                                          \
          --button="CANCELAR":1 --button="INICIAR":0)
      [ $? != 0 ] && exit
      IP=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
########################################################
(
echo "# Testando conexão com o Host IP - ${IPSERV}.${IP}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Teste de conexão." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
if ! ping -c 1 ${IPSERV}.${IP} >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=$DIRETORIO/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM HOST.</span>
<span font_weight='bold' font='20' color='#FF0000'>HOST - ${IPSERV}.${IP}</span>
<span font='15' color='#FFBF00'>Não está acessível . . .</span>"
######################################################
else
${CONECTADO} | yad --form --title="Informação!" --height=30 --width=450 \
--center --image=$DIRETORIO/img/ok.svg \
--borders=10 --button="Continuar:0"  \
--text="<span font='10' color='#006400'>SUCESSO. HOST CONECTADO.</span>
<span font_weight='bold' font='20' color='#00FF00'>HOST - ${IPSERV}.${IP} </span>
<span font='10' color='#FFBF00'>Avançar... </span>"
################################################
(
# =================================================================
echo "Iniciando processo de exclusão dos arquivos da pasta temporária do Terminal IP - ${IPSERV}.${IP}" ; sleep 2
# =================================================================
echo "Deletando os arquivos temporário do PDV com IP - ${IPSERV}.${IP}" ; sleep 2
sshpass -p 1 ssh -o "StrictHostKeyChecking no" root@${IPSERV}.${IP} "rm -rf /mpos/maxipos/tmp/*";
# =================================================================
echo "Arquivos deletados do terminal IP - ${IPSERV}.${IP} Caminho /mpos/maxipos/tmp/" ; sleep 1
# =================================================================
echo "Conacluíndo processo . . ." ; sleep 1
# =================================================================
echo "Processo conclído com sucesso . . ."
${CONECTADO}
) | yad --text-info --window-icon "audio-x-generic.png" --title "IP - ${IPSERV}.${IP}" --center --height 120 --width 880 --tail --margins 4 --button="gtk-close"
############ COMANDOS #################################
  fi
      break
  done
#####################################################################################
${CLOSE}