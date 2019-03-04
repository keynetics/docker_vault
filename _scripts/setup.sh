#!/bin/bash
## CONFIG LOCAL ENV
echo "[*] Config local environment..."
export VAULT_CMD='docker-compose exec vault vault '
export VAULT_ADDR=http://127.0.0.1:8200

## INIT VAULT
echo "[*] Init vault..."
$VAULT_CMD operator init -address=${VAULT_ADDR} > ./_data/keys.txt
export VAULT_TOKEN=$(grep 'Initial Root Token:' ./_data/keys.txt | awk '{print substr($NF, 1, length($NF)-1)}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')

## UNSEAL VAULT
echo "[*] Unseal vault..."
$VAULT_CMD operator unseal -address=${VAULT_ADDR} "$(grep 'Key 1:' ./_data/keys.txt | awk '{print $NF}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"
$VAULT_CMD operator unseal -address=${VAULT_ADDR} "$(grep 'Key 2:' ./_data/keys.txt | awk '{print $NF}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"
$VAULT_CMD operator unseal -address=${VAULT_ADDR} "$(grep 'Key 3:' ./_data/keys.txt | awk '{print $NF}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"

## AUTH
echo "[*] Auth..."
$VAULT_CMD login -address=${VAULT_ADDR} "${VAULT_TOKEN}"

## CREATE USER
echo "[*] Create user... Remember to change the defaults!!"
$VAULT_CMD auth enable  -address=${VAULT_ADDR} userpass
$VAULT_CMD policy write -address=${VAULT_ADDR} admin ./config/admin.hcl
$VAULT_CMD write -address=${VAULT_ADDR} auth/userpass/users/webui password=webui policies=admin

## CREATE BACKUP TOKEN
echo "[*] Create backup token..."
$VAULT_CMD token create -address=${VAULT_ADDR} -display-name="backup_token" | awk '/token/{i++}i==2' | awk '{print "backup_token: " $2}' >> ./_data/keys.txt
