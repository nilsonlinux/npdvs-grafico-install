#!/bin/bash
#
# NPDVs.sh
# Automatização sobre demanda
# Nilsonlinux 30/01/2021
# Colabore com o projeto
export GITHUB_PASSWORD='armateus2020'
export GITHUB_USERNAME='sistemanpdvs'
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  export DIR="$(dirname "$(readlink -f "$0")")"
  #### Nilsonlinux
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
  ALERTA="mpv $DIR/sounds-alert/update.mp3"
  #####################################################################################
  version="3.0"
# Internet Check 
checkinternet () {
  if ping -c 1 8.8.8.8 &>/dev/null; then
    echo " Checando conexão com a internet: CONECTADO ✅"
    NPDVsCheck
  else
    echo " VOCÊ NÃO ESTÁ CONECTADO COM A INTERNET ❌"
  fi
}
########################################################
atualizar () {
( 
${CONECTADO}
echo "Iniciando atualização." ; sleep 1
echo "Conectando com o servidor de atualizações... ⌛️" ; sleep 1
echo "Por favor aguarde... ⌛️" ; sleep 1
datainicial=`date +%s`
rm -rf .themes npdvs-grafico && git clone https://sistemanpdvs:armateus2020@github.com/sistemanpdvs/.themes.git && git clone https://sistemanpdvs:armateus2020@github.com/sistemanpdvs/npdvs-grafico.git && chmod +x ./npdvs-grafico/* && chmod +x ./npdvs-grafico/radio/* && cp npdvs-grafico/Nilsonlinux.desktop Área\ de\ Trabalho/ && ./npdvs-grafico/NPDVs-Grafico.sh""; 
echo "----------------------------------------------------------------" ; sleep 1
echo "Ja estou concluíndo!" ; sleep 1
echo "----------------------------------------------------------------" ; sleep 1
echo
echo "****************************************************************"
echo "***** ATUALIZAÇÃO APLICADA COM SUCESSO **** By: Nilsonlinux ****"
echo "****************************************************************"
echo
datafinal=`date +%s`
soma=`expr $datafinal - $datainicial`
resultado=`expr 10800 + $soma`
tempo=`date -d @$resultado +%H:%M:%S`
echo
${CONECTADO} | echo "🕠 Tempo de execução: $tempo "
) | yad --text-info --window-icon "audio-x-generic.png" --title "INFORMAÇÃO" --center --height 250 --width 780 --tail --margins 4 --button="gtk-close"
}
################################################
${CLOSE}
# New Version Check & Update
NPDVsCheck () {
  changelog=$(curl --silent -q https://raw.githubusercontent.com/sistemanpdvs/npdvs-grafico-install/main/changelog.txt)
  uversion=$(curl --silent -q https://raw.githubusercontent.com/sistemanpdvs/npdvs-grafico-install/main/version.txt)
  if [[ $uversion > $version ]]; then
  echo "              ⚠️⚠️⚠️ Nova versão disponível ⚠️⚠️⚠️

         Versão em uso: $version 🙁 ➤  Nova versão: $uversion 😎

         $changelog 
--------------------------------------------------------------------------
   Copie o comando abaixo e cole em seu terminal para atualizar
--------------------------------------------------------------------------
git clone https://github.com/sistemanpdvs/.themes.git 
&& git clone https://github.com/sistemanpdvs/npdvs-grafico.git 
&& chmod +x ./npdvs-grafico/* && chmod +x ./npdvs-grafico/radio/* 
&& cp npdvs-grafico/Nilsonlinux.desktop Área\ de\ Trabalho/ 
&& ./npdvs-grafico/NPDVs-Grafico.sh
--------------------------------------------------------------------------" | 
yad --text-info --window-icon "audio-x-generic.png" --title "ATUALIZAÇÃO DISPONÍVEL" --center --height 550 --width 670 --tail --margins 4 --button="gtk-close" | ${ALERTA}
atualizar
fi
}
##################
# INICIALIZAÇÃO DO SCRIPT
checkinternet

