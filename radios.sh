#! /bin/bash
#
# Frontend for find(1) (modified for radio player by fredx181)
# Author: Victor Ananjevsky <ananasik@gmail.com>, 2015-2017

# set directory to launch script from
export LAUNCHDIR="$(dirname "$(readlink -f "$0")")"

if [ -z `which yad` ]; then
	msg="  Package 'yad' is not installed, please install it. "
	xmessage  "`echo -e $msg`" 
exit 0
fi

if [ -z `which mplayer` ]; then
	msg="  Package 'mplayer' is not installed, please install it. "
	xmessage  "`echo -e $msg`" 
exit 0
fi

# create directories in case not exist
mkdir "$LAUNCHDIR/tmp" 2> /dev/null
mkdir "$LAUNCHDIR/playlist" 2> /dev/null

export load_cmd='@bash -c "load_list %1 %2 %3 %4"'

export fpipe="/tmp/yradio.$RANDOM"
mkfifo "$fpipe"
export nppipe="/tmp/nowplay.$RANDOM"
mkfifo "$nppipe"

fkey=$(($RANDOM * $$))

check_pid_mplayer () {
pidmplayer="`ps -eo pid,cmd | grep "$(cat $LAUNCHDIR/tmp/nowurl 2> /dev/null | sed 's/*.*//')" | grep 'mplayer' | grep -v "grep" | awk '{ print $1 }'`"
}
export -f check_pid_mplayer

function play_url () {
echo -e '\f' > "$nppipe"
if [ -f $LAUNCHDIR/tmp/nowurl ]; then
#killall mplayer
check_pid_mplayer
kill $(echo $pidmplayer) 2> /dev/null
#[ "`pidof mplayer`" ] && killall mplayer
rm -f $LAUNCHDIR/tmp/mplayer-output
fi
sleep 0.5
export URL="$1"
echo "$URL" > $LAUNCHDIR/tmp/nowurl
mplaylist () {
mplayer -quiet -cache 320 -cache-min 8 -playlist "$URL" 2> /dev/null | grep --line-buffered -v 'Cache fill' | tee $LAUNCHDIR/tmp/mplayer-output | grep --line-buffered "ICY" | while read a; do echo "$a" | awk -F " : |='|';" '/ICY Info/ {print $2}'; done | tee $LAUNCHDIR/tmp/metadata
}
export -f mplaylist

mplay () {
mplayer -quiet -cache 320 -cache-min 8 "$URL" 2> /dev/null | grep --line-buffered -v 'Cache fill' | tee $LAUNCHDIR/tmp/mplayer-output | grep --line-buffered "ICY" | while read a; do echo "$a" | awk -F " : |='|';" '/ICY Info/ {print $2}'; done | tee $LAUNCHDIR/tmp/metadata
}
export -f mplay

# Check if 'Starting playback...' appears in output, wait number of seconds, then give up:
TIMEOUT=7
time_out () {
IFPLAYLIST=$(grep 'Starting playback...' $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
#NAME=$(grep --line-buffered "Name.*:\|ICY" $LAUNCHDIR/tmp/mplayer-output 2> /dev/null) 
while [ -z "$IFPLAYLIST" ]; do
sleep 1
IFPLAYLIST=$(grep 'Starting playback...' $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
#NAME=$(grep --line-buffered "Name.*:\|ICY" $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
if [ "$IFPLAYLIST" ]; then
break
fi

done
}
export -f time_out

	case "$URL" in
	http://*|Http://*|/*)
case "${URL##*.}" in
m3u|pls|asx|ram|wax|asp|pls?id=*)
/bin/bash -c "mplaylist &"
busybox timeout -t $TIMEOUT /bin/bash -c time_out

#NAME=$(grep --line-buffered "Name.*:\|ICY" $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
IFPLAYLIST=$(grep 'Starting playback...' $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
if [ ! "$IFPLAYLIST" ]; then
yad --center --title "Could not connect" --text " Failed to connect to stream... " --button="gtk-close"
exit
fi
;;
*)
/bin/bash -c "mplay &"
busybox timeout -t $TIMEOUT /bin/bash -c time_out

#NAME=$(grep --line-buffered "Name.*:\|ICY" $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
IFPLAYLIST=$(grep 'Starting playback...' $LAUNCHDIR/tmp/mplayer-output 2> /dev/null)
if [ ! "$IFPLAYLIST" ]; then
yad --center --title "Could not connect" --text " Failed to connect to stream... " --button="gtk-close"
exit
fi
;;
esac
	;;
	*)
	yad --center --text=" Not a valid playlist  " --button="gtk-close"
	exit 
	;;
	esac
rm -f $LAUNCHDIR/tmp/nowplay
NAME="$(tail -n 1 $LAUNCHDIR/tmp/metadata)"
[ -n "$NAME" ] && echo "$NAME" > $LAUNCHDIR/tmp/nowplay
}
export -f play_url

