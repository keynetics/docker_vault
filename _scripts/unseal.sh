#!/bin/bash
## CONFIG LOCAL ENV
echo "[*] Config local environment..."
export VAULTCMD="docker-compose exec vault vault "
export VAULT_ADDR="https://127.0.0.1:8200"

## UNSEAL VAULT
echo "[*] Unseal vault..."

$VAULTCMD operator unseal -tls-skip-verify -address=${VAULT_ADDR} "$(grep 'Key 1:' ./_data/keys.txt | awk '{print $NF}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"
$VAULTCMD operator unseal -tls-skip-verify -address=${VAULT_ADDR} "$(grep 'Key 2:' ./_data/keys.txt | awk '{print $NF}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"
$VAULTCMD operator unseal -tls-skip-verify -address=${VAULT_ADDR} "$(grep 'Key 3:' ./_data/keys.txt | awk '{print $NF}' | perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g')"
