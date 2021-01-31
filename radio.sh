 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIR="$(dirname "$(readlink -f "$0")")"
  #### Variáveis ######################################################################
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  #####################################################################################
  ${OPEN}
  #####################################################################################
GTK_THEME="Nilsonlinux-Neon-Originals-Gtk" yad --form --title="NILSONLINUX ONLINE RADIO" --height=500 --width=450 \
--center \
--borders=5 --no-buttons \
--text="
<span font='45' font_weight='bold' font-family='ubuntu' color='#00BFFF'>🤘🏻Nilsonlinux 🎧</span>   
<span font_weight='bold' font='12' color='#FE2E2E'>  🎸 🎼🎵🎶  RÁDIOS ONLINE. ROCK E HEAVYMETAL  🎶🎵🎼 🎸</span>
<span font_weight='bold' color='#FFFF00'>                                      Desenvolvido por:</span>  <span font='12' font_weight='bold' font-family='ubuntu' color='#32CD32'>Nilsonlinux</span>
<span font_weight='bold' font='12' color='#C0C0C0'>                                                         $(date +%d/%m/%Y)</span>
<span font_weight='bold' font='12' color='#C0C0C0'>                                                                  😎</span>
" \
--columns=1 \
--field="     Nilsonlinux Web Rádio 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>Rock e Heavymetal</span>":fbtn $DIR/radio/radio1.sh \
--field="     89 FM A Rádio Rock 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>89 FM A Rádio Rock - 89.1 FM
São Paulo - São Paulo
Matriz
Avenida Paulista, 2198 - 21º andar
(11) 3016.0089
https://www.radiorock.com.br/</span>":fbtn $DIR/radio/radio2.sh \
--field="     Arapuan FM - 107.3 FM 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>Arapuan FM - 107.3 FM
Campina Grande - Paraíba
Rua Quintino Bocaiúva, 152 - Palmeira
(83) 3222.3905
http://www.arapuanfm.com.br/</span>":fbtn $DIR/radio/radio3.sh \
--field="     Rádio RocKMetal 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>Rádio RocKMetal - 0.0 FM
Brasil - Webrádios
São José do Rio Preto (SP)
http://www.rockmetal.com.br</span>":fbtn $DIR/radio/radio4.sh \
--field="     Jovem Pan FM - 100.9 FM 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>Jovem Pan FM - 100.9 FM
São Paulo - São Paulo
Matriz
Av. Paulista, 807 - 14º andar - Bela Vista
(11) 2870.9750
http://www.jovempanfm.com.br/.</span>":fbtn $DIR/radio/radio5.sh \
--field="     CAMPINA MIX 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>A RADIO DA MISTURA MUSICAL</span>":fbtn $DIR/radio/radio6.sh \
--field="     Antena Rock 🇧🇷!!<span color='#F5FFFA' font_weight='bold'>Antena Rock - Web Rádio ROCK do Brasil, com foco nas bandas autorais independentes, tocando também clássicos do Rock, Surf Music e Lançamentos! Uma Web Rádio que valoriza o rock independente do Brasil. OUÇA SEM MODERAÇÃO!</span>":fbtn $DIR/radio/radio7.sh \
--field="     Estações mundiais 🌍!!<span color='#F5FFFA' font_weight='bold'>ESTAÇÕES MUNDIAIS!</span>":fbtn $DIR/radio/estacoes.sh \
--field="   Parar rádio!$DIR/radio/icons/desligar.svg!<span color='#F5FFFA' font_weight='bold'>Parar rádio</span>":fbtn $DIR/radio/radio_off.sh \
--scroll "auto"
 ${CLOSE}

