#!/bin/bash

# Configuración
# Project="$HOME/Documentos/ideas/juiciness.md"
Project="$HOME/Documentos/ideas/"
RemoteDest="drive-personal:Deb/Documentos/ideas/"

# Ejecución con verificación de estado
if rclone copy "$Project" "$RemoteDest"; then
    notify-send "Rclone" "Respaldo exitoso de $(basename "$Project")"
else
    notify-send -u critical "Rclone" "⚠️ Error: Respaldo fallido (revisa conexión)"
fi
