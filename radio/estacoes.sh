#!/bin/bash
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
  #### Variáveis ######################################################################
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"

command -v mpv >/dev/null 2>&1 || (yad --text="PMRP requires 'mpv' but it's not installed!\nInstall 'mpv' to enjoy PMRP."; exit 1)
  ${OPEN}
TEXTDOMAIN=ydesk
TEXTDOMAINDIR=/usr/share/locale

LANG=C.UTF-8
export APP_NAME="Nilsonlinux Radio Player"

export pmrp='@bash -c "run_stations %2"'
export pmrp_stations="$HOME/npdvs-grafico/radio/listaradio"

# Declare default status
export STATUS="🟢 Tocando agora 🟢"

export fpipe=$(mktemp -u --tmpdir pmrp.XXXXXXXX)
export ppipe=$(mktemp -u --tmpdir ppmrp.XXXXXXXX)
export cpipe=$(mktemp -u --tmpdir cpmrp.XXXXXXXX)
export statuspipe=$(mktemp -u --tmpdir cpmrp.XXXXXXXX)
export nobelnotification=$(mktemp -u --tmpdir notifpmrp.XXXXXXXX)
export PMRPLIST=$(mktemp -u --tmpdir PMRPLIST.XXXXXXXX)

# Pipe for setting values in the form tab
mkfifo "$fpipe"
# control pipe - send commands to mpv
mkfifo "$cpipe"
# status pipe - send text to left text pane
mkfifo "$statuspipe"
# Pipe for notification icon
mkfifo "$nobelnotification"

# Create the list file
> $PMRPLIST

#File to store default category
export CAT_FILE=$(mktemp -u --tmpdir pmrpcat.XXXXXXXX)
> $CAT_FILE

trap "rm -f $fpipe $ppipe $cpipe $statuspipe $nobelnotification $PMRPLIST $CAT_FILE" EXIT

pmkey=$(($RANDOM * $$))

# Categories are defined with "## Station_name"
# Categories are separated with "!\n" (without quotes)
# Note: without trailing newline yad won't restore categories when reopened from tray
# The last item in category is without trailing "!"
Categories="$(awk '/^##.*/{if ($2=="Stations"){$2=""}else{printf "%s%s",sep,$2; sep="!\n"}} END{print ""}' $pmrp_stations)"

function stations
{
   if [[ "$1" != "$CAT_DEFAULT" ]]; then
      echo "Category: $1" >> "$ppipe"
   fi
   < "$pmrp_stations" sed -n -e 's/^.*'"$1: "'//p' \
   | sed -e $'s/\" \"/\\\n/g;s/\"//g' >> "$fpipe"
}
export -f stations

function run_stations
{
    echo "3:@disabled@"
    echo -e '\f' >> "$fpipe"

    echo "$1" > "$CAT_FILE"

    stations "$1"
    echo "3:$pmrp"
}
export -f run_stations

function load_url
{
    LANG=C.UTF-8
    status_block "$APP_NAME: Loading...\n\n $1"
    echo "Station: $1   Url: $3" >> $ppipe
    # Station to the list
    echo "$3" > $PMRPLIST
    # Unload current Playlist
    echo "playlist_remove current" > $cpipe
    # Load list
    echo "loadlist $PMRPLIST" > $cpipe

}
export -f load_url

function status_block
{
LANG=C.UTF-8
if [[ ! -z "$PMRP" ]]; then
   unset PMRP
else
  if [[ "$(echo "$1" | grep -c "^Name*")" = 1 ]]; then
      STATION="$1"
  elif [[ "$(echo "$1" | grep -c "^Title*")" = 1 ]];then
      TITLE="$1"
      date +"Time: %T" >> $ppipe
  elif [[ "$(echo "$1" | grep -c "^Bitrate")" = 1 ]];then
      BITRATE="$1 Kb/s"
  elif [[ "$(echo "$1" | grep -c "^Url*")" = 1 ]];then
      URL="$1"
  elif [[ "$(echo "$1" | grep -c "^$APP_NAME:*")" = 1 ]];then
      PMRP="${1/#$APP_NAME:/}"
  fi

  set_notification "${1}"
  
  if [[ -z "$PMRP" ]]; then
    printf "%s\n" "$STATION\n$URL\n$BITRATE\n$TITLE\n$STATUS" >> "$statuspipe"
    echo "tooltip:<b>${STATION/#Name    /Station : }\n<big>${TITLE/#Title         /Track : }</big></b>" | sed "s/\&/\&amp;/g"  >> $nobelnotification
  else
    echo "\n$PMRP\n" >> "$statuspipe"
  fi
  
  CAT_DEFAULT="$(cat $CAT_FILE)"

  if [[ "$CAT_DEFAULT" == "" ]]; then
     CAT_DEFAULT="181.FM"
  fi

   echo "$(for category in $Categories
           do
             if [[ "$category" == "$CAT_DEFAULT" ]]; then
                printf "^%s" "$CAT_DEFAULT"
             elif [[ "$category" != "$CAT_DEFAULT!" ]]; then
                printf "%s" "$category"
             else
                printf "^%s!" "$CAT_DEFAULT"
             fi
           done
          )" >> "$statuspipe"
   # Load stations
   echo "$pmrp" >> "$statuspipe"
   
   
fi
}
export -f status_block

