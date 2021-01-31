 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
  #####################################################################################
  IPSERV='192.168'
  PORTA_ACESSO=':9898/normal.html'
  VERMELHO="<span font_weight='bold' font='14' color='#FE2E2E'>" #VERMELHO
  VERDE="<span font_weight='bold' font='10' color='#298A08'>" #VERDE
  CIANO="<span font_weight='bold' font='10' color='#4A90D9'>" #AZUL - CIANNO
  AMARELO="<span font_weight='bold' font='10' color='#FFBF00'>" #AMARELO
  LARANJA="<span font_weight='bold' font='10' color='#FFBF00'>" #DF7401
  AZUL="<span font_weight='bold' font='10' color='#045FB4'>" #DF7401 
  VERDEE="<span font_weight='bold' font='17' color='#5CF30B'>" #verde escuro
  END="</span>"
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"
  ERRO="play $DIRETORIO/sounds-alert/erro.oga"
  CONECTADO="play $DIRETORIO/sounds-alert/ok.oga"  
  #####################################################################################
${OPEN} | while true
  do
    FAIXA=
      FORMULARY=$(yad --center --width=480 \
          --window-icon="gtk-execute" --image="$DIRETORIO/img/tigervnc.svg" --item-separator=","            \
          --title "ACESSO VNCVIEWER (NPDVs)"                                                              \
          --form                                                                                          \
          --field="DIGITE A FAIXA DA FILIAL E IP.  192.168." $FAIXA ""                                    \
          --text="Acesso vnc viewer por faixa e ip. Desenvolvido por: Nilsonlinux.
---------------------------------------------------------------------------------------------------
${VERDEE}A C E S S O   T E R M I N A I S    L O J A    03${END}
---------------------------------------------------------------------------------------------------
        C A I X A                         T E R M I N A L                                   I P´s      
---------------------------------------------------------------------------------------------------
${AZUL}     C A I X A   01   ${END}                          123                                   192.168.3.${VERDE}59   ${END}
${AZUL}     C A I X A   02   ${END}                          103                                   192.168.3.${VERDE}122  ${END}
${AZUL}     C A I X A   03   ${END}                          151                                   192.168.3.${VERDE}52   ${END}
${AZUL}     C A I X A   04   ${END}                          130                                   192.168.3.${VERDE}123  ${END}
${AZUL}     C A I X A   05   ${END}                          106                                   192.168.3.${VERDE}25   ${END}
${AZUL}     C A I X A   06   ${END}                          107                                   192.168.3.${VERDE}102  ${END}
${AZUL}     C A I X A   07   ${END}                          108                                   192.168.3.${VERDE}103  ${END}
${AZUL}     C A I X A   08   ${END}                          109                                   192.168.3.${VERDE}104   ${END}
${AZUL}     C A I X A   09   ${END}                          154                                   192.168.3.${VERDE}189  ${END}
${AZUL}     C A I X A   10   ${END}                          111                                   192.168.3.${VERDE}105  ${END}
${AZUL}     C A I X A   11   ${END}                          121                                   192.168.3.${VERDE}107  ${END}
${AZUL}     C A I X A   12   ${END}                          113                                   192.168.3.${VERDE}120  ${END}
${AZUL}     C A I X A   13   ${END}                          114                                   192.168.3.${VERDE}140  ${END}
${AZUL}     C A I X A   14   ${END}                          151                                   192.168.3.${VERDE}110  ${END}
${AZUL}     C A I X A   15   ${END}                          116                                   192.168.3.${VERDE}11  ${END}
${AZUL}     C A I X A   16   ${END}                          150                                   192.168.3.${VERDE}144  ${END}
${AZUL}     C A I X A   17   ${END}                          118                                   192.168.3.${VERDE}113  ${END}
${AZUL}     C A I X A   18   ${END}                          119                                   192.168.3.${VERDE}114  ${END}
${AZUL}     C A I X A   19   ${END}                          128                                   192.168.3.${VERDE}128  ${END}
${AZUL}     C A I X A   20   ${END}                          112                                   192.168.3.${VERDE}116  ${END}
${AZUL}     C A I X A   21   ${END}                          153                                   192.168.3.${VERDE}153  ${END}
 ---------------------------------------------------------------------------------------------------
${CIANO}     ELETRO 01     ${END}                           124                                    192.168.3.${VERDE}117  ${END}
${CIANO}     ELETRO 02     ${END}                           125                                    192.168.3.${VERDE}225  ${END}
 ---------------------------------------------------------------------------------------------------
${VERDE}     BOTECO          ${END}                           126                                   192.168.3.${VERDE}138  ${END}
${VERDE}     LANCHONETE      ${END}                    127                                   192.168.3.${VERDE}132  ${END}
${VERDE}     BALCÃO          ${END}                           120                                   192.168.3.${VERDE}130  ${END}
 ---------------------------------------------------------------------------------------------------"                         \
          --button="CANCELAR":1 --button="ABRIR":0)
      [ $? != 0 ] && exit
      FAIXA=$(echo $FORMULARY     | awk -F '|' '{ print $1 }')
########################################################
########################################################
(
echo "# Testando conexão com o Terminal IP - ${IPSERV}.${FAIXA}" ; sleep 1
sleep 1
) |
zenity --progress \
  --title="Acesso MaxiPOS WEBVIEW." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
########################################################
if ! ping -c 1 ${IPSERV}.${FAIXA} >> /dev/null ; then
########################################################
${ERRO} | yad --form --title="Informação!" --height=10 --width=450 \
--center --image=$DIRETORIO/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="
<span font='15' color='#FFBF00'>ERRO! SEM CONEXÃO COM ESTE TERMINAL.</span>
<span font_weight='bold' font='20' color='#FF0000'>IP - ${IPSERV}.${FAIXA} </span>
<span font='15' color='#FFBF00'>Terminal offline! </span> " 
#####################################################################################
else
${CONECTADO} | vncviewer ${IPSERV}.${FAIXA}
fi
      break
  done
#####################################################################################
${CLOSE}