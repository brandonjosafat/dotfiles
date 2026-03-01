alias update='sudo apt update && sudo apt upgrade'

alias gta='git add .'
alias gtm='git commit -m "actualización"'
alias gtp='git push origin main'

alias ..='cd ..'
alias ...='cd ../../'
alias ..l='.. && ll'


files() {
	#sino indico carpeta ($1) usa el directorio actual
	local dir="${1:-.}"
    find "$dir" -maxdepth 1 -type f -printf '%TY %s\n' | awk '{size[$1]+=$2} END {for (y in size) printf "%s %.2f GB\n", y, size[y]/1024/1024/1024}' | sort
}

#De forma recursiva
rfiles() {
find . -type f -printf '%TY %s\n' | \
awk '{size[$1]+=$2} END {for (y in size) printf "%s %.2f GB\n", y, size[y]/1024/1024/1024}' | sort
}

#peso de los directorios
sdir() {
	du -h --max-depth=1 | sort -hr
}

#Consumo del usuario en windows
a_win() {
    # Usar el directorio actual si no se especifica uno
    local dir="${1:-.}"

    find "$dir" -maxdepth 1 -type f \
        -not -name "NTUSER.DAT*" \
        -not -name ".*" \
        -printf '%TY %s\n' | \
    awk '{size[$1]+=$2} END {for (y in size) printf "%s %.2f GB\n", y, size[y]/1024/1024/1024}' | sort

    # También analizamos las carpetas principales ignorando AppData y ocultas
    echo "--- Resumen de carpetas de usuario (excluyendo AppData) ---"
    find "$dir" -maxdepth 1 -type d \
        -not -name "AppData" \
        -not -name ".*" \
        -not -path "$dir" \
        -exec du -sh {} +
}
