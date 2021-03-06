# Docker + Consul + Vault

How to use docker-compose to spin up a Vault instance backed by Consul.

A full description can be found on my website: https://www.marcolancini.it/2017/blog-vault/

No longer using djenriquez/vault-ui, since native Vault UI is used. Access is via [https://localhost:8200/ui/](https://localhost:8200/ui/) once vault is unsealed.

![Vault UI](https://www.datocms-assets.com/2885/1523334283-step3.png)

WARNING: [This issue](https://github.com/hashicorp/vault/issues/3869) was solved in Mac OS X by using `perl -pe 's/\x1b\[[0-9;]*[a-zA-Z]//g'` in some of the scripts when pulling values from keys.txt.


## Usage

#### First Run

1. Start services: `docker-compose up`
2. Init vault:     `./_scripts/setup.sh`
3. When done:      `docker-compose down`

Data will be persisted in the `_data` folder.


#### Subsequent Runs

1. Start services: `docker-compose up`
2. Unseal vault:   `_scripts/unseal.sh`


#### Backup

1. Start services: `docker-compose up`
2. Run backup:     `_scripts/backup.sh`


#### Remove all data

1. Stop services: `docker-compose down --volumes`
2. Clear persisted data: `_scripts/clean.sh`
