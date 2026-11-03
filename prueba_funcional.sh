#!/bin/bash
# Criterio: el contenedor servidor-lab existe, corre y responde HTTP 200 en el puerto esperado
PUERTO=$(terraform output -raw url_servidor | sed 's/.*://')

ESTADO=$(docker inspect -f '{{.State.Running}}' servidor-lab 2>/dev/null)
[ "$ESTADO" = "true" ] && echo "OK: contenedor en ejecución" || { echo "FALLO: contenedor no está corriendo"; exit 1; }

CODIGO=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PUERTO)
[ "$CODIGO" = "200" ] && echo "OK: HTTP 200 en puerto $PUERTO" || { echo "FALLO: HTTP $CODIGO"; exit 1; }