stop_stream () {
rm -f $LAUNCHDIR/tmp/metadata
echo -e "No stream playing" > "$nppipe"
if [ -f $LAUNCHDIR/tmp/nowurl ]; then
#killall mplayer
check_pid_mplayer
kill $(echo $pidmplayer) 2> /dev/null
#[ "`pidof mplayer`" ] && killall mplayer
fi
}
export -f stop_stream

function load_list
{
    echo "4:@disable@"
rm -f $LAUNCHDIR/tmp/sel-file
SRCH="$2"
	if [ -z "$SRCH" ];then
rm -f $LAUNCHDIR/tmp/tmp_search_q $LAUNCHDIR/tmp/tmp_search
CAT=$1
echo "$CAT" > $LAUNCHDIR/tmp/tmp_cat
export OLDIFS="$IFS"
IFS=$'\n'
CHECK=$(cat $LAUNCHDIR/playlist/playlist.$CAT | grep '[^[:print:]]')
if [[ -n "${CHECK}" ]]; then
RADIOLIST=$(cat $LAUNCHDIR/playlist/playlist.$CAT | tr -cd '[:print:]\t\r\n' | sed 's#|-#|_#g;s#- ##g' | tr '|' '\n')
else
RADIOLIST=$(cat $LAUNCHDIR/playlist/playlist.$CAT | sed 's#|-#|_#g;s#- ##g' | tr '|' '\n')
fi
	else
  if [ ! -f $LAUNCHDIR/playlist/playlist.RadioSure ]; then
  yad --center --width=500 --borders 5 --title "Please update index" --text " Database index 'playlist.RadioSure' not found. \n Please click 'Update Index' first before using search option. " --button="gtk-close"
  else
echo "$SRCH" > $LAUNCHDIR/tmp/tmp_search_q
SRCH1=$(echo "$SRCH" | sed -e 's/\( [[:punct:]] \)/ /g' | sed 's/ . / /g;s/ .$//g;s/^. //g')
echo "$SRCH1"
for i in $SRCH1; do
export NEWSRCH="$NEWSRCH""(?=\|.*"$i")"
done

CHECK=$(grep -Pih "$NEWSRCH" $LAUNCHDIR/playlist/playlist.RadioSure | grep '[^[:print:]]')
if [[ -n "${CHECK}" ]]; then
RADIOLIST=$(grep -Pih "$NEWSRCH" $LAUNCHDIR/playlist/playlist.RadioSure | tr -cd '[:print:]\t\r\n' | sed 's#[^[:print:]]##g' | sed 's#|-#|_#g;s#- ##g' | sort -f -t '|' -k 2 -u | tr '|' '\n')
grep -Pih "$NEWSRCH" $LAUNCHDIR/playlist/playlist.RadioSure | tr -cd '[:print:]\t\r\n' | sed 's#[^[:print:]]##g' | sed 's#|-#|_#g;s#- ##g' | sort -f -t '|' -k 2 -u | tee $LAUNCHDIR/tmp/tmp_search
else
RADIOLIST=$(grep -Pih "$NEWSRCH" $LAUNCHDIR/playlist/playlist.RadioSure | sed 's#|-#|_#g;s#- ##g' | sort -f -t '|' -k 2 -u | tr '|' '\n')
grep -Pih "$NEWSRCH" $LAUNCHDIR/playlist/playlist.RadioSure | sed 's#|-#|_#g;s#- ##g' | sort -f -t '|' -k 2 -u | tee $LAUNCHDIR/tmp/tmp_search
fi
  fi

OLDIFS="$IFS"
IFS=$'\n'
CAT=""
	fi
    echo -e '\f' >> "$fpipe"
    echo -e "$RADIOLIST" >> "$fpipe"
    echo "4:$load_cmd"
}
export -f load_list

