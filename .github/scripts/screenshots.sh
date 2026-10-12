#!/usr/bin/env bash
# GameProject: abre o editor de verdade com um projeto de exemplo (cena 3D,
# HUD 2D e script) e captura as telas principais. Coordenadas medidas numa
# tela de 1600x1000 com o tema Project Club.
source "$(dirname "$0")/screenshots-common.sh"

PROJ="$(mktemp -d)/jogo-de-exemplo"
cp -r "$(dirname "$0")/../sample-project" "$PROJ"
export LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8
RENDER=(--rendering-driver opengl3 --rendering-method gl_compatibility)

# Menus do editor (linha y=40)
M_PROJETO=84; M_EDITOR=232; M_AJUDA=287

# 1) Editor com o projeto de exemplo (a primeira abertura importa os arquivos)
"$APP" --editor --path "$PROJ" "${RENDER[@]}" > "$OUT/app.log" 2>&1 &
APP_PID=$!
sleep 45
maximize "GameProject"
sleep 3
key Escape
key ctrl+F2; sleep 2
# enquadra a cena: seleciona o chão e "focar" (F)
click 60 220; sleep 1; key f; sleep 2
shot editor-3d 3
# personagem selecionado: inspetor com as propriedades e o script
click 64 244; sleep 2; shot inspetor 3
# HUD 2D
key ctrl+F1; shot editor-2d 4
# script do personagem (duplo clique no arquivo, na aba Arquivos)
dclick 96 772; sleep 4; shot editor-de-script 3
key ctrl+F2; sleep 2
# janela de adicionar nó
key ctrl+a; shot adicionar-no 3
key Escape; sleep 1
# menus
click $M_PROJETO 40; shot menu-projeto 2
key Escape; sleep 1
click $M_EDITOR 40; shot menu-editor 2
key Escape; sleep 1
click $M_AJUDA 40; shot menu-ajuda 2
key Escape; sleep 1
# rodar o jogo (aparece na aba Jogo, dentro do editor)
key F5; sleep 14; shot jogo-rodando 3
key F8; sleep 4
kill $APP_PID 2>/dev/null; sleep 4

# 2) Gerenciador de projetos (agora com o projeto na lista)
"$APP" --project-manager "${RENDER[@]}" > "$OUT/app-pm.log" 2>&1 &
APP_PID=$!
sleep 25
maximize "GameProject"
shot gerenciador-de-projetos 3
# janela de criar projeto
click 40 62; sleep 3; shot criar-projeto 3
key Escape
finish
