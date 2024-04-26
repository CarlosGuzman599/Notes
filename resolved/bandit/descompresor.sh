#!/bin/bash
descomprimir=$(7z l content.gzip | grep "Name" -A 2 | tail -n1 | awk 'NF{print $NF}')
7z x content.gzip > /dev/null 2>&1
while true; do
    7z l $descomprimir > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ]; then
        siguiente=$(7z l $descomprimir | grep "Name" -A 2 | tail -n1 | awk 'NF{print $NF}')
        7z x $descomprimir > /dev/null 2>&1 && descomprimir=$siguiente
    else
        cat $descomprimir; rm data*
        exit 1
    fi
done