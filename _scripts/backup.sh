#!/bin/bash
echo "[*] Executing backup..."
docker-compose run backup consul-backup -i consul:8500 -t "$(grep 'backup_token:' ./_data/keys.txt | awk -v RS='\r\n' '{printf $2}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"  backup_$(date +%Y-%m-%d)
