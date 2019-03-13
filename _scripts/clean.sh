#!/bin/bash
read -r -p "[?] Are you sure you want to remove all Vault's data (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo "[*] Removing files..."
        echo "[+] Removing: ./_data/consul/"
        rm -rf ./_data/consul/
        echo "[+] Removing: ./_data/backup/"
        rm -rf ./_data/backup/
        echo "[+] Removing: ./_data/keys.txt"
        rm -f ./_data/keys.txt
        if [ -d "../secret-ids" ]; then
            echo "[+] Removing: ../secret-ids/*"
            rm -f ../secret-ids/*
        fi
    ;;
    * )
        echo "[*] Aborting..."
    ;;
esac
