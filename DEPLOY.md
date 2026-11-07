# Deploy da API

Domínio: `bigmac-api.gurgelrenan.tech`. VPS: `187.77.50.57` (override com `KAMAL_HOST`).

## Infraestrutura compartilhada

O registro A `bigmac-api.gurgelrenan.tech` aponta para `187.77.50.57`, com proxy Cloudflare ativado. O Traefik existente usa `websecure` e o resolver `letsencrypt`. A imagem é `ghcr.io/gurgelrenan/big-mac-index-api`, arquitetura `amd64`.

Fluxo externo: Cloudflare → Traefik → `big-mac-index-api-router` → `kamal-proxy` → Rails na porta 3000. O frontend `https://bigmac.gurgelrenan.tech` usa `/api/v1` no próprio domínio e encaminha internamente ao mesmo proxy; não depende de CORS nem do DNS público para acessar o Rails.

Os serviços `big-mac-index-api-web-*`, `big-mac-index-api-db` e `big-mac-index-api-router` usam a rede Docker `kamal`. Seus limites de memória são 512 MB, 256 MB e 32 MB, respectivamente. O Fiscaliza continua em `https://deputados.gurgelrenan.tech`, com banco e Redis próprios.

## Preparação

Use Ruby 3.4.4, Bundler e Docker. Execute `bundle install`. Configure `.kamal/secrets` a partir de `.kamal/secrets.example`, com token GHCR com permissão de publicação, `SECRET_KEY_BASE` e senha exclusiva do banco. Nunca versione esses valores.

O DNS A deve apontar para a VPS. O Traefik existente termina HTTPS. Um pequeno Nginx acessório adiciona a rota da API e encaminha ao Kamal Proxy compartilhado; não substitua a configuração do proxy do Fiscaliza nem publique portas 80/443 novamente.

## Publicação

Com as mudanças commitadas:

```sh
bin/kamal accessory boot db  # Apenas no primeiro deploy.
bin/kamal deploy
bin/kamal accessory boot router  # Apenas no primeiro deploy.
bin/kamal app exec 'bundle exec rails import:run'
```

O entrypoint executa `db:prepare` antes do Puma. O importador busca os dados do The Economist e atualiza registros por edição/país. Não depende do seed demonstrativo para servir dados reais. `/up` verifica o boot; valide também `/api/v1/big_macs/latest` e `/api/v1/big_macs` após importar.

## Operação

```sh
bin/kamal app logs
bin/kamal rollback VERSION
bin/kamal accessory logs db
```

PostgreSQL 17 usa diretório persistente exclusivo em `/root/big-mac-index-api-db/big-mac-index-api-postgres`, montado em `/var/lib/postgresql/data`, sem porta pública. Não é um volume Docker nomeado; o caminho é relativo ao diretório do usuário SSH, atualmente `root`. Antes de migrations futuras, faça backup com `pg_dump` e armazene uma cópia fora da VPS. Rollback da imagem não reverte o banco. Não remova o diretório `big-mac-index-api-postgres`.

Para atualizar somente a aplicação: `bin/kamal deploy`. Accessories são gerenciados separadamente. O frontend já usa o proxy `/api` no mesmo domínio; configure CORS somente se outro consumidor de navegador acessar diretamente o domínio público da API.


## Verificação e recuperação

```sh
curl -f https://bigmac-api.gurgelrenan.tech/up
curl -f https://bigmac-api.gurgelrenan.tech/api/v1/big_macs/latest
curl -f https://bigmac.gurgelrenan.tech/api/v1/big_macs/latest
curl -f https://deputados.gurgelrenan.tech/up
```

O build usa o contexto local (`builder.context: .`), incluindo alterações ainda sem commit; revise o diff e registre as mudanças antes de uma release rastreável. `.kamal/`, `.env*` e chaves de credenciais são excluídos da imagem.

Não reinicie nem remova o `kamal-proxy` compartilhado como parte de um deploy normal. Para alterar apenas o router, use `bin/kamal accessory reboot router`. Não remova diretórios ou acessórios do Fiscaliza. Alterações no proxy compartilhado exigem conferir os três domínios.

Após uma mudança de DNS, resolvedores podem reter a resposta anterior. Para diagnosticar diretamente a origem mantendo a verificação de TLS, use `curl --resolve bigmac-api.gurgelrenan.tech:443:187.77.50.57 https://bigmac-api.gurgelrenan.tech/up`; valide também o caminho público pela Cloudflare.

## Backup

Não há backup automático configurado. Para gerar uma cópia antes de migrations, execute localmente com permissão de escrita em um diretório seguro:

```sh
umask 077
ssh root@187.77.50.57 'docker exec big-mac-index-api-db pg_dump -U big_mac_index_api -d big_mac_index_api_production -Fc' > big-mac-index-api.dump
```

Confirme o sucesso do comando SSH, verifique o arquivo com `pg_restore --list big-mac-index-api.dump` e guarde uma cópia fora da VPS e fora do Git. O dump contém dados; não publique o arquivo. Valide restaurações em um banco isolado antes de depender do backup.

## Validação inicial

Release `api-20261106-1`, validada em 6 de novembro de 2026: importação de 2.056 registros, edição mais recente de julho de 2026 com 54 registros e HTTPS funcional na origem e pela Cloudflare. RSpec: quatro exemplos, zero falhas e um pendente preexistente. Os 16 testes Playwright do frontend passaram em produção. O Fiscaliza continuou respondendo com HTTP 200.
