# riscv
Repositorio para a disciplina de arquiteturas não convencionais

Todos os passos assumem que o software *QuestaSim* já está sendo executado no diretório do projeto e os comandos apresentados posteriormente devem ser executados no terminal do software e *não da sua máquina*. Para fazer isso existem duas opções:

### Linha de comando
No terminal do software *QuestaSim*
```
cd <caminho/para/o/projeto>
```
### Navegador do software
File > Change Directory, navegar até a pasta onde o repositório foi clonado.

## Setup
Altere `path_to_quartus` no arquivo `verilog-library-setup.tcl` para apontar para a localização do Quartus na sua 
máquina.

## Na primeira execucao:
Para realizar a inicialização do projeto, é preciso a criação de arquivos e diretórios específicos. Um script é provido para facilitar.
```
do run_questa_ini.do
```

## Testes:
Executar o script completo
```
do run_questa.do
```
São disponibilizados scipts para testes de cada ciclo do pipeline:
 - fetch
 - decode
 - execute
 - memory
 - write back

Executar o script de decoder:
```
do run_decoder.do
```
