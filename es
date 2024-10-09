#!/bin/sh

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

# Editor de texto simples para TermOne Plus(Emulador de Terminal)
# Dois passos para instalar:
# • 1
# curl https://raw.githubusercontent.com/sharesourcecode/TitansWarMacro/master/es -L -O
# • 2
# sh es
cd $HOME
ls -a
echo ""
echo "• Digite o caminho, ou nome de arquivo:"
unset arquivo
read arquivo

if [ ! -f "$arquivo" ]; then
 echo "“$arquivo” não encontrado. Criando o arquivo “$arquivo”"
 > "$arquivo"
fi

while true; do
 echo ""
 if [ -f "$arquivo" ]; then
  echo "Conteúdo atual de “$arquivo”"
  nl "$arquivo"
  echo ""
 fi
 echo "• Selecione uma opção:"
 echo "A - Adicionar linha"
 echo "B - Substituir linha"
 echo "C - Deletar o arquivo “$arquivo”"
 echo "D - Sair"

 read opcao

 case $opcao in
  A|a|1)
   echo ""
   echo "• Digite o conteúdo a ser adicionado:"
   read nova_linha
   echo "$nova_linha" | sed 's/[\/&]/\\&/g' >> "$arquivo"
  ;;
  B|b|2)
   echo ""
   nl "$arquivo"
   echo ""
   echo "• Digite o número da linha a ser substituída:"
   read numero_linha
   printf "Conteúdo atual da linha “$numero_linha”:\n $(head -n"$numero_linha" "$arquivo" | tail -n1 | sed 's/%/%%/g')\n"
   echo ""
   echo "• Digite o novo conteúdo para a linha “$numero_linha”:"
   read novo_conteudo
   awk -v linha="$numero_linha" -v novo_conteudo="$(echo "$novo_conteudo" | sed 's/[\/&]/\\&/g; s/[\\]/\\\\/g')" 'NR==linha {$0=novo_conteudo} 1' "$arquivo" > temp.txt && mv temp.txt "$arquivo"
  ;;
  C|c|3)
   echo ""
   rm $arquivo
   echo "O arquivo “$arquivo” foi deletado."
  ;;
  D|d|4)
   echo ""
   echo "Saindo..."
   break
  ;;
  *)
   echo ""
   echo "Opção inválida. Tente novamente."
  ;;
  esac
done
