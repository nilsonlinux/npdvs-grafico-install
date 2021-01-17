 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"
  ERRO="play $DIRETORIO/sounds-alert/erro.oga"
  CONECTADO="play $DIRETORIO/sounds-alert/ok.oga" 
  #####################################################################################
 ${OPEN} |
########################################################
(
echo "# TESTANDO CONEXÃO COM INTERNET." ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Teste de conexão." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
if ! ping -c 1 8.8.8.8 >> /dev/null ; then
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=$DIRETORIO/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font_weight='bold' font='15' color='#1C1C1C'>ERRO! SEM CONEXÃO COM HOST.</span>
<span font_weight='bold' font='20' color='#FF0000'>HOST - ${IPSERV}.${IP}</span>
<span font_weight='bold' font='15' color='#1C1C1C'>Não está acessível . . .</span>"
######################################################
else
${CONECTADO} | yad --form --title="Informação!" --height=30 --width=450 \
--center --image=$DIRETORIO/img/ok.svg \
--borders=10 --button="Continuar:0"  \
--text="<span font_weight='bold' font='10' color='#006400'>SUCESSO. VOCÊ ESTÁ CONECTADO.</span>
<span font_weight='bold' font='10' color='#1C1C1C'>Clique no botão Continuar... </span>"
################################################
(
# =================================================================
echo "Iniciando processo de instalação de suas dependência" ; sleep 2
gnome-terminal -x bash -c "sudo apt install rdesktop yad sox tigervnc-viewer sshpass git && git clone https://github.com/sistemanpdvs/.themes.git && git clone https://github.com/sistemanpdvs/npdvs-grafico.git && chmod +x ./npdvs-grafico/* && chmod +x ./npdvs-grafico/radio/* && cp npdvs-grafico/Nilsonlinux.desktop Área\ de\ Trabalho/ && ./npdvs-grafico/NPDVs-Grafico.sh ; bash" 
# =================================================================
echo "Instalando NPDVs-Gráfico, por favor aguarde..." ; sleep 2
# =================================================================
echo "Processo conclído com sucesso . . ."
${CONECTADO}
) | yad --text-info --window-icon "audio-x-generic.png" --title "EXECUTANDO INSTALAÇÃO . . .AGUARDE..." --center --height 120 --width 880 --tail --button="gtk-close"
############ COMANDOS #################################
  fi
      break
  done
#####################################################################################
${CLOSE}
