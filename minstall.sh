 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  #####################################################################################
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
  #### Variáveis ######################################################################
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"
  #####################################################################################
  ${OPEN}
   yad --form --title="NPDVs 3.0" --height=273 --width=400 \
--center  \
--borders=5 --no-buttons \
--text="
<span font='50' font_weight='bold' font-family='ubuntu' color='#6E6E6E'>Nilsonlinux</span><span font='30'>®
<span font_weight='bold' font='14' color='#4A90D9'>                 INSTALADOR NPDVs-Gráfico.</span>
</span>                                   Desenvolvido por <span font_weight='bold'>Nilsonlinux</span>.
<span font_weight='bold' size=\"xx-large\" color='#298A08'>                       $(date +%d/%m/%Y)</span>
" \
--columns=1 \
--field="   Instalar !$DIRETORIO/img/install1.svg!<span color='#298A08' font_weight='bold'>INSTALADOR NPDVS GRÁFICO - NILSONLINUX</span>":fbtn $DIRETORIO/menuinst/install.sh \
--scroll "auto"
 ${CLOSE}
 