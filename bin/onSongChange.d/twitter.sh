#! /bin/bash -eux

echo "$0" "$@"

f="$1"

## Sólo en /media
grep -q "^/media/" <<< "$f" || exit

# Restringir extensiones
grep -q -e "ogg$" -e "mp3$" <<< "$f" || exit

# Quitar las /Cuñas/
! grep -q -e "/Cuñas/" <<< "$f"|| exit


# Tuit a la cuenta de Radio Malva

grep -q -e "/Podcast/" -e "/Programas/" <<< "$f" || exit  # Sólo Podcast y Programas

h="$(echo $f| cut -d'/' -f4)"
g="$(echo $f| sed 's/.$h//' | cut -d'/' -f5)"


case "$h" in 

Programas)  
     k="http://radiomalvapodcast.wordpress.com"
     ;;
Podcast) 
     i="$(basename "$f")"
     j="$(sqlite3 ~/.config/gpodder/database.sqlite "select title FROM episodes WHERE filename='$i'")"
     TITLE="$(echo "$j"|sed "s/\’/'/g")"
     k="$(sqlite3 ~/.config/gpodder/database.sqlite "select link from channels where foldername='$g'")"
     eyeD3  --title="$TITLE" "$f"
     ;;
esac

(
echo "Ahora sonando en Radio Malva: $g" 
eyeD3 --rfc822 "$f" | grep Title | cut -d':' -f2 || true
echo "Escúchalo en el 104.9FM, en radiomalva.org o en podcast: $k"
) | ~/bin/autotwt.sh
