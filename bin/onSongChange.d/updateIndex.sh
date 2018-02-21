#! /bin/bash -eux 

echo "$0" "$@"

f="$1"

## Sólo en /media
grep -q "^/media/" <<< "$f" || exit

# Restringir extensiones
grep -q -e "ogg$" -e "mp3$" <<< "$f" || exit

# Quitar las /Cuñas/
! grep -q -e "/Cuñas/" <<< "$f"|| exit

now="$( date "+%Y-%m-%d %T" )"

# Este directorio aparece en http://radiomalva.ddns.net:81/~radiomalva/log/
cd ~/public_html/log

echo $f 
( 
	mp3info "$f" || echo "$f" 
	
	# Registra el fichero para el histórico
	echo  "$now - $f" >> latest.txt
	
	# Línea horizontal
	echo -----
	
	tail -200 latest.txt  | # Sacar las 200 últimas canciones
		tac           		# En orden inverso 
) | 
	sed 's#/media/sdb2##g' |   # Quitar el prefijo
	recode utf8..latin1 |      # Pasar a latin1, lo espera  txt2html. CHAPUZA
	sed 's/$/\n/' |            # Añadir una línea en blanco a cada línea
	txt2html --title "Now listening on Radio Malva" --outfile index.html
