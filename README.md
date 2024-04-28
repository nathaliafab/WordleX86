<div align="center">
  <img src="/screenshots/menu_title.png">
  <p>(inimiga do design?)</p>
</div>

---

Este é um jogo de Wordle feito em assembly x86. O código foi refatorado tomando como base a ideia para o meu [projeto bootloader](https://github.com/saranicoly/bootloader-asm) da cadeira Infraestrutura de Software (IF677) no CIn-UFPE.

## Como jogar
### Pré-requisitos
Antes de começar a jogar, certifique-se de ter instalado os seguintes programas:

- **NASM:** é um montador e desmontador usado para converter código assembly em código de máquina. 

- **QEMU:** é um emulador de processador que permite que você simule um PC dentro de outro PC.

### 💻 Instalação e Execução
Para jogar, siga os passos abaixo:

1. Clone o repositório para sua máquina local com o seguinte comando:

`git clone https://github.com/nathaliafab/WordleX86`

2. Acesse a pasta raiz do projeto:

`cd WordleX86`

3. Compile e rode o código com o comando `make`.

### 📜 Instruções
- Pressione **Enter** para iniciar o jogo.
- Uma palavra será escolhida aleatoriamente do arquivo [words.asm](words.asm).
- Digite uma palavra de cinco letras e pressione **Enter**.
- O jogo indicará quais letras estão corretas ou incorretas na palavra que você escolheu.
- Continue tentando até adivinhar a palavra ou usar todas as seis tentativas disponíveis.
- Ao final, a palavra correta será revelada. Para jogar novamente, pressione **Enter**.

## 📷 Screenshots

| Menu inicial                    | Tentativa do jogador              |
|:----------------------------:|:---------------------------------:|
| ![](/screenshots/menu_title.png) | ![](/screenshots/try.png) |
| **Acertou a palavra**               | **Errou a palavra**                 |
| ![](/screenshots/you_win.png) | ![](/screenshots/you_lose.png) |

## 🦝 Contribuições
Contribuições são sempre bem-vindas! Se você encontrar um bug ou tiver uma ideia para uma melhoria no jogo, por favor, abra uma issue ou envie um pull request.

## Licença
Este projeto está sob a licença MIT. [Consulte o arquivo para obter mais informações](LICENSE).
