 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  export DIR="$(dirname "$(readlink -f "$0")")"
  #### Nilsonlinux
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  ERRO="play $DIR/sounds-alert/erro.oga"
  CONECTADO="play $DIR/sounds-alert/ok.oga"
#####################################################################################
(
echo "# Testando conexão com o Host IP - ${IP}" ;
) |
zenity --progress \
  --title="Teste de conexão." \
  --text="Verificando conexão..." \
  --pulsate=0 \
   --width=500 --auto-close
#######################################################
if ! ping -c 1 8.8.8.8 >> /dev/null ; then 
${ERRO} | yad --form --title="Informação!" --height=1 --width=500 \
--center --image=$DIR/img/erro.svg \
--borders=10 --button="Sair:0"  \
--text="<span font_weight='bold' font='15' color='#1C1C1C'>ERRO! SEM CONEXÃO COM HOST.</span>
<span font_weight='bold' font='20' color='#FF0000'>HOST - $IP</span>
<span font_weight='bold' font='15' color='#1C1C1C'>Não está acessível . . .</span>"
######################################################
else
${CONECTADO} | yad --form --title="Informação!" --height=30 --width=450 --auto-close \
--center --image=$DIR/img/ok.svg \
--borders=10 --button="Continuar:0"  \
--text="<span font_weight='bold' font='10' color='#006400'>SUCESSO. HOST CONECTADO.</span>
<span font_weight='bold' font='20' color='#00FF00'>HOST - $IP </span>
<span font_weight='bold' font='10' color='#1C1C1C'>Clique no botão Continuar para prosseguir com teste de ping. </span>"
################################################
set -u
#   ^ unbound (i.e. unassigned) variables shall be errors.
set -e
#   ^ error checking :: Highly Recommended (caveat:  you can't check $? later).  
#
# _______________     ::  BEGIN  Script ::::::::::::::::::::::::::::::::::::::::

site=${1:-'usw'}


case $site in 
     'london') test='http://speedtest.london.linode.com/100MB-london.bin'    ;;
     'tokyo')  test='http://speedtest.tokyo.linode.com/100MB-tokyo.bin'      ;;
     'usw')    test='http://speedtest.fremont.linode.com/100MB-fremont.bin'  ;;
               #  US West:  Fremont, California
     'use')    test='http://speedtest.newark.linode.com/100MB-newark.bin'    ;;
               #  US East:  Newark, New Jersey
     'east')   test='http://speedtest.wdc01.softlayer.com/downloads/test500.zip'                 ;;
               #  US East:  Washington, D.C.
     'west')   test='http://speedtest.sjc01.softlayer.com/speedtest/speedtest/random500x500.jpg' ;;
               #  US West:  San Jose, California
     *)        test=$1  ;;
               #  valid URL assumed, else wget will give any error message.
esac 
     #  Sources:
     #  2013-07-11  Linode renames sub-domains for testing.
     #  2011-10-07  http://www.linode.com/speedtest/      for file URL.
     #              http://speedtest.wdc01.softlayer.com  for actual testing.



if [ $test = -${test#-} ] ; then 
     #     ^check for negative sign in the first argument.
     echo "`awk "BEGIN { print ($test * -0.007813) }"` Mbps" 
     #      awk as nice floating-point calculator!
else
     echo ' ::  Rate in Kilobytes/sec; industry usually adopts megabits/sec:       '
     echo ' ::        1 Kilobytes/sec (K/s)   =       0.007813 megabits/sec (Mbps).'
     echo ' ::        To CONVERT, use negated rate as first argument to netspeed.  '
     echo ' ::  [Terminate netspeed by control-C]     [ cf. http://speedtest.net ] '
     echo ' ::  '
     trap 'echo -e "\n\n ::  Exit successful on designed interrupt."; exit 0' SIGINT
     #      MAIN
     wget  --output-document=/dev/null  $test
fi | yad --text-info --window-icon "audio-x-generic.png" --title "Informação de processo" --center --height 250 --width 780 --tail --margins 4 --button="gtk-close"



exit 0
# _______________ EOS ::  END of Script ::::::::::::::::::::::::::::::::::::::::

############ COMANDOS #################################
fi
      break
  done
####################################################################################
${CLOSE}