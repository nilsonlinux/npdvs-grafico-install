 #!/bin/bash
  #####################################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  version="2.9"
  #####################################################################################
  export DIR="$(dirname "$(readlink -f "$0")")"
  GTK_THEME="Nilsonlinux-Neon-Originals-Gtk" $DIR/Nilsonlinux-check.sh
  #### Variáveis ######################################################################
  WELCOME="play $DIR/sounds-alert/welcome.ogg"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
  #####################################################################################
  ${WELCOME} | GTK_THEME="Nilsonlinux-Neon-Originals-Gtk" yad --form --title="NPDVs Gráfico $version" --height=460 --width=1050 \
--center --image=$DIR/img/logo.png \
--borders=5 --no-buttons \
--text="
<span font='70' font_weight='bold' font-family='ubuntu' color='#6E6E6E'>     Nilsonlinux</span><span font='20'>®
<span font_weight='bold' font='14' color='#4A90D9'>           PAINEL ADMINISTRATIVO PARA EXECUÇÃO DE COMANDOS E ATALHOS.</span>
</span>                                                                                Desenvolvido por <span font_weight='bold'>Nilsonlinux</span>.
<span font_weight='bold' size=\"xx-large\" color='#298A08'>                                                      $(date +%d/%m/%Y)</span>
" \
--columns=3 \
--field="   MGV Server!$DIR/img/mgv_server.svg!<span color='#5CF30B' font_weight='bold'>Acesso MGV Server</span>":fbtn $DIR/mgv.sh \
--field="   GMCORE!$DIR/img/gmcore.svg!<span color='#5CF30B' font_weight='bold'>Acesso GMCORE</span>":fbtn $DIR/gmcore.sh \
--field="   ACESSO GATEWAY!$DIR/img/gateway.svg!<span color='#5CF30B' font_weight='bold'>Acesso Gateway</span>":fbtn $DIR/acesso_gateway.sh \
--field="   PING TEST!$DIR/img/ping.svg!<span color='#5CF30B' font_weight='bold'>Teste de Ping</span>":fbtn $DIR/ping_test.sh \
--field="   Atualizar versão!$DIR/img/atualizar_versao.svg!<span color='#5CF30B' font_weight='bold'>Copiar versão entre PDVs</span>":fbtn $DIR/atualizar_versao.sh \
--field="   Reiniciar PDVs!$DIR/img/reboot.svg!<span color='#5CF30B' font_weight='bold'>reboot</span>":fbtn $DIR/reiniciar.sh \
--field="   Atualizar PDVs!$DIR/img/atualizar_pdvs.svg!<span color='#5CF30B' font_weight='bold'>Atualizar PDV - it-update-pdvs.sh</span>":fbtn $DIR/atualizar.sh \
--field="   Desligar terminais!$DIR/img/desligar.svg!<span color='#5CF30B' font_weight='bold'>Desligamento dos terminais</span>":fbtn $DIR/desligar.sh \
--field="   Acesso SSH (PDVs)!$DIR/img/ssh.svg!<span color='#5CF30B' font_weight='bold'>Acesso SSH PDVs</span>":fbtn $DIR/acesso_ssh_pdvs.sh \
--field="   Acesso SSH (Gateway)!$DIR/img/ssh_gateway.svg!<span color='#5CF30B' font_weight='bold'>Acesso SSH Gateway</span>":fbtn $DIR/acesso_ssh_gateway.sh \
--field="   Acesso CUPS (Filiais)!$DIR/img/cups.svg!<span color='#5CF30B' font_weight='bold'>Acesso CUPS Lojas | user: mateus | passwd: @netuno23!</span>":fbtn $DIR/acesso_cups.sh \
--field="   Deletar arquivos da pasta /tmp!$DIR/img/limpar.svg!<span color='#5CF30B' font_weight='bold'>Deletar arquivos da pasta tmp</span>":fbtn $DIR/tmp_del.sh \
--field="   Criação de senhas!$DIR/img/senhas.svg!<span color='#5CF30B' font_weight='bold'>Senhas colaboradores</span>":fbtn $DIR/senhas.sh \
--field="   Acesso MAXIPOS WEBVIEW (LOJAS)!$DIR/img/vnc.svg!<span color='#5CF30B' font_weight='bold'>Acesso MaxiPOS VNC Lojas</span>":fbtn  $DIR/acesso_maxipos_pdvs.sh \
--field="   VNC Viewer (TigerVNC)!$DIR/img/tigervnc.svg!<span color='#5CF30B' font_weight='bold'>Acesso VNCVIEWER</span>":fbtn $DIR/vncviewer.sh \
--field="   Atualizar Todos os PDVs!$DIR/img/atualizar_todos.svg!<span color='#5CF30B' font_weight='bold'>Atualizar todos os terminais</span>":fbtn $DIR/atualizar_todos.sh \
--field="   Acesso sftp Terminais!$DIR/img/sftp.svg!<span color='#5CF30B' font_weight='bold'>Acesso a pasta Maxipos (Terminais)</span>":fbtn $DIR/acesso_sftp_pdvs.sh \
--field="   Rádio Online!$DIR/img/radio.svg!<span color='#5CF30B' font_weight='bold'>Rádios Online</span>":fbtn $DIR/radio.sh \
--field="   Acompanhamento Lojas!$DIR/img/ac_lojas.svg!<span color='#5CF30B' font_weight='bold'>Acompanhamento lojas - Regional S.I</span>":fbtn $DIR/ac_lojas.sh \
--field="   Acesso SSH (GMLINUX)!$DIR/img/ssh.svg!<span color='#5CF30B' font_weight='bold'>Acesso SSH Linux Mateus | Usuário: admin | Senha: netuno23</span>":fbtn $DIR/acesso_ssh_lmateus.sh \
--field="   Ramais!$DIR/img/ramais.svg!<span color='#5CF30B' font_weight='bold'>Ramais T.I</span>":fbtn $DIR/ramais.sh \
--field="   Acesso IMPORTA!$DIR/img/ssh.svg!<span color='#5CF30B' font_weight='bold'>Acesso IMPORTA PDVs</span>":FBTN $DIR/acesso_importa.sh \
--field="   !!<span color='#5CF30B' font_weight='bold'>Sobre o desenvolvedor</span>":BTN $DIR/nilsonlinux.sh \
--field="   Sobre!$DIR/img/sobre.svg!<span color='#5CF30B' font_weight='bold'>Sobre o desenvolvedor</span>":BTN $DIR/nilsonlinux.sh \
--scroll "auto"
 ${CLOSE}
 