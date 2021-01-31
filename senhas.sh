 #!/bin/bash
  ##########################################################################
  #### SUPORTE REGIONAL - SANTA INÊS - MA
  #### Nilsonlinux
  export DIRETORIO="$(dirname "$(readlink -f "$0")")"
##########################################################################
  OPEN="play $DIRETORIO/sounds-alert/window-new.oga"
  CLOSE="play $DIRETORIO/sounds-alert/window-close.oga"
  ERRO="play $DIRETORIO/sounds-alert/erro.oga"
  CONECTADO="play $DIRETORIO/sounds-alert/ok.oga" 
##########################################################################
VAR_FORM=$( \
   ${OPEN} | yad --form \
        --center \
        --title="CRIAÇÃO DE SENHAS " \
        --width=400 \
        --height=250 \
        --image="$DIRETORIO/img/senhas.svg" \
        --field="Nome:" "" \
        --field="Cargo":CB Operador!Fiscal!CPD \
        --field="Código de barras:":FL "$HOME/Pictures" \
        --field="Salvar dados em:":DIR "$HOME" \
) 
##########################################################################
nome=$(echo "$VAR_FORM" | cut -d"|" -f 1)
cargo=$(echo "$VAR_FORM" | cut -d"|" -f 2)
foto=$(echo "$VAR_FORM" | cut -d"|" -f 3)
salvar=$(echo "$VAR_FORM" | cut -d"|" -f 4)
##########################################################################
DADOS_USUARIO="<table border=0><br/>
         <td><center><img --width=60 --height=20 src='$DIRETORIO/img/logo_mateus.png' /></td></tr>
         <td><center>$nome</td></tr>
         <td><center><img --width=100 --height=30 src='$foto' /></td></tr>
         <td><center>$cargo</td></tr>
      </table>" 

#########################################################################
# Verificação se há uma foto
if [ -e "$foto" ]
then
  clear # Limpando a tela...
else
  foto=img/semfoto.png # Caso a foto não exista adiciona uma padrão
fi
# end Verificação da foto
source modelCh.sh
# Verificando se o usuario digitou pelo menos o nome
if [ -z $nome ]
then
# Notificação de erro para gerar codigo
yad --title="Desculpe, ocorreu um erro !"       \
    --center                                    \
    --width=350                                 \
    --height=100                                \
    --fixed                                     \
    --text="Não foi possivel gerar o codigo"    \
    --text-align=center                         \
    --button=Fechar
else
  # Enviado dados para um arquivo HTML
echo $DADOS_USUARIO > senha.html
##########################################################################
${CONECTADO} | xdg-open senha.html 
#.EOF

  # Notificação de sucesso para gerar codigo
  clear # Limpando a tela do terminal
  yad --title="Parabéns, Código Gerado !"            \
      --center                                       \
      --width=350                                    \
      --height=110                                   \
      --progress-text="Concluido 100%  !"            \
      --percentage=99                                \
      --progress --auto-kill                         \
      --fixed                                        \
      --text-align=center                            \
      --button=Fechar                                \
      --text="Código do(a) $nome gerado com sucesso"
fi # end if
