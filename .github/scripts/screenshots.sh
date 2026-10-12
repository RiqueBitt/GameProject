#!/usr/bin/env bash
# GameProject: abre o editor de verdade (gerenciador de projetos e um projeto
# de exemplo com cena 3D, HUD 2D e script) e captura as telas principais.
source "$(dirname "$0")/screenshots-common.sh"

PROJ="$(mktemp -d)/jogo-de-exemplo"
cp -r "$(dirname "$0")/../sample-project" "$PROJ"
export LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8
RENDER=(--rendering-driver opengl3 --rendering-method gl_compatibility)

# 1) Gerenciador de projetos
"$APP" --project-manager "${RENDER[@]}" > "$OUT/app-pm.log" 2>&1 &
APP_PID=$!
sleep 25
maximize "GameProject"
shot gerenciador-de-projetos 3
kill $APP_PID 2>/dev/null; sleep 3

# 2) Editor com o projeto de exemplo (a primeira abertura importa os arquivos)
"$APP" --editor --path "$PROJ" "${RENDER[@]}" > "$OUT/app.log" 2>&1 &
APP_PID=$!
sleep 45
maximize "GameProject"
sleep 3
key Escape
key ctrl+F2; shot editor-3d 4
key ctrl+F1; shot editor-2d 4
key ctrl+F3; shot editor-de-script 4
key ctrl+F2; sleep 2
key ctrl+a; shot adicionar-no 3
key Escape; sleep 1
key alt+p; shot menu-projeto 2
key Escape; sleep 1
key alt+e; shot menu-editor 2
key Escape; sleep 1
key F5; sleep 12; shot jogo-rodando 3
key F8; sleep 3
key ctrl+F4; shot aba-jogo 3
key ctrl+F2; sleep 2
key alt+h; shot menu-ajuda 2
key Escape
finish
