# WordleX86
Este é um jogo de Wordle feito em assembly x86. O código foi refatorado tomando como base o código feito para o meu [projeto bootloader](https://github.com/saranicoly/bootloader-asm) da cadeira Infraestrutura de Software (IF677) no CIn-UFPE.

### To do...
- [ ] Criar um menu inicial (background, título, iniciar jogo, sair)
- [ ] Atribuir as cores de cada letra (verde para letras certas, amarelo para letras certas na posição errada, vermelho para letras erradas)
- [ ] Criar/Importar um dataset de palavras para o jogo
- [ ] Expandir para Dordle
- [ ] Expandir para Quordle

## Como jogar
Para jogar WordleX86, siga as instruções abaixo:

1. Clone o repositório para sua máquina local com o seguinte comando:

`git clone https://github.com/nathaliafab/WordleX86`

2. Acesse a pasta raiz do projeto:

`cd WordleX86`

3. Compile e rode o código com o comando `make`.

### Instruções
Basta pressionar `Enter` para iniciar o jogo.
O jogo apresentará uma palavra aleatória, e o jogador terá que tentar adivinhar a palavra em até seis tentativas. Para isso, o jogador deve digitar uma palavra de cinco letras e pressionar `Enter`. O jogo irá informar quais letras da palavra escolhida estão corretas e quais estão incorretas. O jogador deve continuar tentando até acertar a palavra completa ou atingir o limite de tentativas.

- Após cada jogada, o jogo irá informar quantas tentativas restantes o jogador possui.
- Caso o jogador acerte a palavra antes do limite de tentativas, o jogo irá parabenizá-lo e perguntar se ele deseja jogar novamente.
- Caso contrário, o jogo informará a palavra correta e perguntará se o jogador deseja jogar novamente.

## Contribuições
Contribuições são sempre bem-vindas! Se você encontrar um bug ou tiver uma ideia para uma melhoria no jogo, por favor, abra uma issue ou envie um pull request.

## Licença
Este projeto está sob a licença MIT. Consulte o arquivo `LICENSE` para obter mais informações.
