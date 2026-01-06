# WebRecon.sh

🔍 **WebRecon.sh** é uma ferramenta em Bash para **reconhecimento web**,
focada em: - Descoberta de **diretórios** - Descoberta de **arquivos** -
Enumeração de **subdiretórios** - Identificação de respostas
interessantes como **200, 301, 302 e 403**

Ideal para: - CTFs - Labs (TryHackMe, Hack The Box, etc.) - Estudos de
pentest e bug bounty

------------------------------------------------------------------------

## ✨ Funcionalidades

-   🔎 Bruteforce de **diretórios**
-   📄 Busca por **arquivos** (`.php`, `.txt`, `.bak`, `.zip`, etc.)
-   📂 Entra automaticamente nos diretórios encontrados (1 nível)
-   ⚡ Suporte a **multithread**
-   🚨 Destaque para respostas **403 interessantes**
-   🎨 Saída colorida
-   💾 Exportação de resultados para arquivo
-   🤫 Modo silencioso

------------------------------------------------------------------------

## 📦 Requisitos

-   `bash`
-   `curl`
-   `xargs`

Testado em: - Linux - Kali Linux - Ubuntu

------------------------------------------------------------------------

## 🚀 Instalação

``` bash
git clone https://github.com/hofuman/WebRecon
cd WebRecon
chmod +x webrecon.sh
```

------------------------------------------------------------------------

## ▶️ Uso

### Modo básico

``` bash
./webrecon.sh https://alvo.com wordlist.txt
```

### Salvar resultados em arquivo

``` bash
./webrecon.sh https://alvo.com wordlist.txt -o resultado.txt
```

### Definir número de threads

``` bash
./webrecon.sh https://alvo.com wordlist.txt -t 30
```

### Modo silencioso

``` bash
./webrecon.sh https://alvo.com wordlist.txt -s
```

------------------------------------------------------------------------

## ⚙️ Parâmetros

  Parâmetro      Descrição
  -------------- -----------------------------------
  `<site>`       URL alvo (ex: https://site.com)
  `<wordlist>`   Lista de palavras
  `-o`           Arquivo para salvar os resultados
  `-t`           Número de threads
  `-s`           Ativa modo silencioso

------------------------------------------------------------------------

## 🧪 Exemplo de saída

``` text
[+] Diretório: https://alvo.com/admin/
    ↳ Subdiretório: https://alvo.com/admin/panel/
[+] Arquivo: https://alvo.com/config.php
[!] 403 interessante: https://alvo.com/backup/
```

------------------------------------------------------------------------

## 🛡️ Aviso Legal

Esta ferramenta foi criada **exclusivamente para fins educacionais**.

Utilize apenas em: - Ambientes de laboratório - CTFs - Sistemas onde
você possui **autorização explícita**

❌ Não utilize em sistemas reais sem permissão.\
O autor **não se responsabiliza** por uso indevido.