function set_notification
{
    LANG=C.UTF-8
  if [[ "${1/#ANS_core-idle=/}" == "yes" ]];then
      STATUS="Paused"
      echo "icon:gtk-cancel" >> $nobelnotification
  elif [[ "${1/#ANS_core-idle=/}" == "no" ]];then
      STATUS="Playing"
      echo "icon:play" >> $nobelnotification
  elif [[ "${1}" == "Stop" ]];then
      export STATUS=" ${1}"
      echo "tooltip:Rádios do mundo todo" | sed "s/\&/\&amp;/g" >> $nobelnotification
      echo "icon:gtk-delete" >> $nobelnotification
  fi
      # Sets the right-click menu
      echo "menu:$STATUS - Pause/Play!bash -c 'echo cycle pause >> $cpipe && echo \"get_property core-idle\" > $cpipe && set_notification'!gtk-ok|Stop!bash -c 'echo stop >> $cpipe && status_block "Stop" && set_notification'!stop|Close tray!quit!gtk-close" >> $nobelnotification
     
}
export -f set_notification

exec 3<> $fpipe
exec 4<> $ppipe
exec 5<> $cpipe
exec 6<> $statuspipe
exec 7<> $nobelnotification

killall mpv 2>/dev/null

  mpv --no-ytdl --playlist=$PMRPLIST --input-file=$cpipe --no-video --cache 786 --no-config --term-playing-msg='print_text ${metadata}' --idle=yes 2>&1 \
     | awk '/[statusline]/{if ($0 ~ "icy-br:*") {gsub(/^.*icy-br:/,"");print "Bitrate   ", $0 ;}
                                 else {if ($0 ~ "icy-name:*") {gsub(/^.*icy-name:/,"");print "Name    ", $0;}
                                 else {if ($0 ~ "icy-url:*") {gsub(/^.*icy-url:/,"");print "Url          ", $0;}
                                 else {if ($0 ~ "icy-genre:*") {gsub(/^.*icy-genre:/,"");print "Genre -", $0;}
                                 else {if ($0 ~ "icy-title:*") {gsub(/^.*icy-title:/,"");print "Title        ", $0;}
                                 else {if ($0 ~ "ANS_core-idle*"){print $0;}}}}}}}
                                 {fflush(stdout)}'  | while read -r line; do status_block "$line"; echo "$line" >>"$ppipe"; done &

function main() {
  
  # loads fields on startup
  ascii_art='\t      🎧 ♫ ♪ ılıll|̲̅̅●̲̅̅|̲̅̅=̲̅̅|̲̅̅●̲̅̅|llılı ♪ ♫ 🎧 \n\n\t              \\ (•◡•) /  <--- Nilsonlinux'
  status_block "$APP_NAME:            $APP_NAME                    \n                  (((( Pronto pra tocar ))))  \n  Licence: GNU PUPBLIC LICENCE Version 3\n\n$ascii_art\n\n\n\n\n\n\n\n\n Selecione uma categoria e clique para carregar estações"
  
  yad --plug="$pmkey" --tabnum=1 --form --cycle-read --field "":TXT --field "Categoria":CB  \
     --image-ontop --field="Carregar estações!gtk-add:fbtn" <&6  &

  yad --plug="$pmkey" --tabnum=2 --list --no-markup --dclick-action='bash -c "load_url %s && echo \"add track-list/0/selected yes\" >> $cpipe"' --select-action='bash -c "load_url %s && echo \"get_property track-list/0/selected\" >> $cpipe"' \
    --text "Lista de estações" --text-align=center --column="Nome" --column="Categoria" --column="URL" \
    --search-column=1 --expand-column=1 --print-column="3" <&3 &

  # comment out next line if you want to start with log
  # tail -f "$ppipe" | yad --text-info --title="$APP_NAME-Log" --tail --window-icon=radio --width=600 --height=500 --button="gtk-close" &

 # Reprints metadata after returning from tray
   echo 'print_text ${metadata}' > $cpipe

  yad --paned --center --key="$pmkey" --button="Fechar o programa!gtk-close":1 \
      --button="Vizualizar log 💱":'bash -c "tail -f -n +1 $ppipe | yad --text-info --tail --title=$APP_NAME-Log --width=600 --height=500 --button=gtk-close" &' \
      --button="Pause/Play ⏯":'bash -c "echo cycle pause >> $cpipe && echo \"get_property core-idle\" > $cpipe"' \
      --button="Stop ⏹":'bash -c "echo stop >> $cpipe && status_block \"Stop\" "'  --text="  Estações de rádio\n *Do mundo todo*" --width=700 --height=500 \
      --title=$"$APP_NAME" --splitter=300 --window-icon="radio" --orient=hor --image=$HOME/npdvs-grafico/radio/icons/radio.png --image-on-top --posx=10 --posy=100
RET="$?"
${CLOSE}
case $RET in
  252)
    echo "quit" >> $cpipe
    ;;
   1)   yad --notification  --command="quit" \
          --image="npdvs-grafico/radio/icons/radio1.svg" \
          --listen <&7 & notifpid=$!

        set_notification

        # Waits for notification to exit
        wait $notifpid

        # Need to do this after returned from tray
        status_block ""
        run_stations "$(cat $CAT_FILE)" &>/dev/null
    main
    ;;
   *) exit 1
    ;;
esac
}
main


exec 3>&-
exec 4>&-
exec 5>&-
exec 6>&-
exec 7>&-