#!/bin/bash
#
# NPDVs.sh
# Automatização sobre demanda
# Nilsonlinux 30/01/2021
# Colabore com o projeto
 export DIR="$(dirname "$(readlink -f "$0")")"
 ALERTA="mpv $DIR/sounds-alert/update.mp3"
 ERRO="play $DIR/sounds-alert/erro.oga"
# -------------------------------------------------------
version="2.9"
# Internet Check 
checkinternet () {
  if ping -c 1 8.8.8.8 &>/dev/null; then
    echo " Checando conexão com a internet: CONECTADO ✅"
    NPDVsCheck
  else
    echo " VOCÊ NÃO ESTÁ CONECTADO COM A INTERNET ❌
 AO FECHAR ESTA JANELA VOCÊ INICIARÁ O NPDVS MESMO
 SEM CONEXÃO...
 AVISO! OS COMANDOS DE ACESSO NÃO IRÃO FUNCIONAR." | yad --text-info --window-icon "audio-x-generic.png" --title "VOCÊ ESTÁ SEM CONEXÃO . . ." --center --height 135 --width 450 --tail --margins 4 --button="gtk-close" | ${ERRO}
    NPDVsExit
  fi
}
##################
# New Version Check & Update
NPDVsUpdate () {
  logoNPDVs
  echo " Preparando atualização NPDVs"
  echo && echo " Precione ENTER para continuar"
  read input
  echo && echo " Atualizando }NPDVs, Por favor aguarde..."
  rm -rf npdvs_admin && git clone https://github.com/sistemanpdvs/npdvs_admin.git && chmod +x ./npdvs_admin/npdvs.sh
  sleep 1 && echo " NPDVs Atualização aplicada com sucesso "
  sleep 1 && echo " Restartando NPDVs..."
  sleep 2
  NPDVsStart
}
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
--------------------------------------------------------------------------" | yad --text-info --window-icon "audio-x-generic.png" --title "ATUALIZAÇÃO DISPONÍVEL . . ." --center --height 550 --width 670 --tail --margins 4 --button="gtk-close" | ${ALERTA}
fi
}
##################
# INICIALIZAÇÃO DO SCRIPT
checkinternet