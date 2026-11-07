# Big Mac Index API

API independente em Ruby 3.4.4 e Rails 8.1 para consultar edições históricas do Big Mac Index. Usa PostgreSQL e responde em JSON:API.

## Endereços de produção

- API: https://bigmac-api.gurgelrenan.tech
- Edição mais recente: https://bigmac-api.gurgelrenan.tech/api/v1/big_macs/latest
- Frontend: https://bigmac.gurgelrenan.tech

A API e o frontend foram publicados na VPS Hostinger `187.77.50.57` com Docker e Kamal 2. DNS e proxy ficam na Cloudflare; Traefik termina HTTPS. Veja [DEPLOY.md](DEPLOY.md) para instalação, operação, rollback e persistência.

## Desenvolvimento

Instale Ruby 3.4.4, Bundler e PostgreSQL. Configure `config/database.yml` ou `DATABASE_URL` para o banco local.

```sh
bundle install
DISABLE_SPRING=1 bin/rails db:prepare
DISABLE_SPRING=1 bin/rails import:run
DISABLE_SPRING=1 bin/rails server -b 127.0.0.1 -p 3000
```

O frontend é mantido no repositório `big-mac-index-web`; seu proxy Vite encaminha `/api` para `http://127.0.0.1:3000`. `db:prepare` pode carregar o seed demonstrativo em um banco novo: execute `import:run` para carregar o conjunto oficial. A importação acessa a rede e escreve no banco selecionado.

## Contrato e dados

| Método e caminho | Resposta |
| --- | --- |
| `GET /up` | Saúde do boot do Rails; não verifica a completude dos dados |
| `GET /api/v1/big_macs/latest` | Registros da maior data disponível |
| `GET /api/v1/big_macs` | Todas as edições, em ordem decrescente de data |
| `GET /` | Mesmo conteúdo da listagem de todas as edições |

Os registros ficam em `data[].attributes`, incluindo `date`, `iso_a3`, `name`, `currency_code`, `local_price` e `dollar_ex`. Consumidores devem aceitar decimais serializados como strings. Compare preços entre países de uma mesma edição.

`lib/tasks/import.rake` busca o CSV oficial do [The Economist](https://github.com/TheEconomist/big-mac-data) e atualiza registros por data e código do país. A importação não é agendada automaticamente. Preserve a atribuição e a licença dos dados da fonte; o código usa a [licença MIT](LICENSE). Projeto educativo sem afiliação às marcas citadas.

## Testes

```sh
RAILS_ENV=test DISABLE_SPRING=1 bin/rails db:prepare
DISABLE_SPRING=1 bundle exec rspec
DISABLE_SPRING=1 bin/rails zeitwerk:check
```

RSpec cobre modelos e endpoints; SimpleCov gera `coverage/`, ignorado pelo Git. Na validação do deploy inicial, foram executados quatro exemplos, sem falhas e com um exemplo pendente preexistente. O frontend passou nos 16 testes Playwright contra produção.

## Estrutura

- `app/models/`, `app/controllers/` e `app/serializers/`: registros, endpoints e JSON:API.
- `db/migrate/` e `db/schema.rb`: estrutura do PostgreSQL.
- `lib/tasks/import.rake`: importação do CSV.
- `spec/`: testes RSpec e fábricas.
- `Dockerfile`, `config/deploy.yml` e `config/deploy-router.conf`: imagem e publicação.

## Estado do deploy inicial

Em 6 de novembro de 2026, a release `api-20261106-1` importou 2.056 registros. A edição mais recente retornou 54 registros de `2026-07-01`. HTTPS foi validado na origem e pela Cloudflare; o Fiscaliza, hospedado na mesma VPS, permaneceu com HTTP 200. Esses números descrevem a validação inicial e podem mudar após novas importações.