function help_info () {
echo -en "        \t\t\t*** Load category or do a search ***

 To be able to use search, first time use of this program, the database needs to be created.
 Therefore, click 'Update Index' first. 
 Note, search has priority, only if the search box is empty, a category can be loaded.

 The 'Save' button can save search results to a category list.

 The 'Add to Favorites' button will add selected to 'playlist.Favorites' in the playlist folder.
 To remove station(s), open with text-editor, just remove the corresponding line.

 Click 'Now Playing' for to popup small window (displaying title) at the right-bottom
 (clicking it again will make it disappear) " | yad --title="Yradio-help" --text-info --margins=6 --wrap --fore=black --back="white" --fontname=Bold --height=340 --width=680 --button="gtk-close"
}
export -f help_info

function update_index
{
(
wget --tries=1 -O $LAUNCHDIR/playlist/radio_sure.zip http://www.radiosure.com/rsdbms/stations2.zip
[ $? -ne 0 ] && exit 1
unzip -qo $LAUNCHDIR/playlist/radio_sure.zip -d $LAUNCHDIR/playlist/
rm -f $LAUNCHDIR/playlist/radio_sure.zip
NEWFILE=`ls $LAUNCHDIR/playlist/*.rsd`
cat "$NEWFILE" | tr -s "\t" '|' > $LAUNCHDIR/playlist/radio_tmp3 
awk -F'|' 'BEGIN{OFS="|";} {print $6,$1,$4,$3;}' $LAUNCHDIR/playlist/radio_tmp3 | sed 's/|/ /2' | sort | uniq | grep -i '^http://' > $LAUNCHDIR/playlist/playlist.RadioSure
rm -f $LAUNCHDIR/playlist/radio_tmp3 "$NEWFILE"
echo "Modifying for use with yradio...  Please wait..."
while IFS= read -r line; do 
  cline="${line//[!\|]}"
if [ "${#cline}" -ne 2 ]; then
NUM=$(grep -n "$line" $LAUNCHDIR/playlist/playlist.RadioSure | cut -d : -f1)
sed -i "${NUM}d" $LAUNCHDIR/playlist/playlist.RadioSure
#echo "$line"
fi
done <$LAUNCHDIR/playlist/playlist.RadioSure
echo "---------------"
echo "Done"
) 2>&1 | yad --text-info --window-icon "audio-x-generic.png" --title "Updating Index" --height 300 --width 500 --tail --margins 4 --button="gtk-close"
}
export -f update_index

function save_search () {
if [ ! -f $LAUNCHDIR/tmp/tmp_search_q ]; then
yad --center --borders 5 --width=500 --title "Save search" --text " Only for to save search results to a category list \n Please do a search and try again   " --timeout=5 --button="gtk-close"
else 
ENTRY_TEXT="$(cat $LAUNCHDIR/tmp/tmp_search_q | sed 's/ /_/g;s/\./_/g')"
SAVE=$(yad --center --window-icon "audio-x-generic" --title "Save Search" --text " Please enter a name (without spaces and dots)  \n and it will be saved as: 'playlist.Name' " --entry --entry-text="$ENTRY_TEXT")
mv -f $LAUNCHDIR/tmp/tmp_search $LAUNCHDIR/playlist/playlist.$SAVE
fi
}
export -f save_search 

