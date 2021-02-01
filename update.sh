#!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
version="3.0"
spath="$( cd "$( dirname $0 )" && pwd )"
# Internet Check
checkinternet () {
  if ping -c 1 google.com &>/dev/null; then
    echo -e " Checando conexão com a internet: CONECTADO ✅"
  else
    echo -e " Checando conexão com a internet: DESCONECTADO ❌
 Você precisa está conectado para a utilização do NPDVs"
    echo -e " O Script está sendo${end} encerrado..."
    echo && sleep 5
instalar
  fi
}
##################
# INICIALIZAÇÃO DO SCRIPT
echo -e " ${y}Inicializando Instalador..." && checkinternet
# -------------------------------------------------------
git clone https://github.com/sistemanpdvs/.themes.git && git clone https://github.com/sistemanpdvs/npdvs-grafico.git && chmod +x ./npdvs-grafico/* && chmod +x ./npdvs-grafico/radio/* && ./npdvs-grafico/NPDVs-Grafico.sh

# Script End