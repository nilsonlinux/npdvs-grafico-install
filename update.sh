#!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
version="3.0"
spath="$( cd "$( dirname $0 )" && pwd )"
# Internet Check
checkinternet () {
  if ping -c 1 google.com &>/dev/null; then
    echo  " Checando conexão com a internet..."
     echo  " Status: CONECTADO ✅"   
  else
    echo " Checando conexão com a internet: DESCONECTADO ❌
         Checando conexão com a internet: DESCONECTADO ❌ 
 Você precisa está conectado para a utilização do NPDVs
     O Script está sendo${end} encerrado..."
    echo && sleep 5
ping -c 5 8.8.8.8
  fi
}
##################
# INICIALIZAÇÃO DO SCRIPT
echo "Inicializando Instalador..." && checkinternet