function add_fav
{
if [ -z "$(cat $LAUNCHDIR/tmp/sel-file 2> /dev/null)" ]; then
yad --center --borders 5 --title "Error" --text "      Nothing selected       " --button="gtk-close"
exit
fi
if [ -f $LAUNCHDIR/tmp/tmp_search ]; then
grep $(cat $LAUNCHDIR/tmp/sel-file) $LAUNCHDIR/tmp/tmp_search >> $LAUNCHDIR/playlist/playlist.Favorites
else
_CAT="$(cat "$LAUNCHDIR"/tmp/tmp_cat)"
[ "$_CAT" != "Favorites" ] && grep $(cat $LAUNCHDIR/tmp/sel-file) $LAUNCHDIR/playlist/playlist.$_CAT >> $LAUNCHDIR/playlist/playlist.Favorites
fi
[ $? -eq 0 ] && yad --center --borders 5 --title "Add to Favorites" --text "   Selection has been added to 'playlist.Favorites'       " --timeout=5 --button="gtk-close" 
}
export -f add_fav

function sel_file
{
echo $1 > $LAUNCHDIR/tmp/sel-file
#    xdg-open "$1" &> /dev/null
}
export -f sel_file

function now_playing () {
exec 4<> $nppipe
echo -e '\f' >> "$nppipe"
while true; do
META=$(tail -n 1 $LAUNCHDIR/tmp/metadata 2> /dev/null)

    echo "$META" >&4
sleep 3
done &
pidnowplay="`ps -eo pid,cmd | grep "yad --title=Now Playing --kill-parent --no-buttons --geometry=500x10-20-40" | grep -v "grep" | awk '{ print $1 }'`"

if [ -z "$pidnowplay" ]; then
yad --title="Now Playing" --kill-parent --no-buttons --geometry=500x10-20-40 --no-focus --undecorated --form --cycle-read --field ": " <&4
sleep 1
elif [ -n "$pidnowplay" ]; then
kill "$pidnowplay" 2> /dev/null
fi

}
export -f now_playing

exec 3<> $fpipe
exec 4<> $nppipe

# add handler to manage process shutdown
function on_exit() {
rm -f "$LAUNCHDIR"/tmp/*
pidnowplay="`ps -eo pid,cmd | grep "yad --title=Now Playing --kill-parent --no-buttons --geometry=500x10-20-40" | grep -v "grep" | awk '{ print $1 }'`"
kill $pidnowplay 2> /dev/null
#    echo "quit" >&3
#    echo "quit" >&4
    rm -f $fpipe
    rm -f $nppipe
}
export -f on_exit

trap on_exit EXIT

 
LISTS=$(ls -t $LAUNCHDIR/playlist/playlist.*)
CATLIST=$(while read -r LIST; do echo "${LIST##*.}" | grep -v 'RadioSure' | tr '\n' '!'; done <<< "${LISTS}")
yad --plug="$fkey" --tabnum=1 --text="Select category or type a search query and click 'Load'" --form --columns=5 --field="Category:CB" "$CATLIST" --field="Search" '' --field="Update Index:fbtn" "bash -c update_index" --field="Load!gtk-add:fbtn" "$load_cmd" --field="gtk-help:fbtn" "bash -c help_info" &

yad --plug="$fkey" --tabnum=2 --window-icon "audio-x-generic.png" --text " Double click to play" --list --no-markup --select-action='bash -c "sel_file %s"'  --dclick-action='bash -c "play_url %s"' --hide-column 1 --print-column=1 --column URL --column Name --column Genre --expand-column=2 $RADIOLIST <&3 &

yad --center --paned --key="$fkey" --button="Now Playing:bash -c now_playing" --button="gtk-save:bash -c save_search" --button="Add to Favorites!gtk-add":'bash -c "add_fav %s"' --button="gtk-stop:bash -c stop_stream" --button="gtk-close:1" --width=790 --height=550 \
    --title="YRadio v0.0.2" --window-icon="find"
[ $? -ne 0 ] && stop_stream

exec 3>&-
exec 4>&-