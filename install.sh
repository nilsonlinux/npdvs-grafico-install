 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
version="3.1"
spath="$( cd "$( dirname $0 )" && pwd )"
a='\033[1;33m'       # Amarelo
p='\033[0;35m'       # Purple
v="\033[0;31m"       #vermelho
vr="\033[01;32m"      #Verde
br="\033[0;37m"      #Branco
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
end='\033[0m'
#LVARIÁVEIS TERMINAIS LOJA =========
logoNPDVs () {
  clear
  echo -e "${vr} 
      NPDVS-GRÁFICO - INSTALADOR MODO TEXTO
             ${r} NILSONLINUX © ${y}2021
                  ${y}Versão :${end}${bu} ${version}${end}"
    echo
}
# NPDVs
# Exit CliPDVs
NPDVsExit () {
  logoNPDVs 
  echo -e " Você encerrou o instalador. Saindo... ${b}NPDVs${end}
 Desenvolvido por: Nilsonlinux.
 ${b}Telegram -➤ ${bu}https://t.me/nilsonlinux${end}"
  echo && sleep 1
  exit
}

# APT Update
#aptgupd () {
#  echo && echo -e " ${y}Preparing To Perform APT Update${endc}"
#  echo " It Is Recommended To Perform APT Update"
#  echo " Before You Install Any Application."
#  echo -en " ${y}Would You Like To Perform APT Update Now ? {y/n}${endc} "
#  read option
#  case $option in
#    y) ;;
#    n) echo " Skiping APT Update"; sleep 1; return 1 ;;
#    *) echo " \"$option\" Is Not A Valid Option"; sleep 1; aptgupd ;;
#  esac
#  echo && echo -e " Performing ${b}APT Update${end}"
#  apt -y update &>/dev/null
#  echo -e " ${b}APT Update${end} Completed"
#  echo && echo -en " ${y}Press Enter To Continue"
#  read input
#}
# Internet Check
checkinternet () {
  if ping -c 1 google.com &>/dev/null; then
    echo -e " Checando conexão com a internet: ${vr}CONECTADO ✅${endc}"
    NPDVsCheck
  else
    echo -e " Checando conexão com a internet: ${r}DESCONECTADO ❌${endc}
 ${y}Você precisa está conectado para a utilização do NPDVs${endc}"
    echo -e " ${b}O Script está sendo${end} encerrado..."
    echo && sleep 5
    NPDVsExit
  fi
}
##################
NPDVsStart () {
  $spath/install.sh
  exit
}
# INICIALIZAÇÃO DO SCRIPT
logoNPDVs && echo -e " ${y}Inicializando Instalador...${endc}" && checkinternet
# -------------------------------------------------------
instalar () {
  logoNPDVs
echo -e " ${r}Digite sua senha para prosseguir com a instalação.${end}"
echo -e "$vr======================================== $end"
sudo apt install rdesktop yad sox tigervnc-viewer nmap mpv mplayer sshpass git && git clone https://github.com/sistemanpdvs/.themes.git && git clone https://github.com/sistemanpdvs/npdvs-grafico.git && chmod +x ./npdvs-grafico/* && chmod +x ./npdvs-grafico/radio/* && cp npdvs-grafico/Nilsonlinux.desktop Área\ de\ Trabalho/ && cp npdvs-grafico/NPDVs-Grafico.desktop /usr/share/applications/ && ./npdvs-grafico/NPDVs-Grafico.sh
echo -e "$vr=======[ $br Status da requisição $ec $vr]=======$end"
echo -e "$vr======================================== $end"
echo -e "$vr    COMANDO EXECUTADO COM SUCESSO... $end"
echo -e "$vr======================================== $end"
sleep 4
rm -rf install.sh
exit
}
# Infinite Loop To Show Menu Untill Exit
while :
do
logoNPDVs
echo -e "${g} ======= [ MENU PRINCIPAL (NPDVs-Gráfico)] ====== ${end}
${g}[ ${y}1 ${end}${g}]${end} ${vr} INSTALAR${end}
${g} ================================================ ${end}
${g}[ ${y}0 ${end}${g}]${end} ${vr} SAIR${end}"
echo -e "${g} ================================================ ${end}"
echo -en " Selecione uma opção: ➤ "
read option
case $option in
1) instalar ;;
0) NPDVsExit ;;
*) echo " \"$option\" Opção inválida"; sleep 1 ;;
esac
done
# -------------------------------------------------------
# Script End
