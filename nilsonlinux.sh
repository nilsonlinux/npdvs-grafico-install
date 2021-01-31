#!/usr/bin/env bash
################ NILSONLINUX #################
  export DIR="$(dirname "$(readlink -f "$0")")"
  OPEN="play $DIR/sounds-alert/window-new.oga"
  CLOSE="play $DIR/sounds-alert/window-close.oga"
# Nome programa
PRG='NPDVs Gráfico'

# Versão
VERSION='2.0'
# Websites para usar com xdg-open.
sites=(
    [0]='https://twitter.com/Nilsonlinux'
    [1]='https://vk.com/nilsonlinux'
    [2]='https://github.com/sistemanpdvs/npdvs-grafico'
    [3]='https://github.com/nilsonlinux'
    [4]='https://github.com/sistemanpdvs/npdvs-grafico'
)

#===================================| INICIO

# Menu Principal + Abas
 ${OPEN} | yad --title="$PRG"            \
    --width="300"              \
    --height="650"             \
    --text-align=left          \
    --center                   \
    --image-on-top             \
    --undecorated              \
    --fontname="monospace 56"  \
    --image="$DIR/img/social/nilsonlinux.jpg" \
    --borders=0               \
    --form  --columns 2                                                                                     \
    --field="<b>VK</b>!$DIR/img/social/vk.svg!VK Nilsonlinux":BTN "xdg-open ${sites[1]} " \
    --field="<b>Twitter</b>!$DIR/img/social/twitter.svg!Twitter Nilsonlinux":BTN "xdg-open ${sites[0]}"           \
    --field="<b>Sobre o projeto</b>!$DIR/img/social/youtube.svg!Youtube Nilsonlinux":BTN "xdg-open ${sites[2]}"   \
    --field="<b>Github</b>!$DIR/img/social/github.svg!Github Nilsonlinux":BTN "xdg-open ${sites[3]}"                 \
    --field="<b>Detalhes do projeto</b>!$DIR/img/social/wiki.png!Detalhes NPDVs Gráfico":BTN "
 yad --width='500'
     --height='100'
     --center
     --undecorated
     --image="$DIR/img/social/sobreyad.png"
     --borders=5
     --text-align=left
     --text='
<big><b>$PRG</b></big>
<b>Versão:</b> $VERSION
<b>Licença:</b> GPL
<b>Criado por:</b> Nilsonlinux 'Santos' Dev
<b>Contato:</b> nilsonlinux@gmail.com'
     --button="Sair":1
"                                                                                                           \
    --field="<b>Telegram</b>!$DIR/img/social/chat.png!Grupo no Telegram":BTN "
 yad --width='500'
     --height='100'
     --center
     --undecorated
     --image="${icon}/chat.png"
     --borders=5
     --text-align=left
     --text='
<big><b>Bate Papo</b></big>
Venha bater um bate papo com o pessoal do projeto! Estamos esperando você :)
<b>Telegram:</b> @Nilsonlinux
<b>IRC:</b> Estamos também na freenode #npdvsgráfico'
     --button="Sair":1
"                                                                                                       \
    --field="<b>Repositório do projeto</b>!$DIR/img/social/helpus.png!Repositório do projeto":BTN  "xdg-open ${sites[4]}"            \
    --button="Sair":1 \
--scroll "auto"
${CLOSE}
