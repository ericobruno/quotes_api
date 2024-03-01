# README


## Dependências do Sistema

Para executar este projeto, você precisará ter os seguintes itens instalados:

- Ruby (versão 2.7.0)
- Rails (versão 7.0.8)
- MongoDB
- Redis


## Como executar

-Clone o repositório para sua máquina local.
-Instale as dependências
-Inicie o MongoDB e o Redis em seu sistema.
-Inicie o servidor Sidekiq
-Inicie o servidor Rails

## Funcionamento

Para buscar citações por tag, envie uma requisição GET para /api/quotes/:tag, substituindo :tag pela tag desejada. A autenticação é necessária, então inclua o token de API no cabeçalho Authorization da sua requisição. (Key:Value/Authorization:Token)


* Services (job queues, cache servers, search engines, etc.)
 Um job do Sidekiq é configurado para executar a cada 12 horas, atualizando as citações para cada tag única presente no banco de dados, garantindo que os dados se mantenham atualizados.


## Soluçao adotada

O projeto foi estruturado em torno de três componentes principais:

Controller de Citações (QuotesController): Responsável por processar as requisições HTTP, autenticar o acesso e retornar as citações correspondentes à tag solicitada.

Serviço de Crawling (QuotesCrawlerService): Este serviço é chamado pelo controller ou pelo job do Sidekiq para buscar novas citações de um site de cotações. Ele faz o scraping das citações e as armazena no MongoDB se ainda não existirem.

Job de Atualização (UpdateQuotesJob): Configurado para executar via Sidekiq, este job chama o serviço de crawling para cada tag distinta presente no banco de dados, atualizando as citações de maneira assíncrona.
