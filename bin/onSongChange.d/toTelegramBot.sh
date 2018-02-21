#! /bin/bash -eux 

echo "$0" "$@"

f="$1"

## Sólo en /media
grep -q "^/media/" <<< "$f" || exit

# Restringir extensiones
grep -q -e "ogg$" -e "mp3$" <<< "$f" || exit

# Quitar las /Cuñas/
! grep -q -e "/Cuñas/" <<< "$f"|| exit

# Registra en el temporal para el robot de TG
echo -n "$f" > /tmp/nowplaying.txt

# Mensaje para Telegram
(
echo "Now playing: $f"
mp3info "$f" || true
) | sed 's#/media/sdb2##g' | tgToChannel.sh  || echo Could not send to Telegram
