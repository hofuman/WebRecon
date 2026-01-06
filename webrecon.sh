#!/bin/bash

EXTENSOES=("php" "txt" "bak" "zip" "old" "log" "conf")
THREADS=10
USER_AGENT="Mozilla/5.0 (WebRecon)"
OUTPUT=""
VERBOSE=true

GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
YELLOW="\e[33m"
RESET="\e[0m"


banner() {
  echo -e "${BLUE}"
  echo "====================================="
  echo "           WebRecon.sh"
  echo "   Directory & File Recon Tool"
  echo "====================================="
  echo -e "${RESET}"
}

uso() {
  echo -e "${YELLOW}Uso:${RESET}"
  echo "./WebRecon.sh <site> <wordlist> [opções]"
  echo
  echo "Opções:"
  echo "  -o <arquivo>   Salvar resultados"
  echo "  -t <threads>   Threads (default: 10)"
  echo "  -s             Modo silencioso"
  exit 1
}

log() {
  if [ "$VERBOSE" = true ]; then
    echo -e "$1"
  fi
  if [ -n "$OUTPUT" ]; then
    echo -e "$(echo "$1" | sed 's/\x1b\[[0-9;]*m//g')" >> "$OUTPUT"
  fi
}

testar_url() {
  local url="$1"
  curl -s -o /dev/null -A "$USER_AGENT" -w "%{http_code}" "$url"
}

scan_item() {
  local base="$1"
  local palavra="$2"

  url_dir="$base/$palavra/"
  code=$(testar_url "$url_dir")

  if [[ "$code" == "200" || "$code" == "301" || "$code" == "302" ]]; then
    log "${GREEN}[+] Diretório:${RESET} $url_dir"

    while read -r sub; do
      sub_url="$url_dir/$sub/"
      sub_code=$(testar_url "$sub_url")

      if [[ "$sub_code" == "200" || "$sub_code" == "301" || "$sub_code" == "302" ]]; then
        log "${BLUE}    ↳ Subdiretório:${RESET} $sub_url"
      fi
    done < "$WORDLIST"

  elif [ "$code" == "403" ]; then
    log "${YELLOW}[!] 403 interessante:${RESET} $url_dir"
  fi

  for ext in "${EXTENSOES[@]}"; do
    url_file="$base/$palavra.$ext"
    fcode=$(testar_url "$url_file")

    if [ "$fcode" == "200" ]; then
      log "${GREEN}[+] Arquivo:${RESET} $url_file"
    elif [ "$fcode" == "403" ]; then
      log "${YELLOW}[!] 403 interessante:${RESET} $url_file"
    fi
  done
}

export -f testar_url scan_item log
export USER_AGENT EXTENSOES GREEN RED BLUE YELLOW RESET OUTPUT VERBOSE WORDLIST


banner

SITE="$1"
WORDLIST="$2"
shift 2

[ -z "$SITE" ] || [ -z "$WORDLIST" ] && uso


while getopts "o:t:s" opt; do
  case $opt in
    o) OUTPUT="$OPTARG" ;;
    t) THREADS="$OPTARG" ;;
    s) VERBOSE=false ;;
    *) uso ;;
  esac
done

[ -n "$OUTPUT" ] && echo "[*] Salvando resultados em $OUTPUT"



log "${YELLOW}[*] Iniciando scan em $SITE${RESET}"
log "${YELLOW}[*] Threads: $THREADS${RESET}"
log "${YELLOW}[*] Wordlist: $WORDLIST${RESET}"
echo

cat "$WORDLIST" | xargs -n 1 -P "$THREADS" -I {} bash -c \
'scan_item "'"$SITE"'" "{}"'
