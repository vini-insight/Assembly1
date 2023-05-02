# Timer em Linguagem Assembly - Problema #1 – 2023.1 


# Demonstração


https://user-images.githubusercontent.com/7541966/232961840-0185417e-be34-4628-bf4e-922c55182c90.mp4


# Fluxograma

![Screenshot](exportCountdownFlowchart.jpg)

https://app.diagrams.net/ (software utilizado para criar o fluxograma)


# Visão Geral do Protótipo

<div>
	<img src="/images/visãoGeralTimer.jpg" alt="img" >
</div>

# Descrição do Projeto e Requisitos

<p>Nos foi apresentado um protótipo (físico e já montado) de um Timer controlado por botões, onde, o usuário pode iniciar, pausar e reiniciar. A contagem é exibida no display LCD 16x2. Além de dois LEDs disponívels para serem usados como quisermos. Este Timer é executado e gerenciado através da Orange Pi PC Plus que também já estava acoplada ao protótipo através da interface GPIO.</p>

<p> Nosso objetivo é desenvolver um software de temporização em Linguagem Assembly para executar e controlar o Timer. Para isto utilizamos algumas instruções do conjunto de instruções da arquitetura ARMv7 (https://developer.arm.com/documentation/ddi0406/latest/).</p>

<p> O tempo inicial deverá ser configurado diretamente no código. Para desenvolver uma biblioteca para uso futuro em conjunto com um programa em linguagem C, a função para enviar mensagem para o display deve estar separada como uma biblioteca (.o), e permitir no mínimo as seguinte operações: Limpar display; Escrever caractere; Posicionar cursor (linha e coluna).</p>

# Funcionamento do Timer

<p>Para iniciar a contagem, é necessário executar o código que deve estar em uma pasta do sistema de arquivos do sistema operacional da Orange Pi. Primeiro abrimos o terminal de comandos e navegamos até a pasta onde se encontra os arquivos do projeto. Então digitamos o comando 'make' e pressionamos enter. O terminal vai pedir a senha de super usuário (sudo). Depois de confirmar a senha o código é executado. </p>

<p>Quando o código é executado, o sistema aguarda o usuário pressionar o botão de iniciar. Nada acontece antes disso. </p>

<p>Depois de pressionar o botão de iniciar, a contagem regressiva é iniciada e os valores são exibidos no display. Antes de terminar a contagem o usuário pode pausar ou reiniciar a contagem a qualquer momento.</p>
	
<p>Para pausar, deve manter o botão pressionado pelo tempo que quiser que o Timer fique parado. Quando soltar o botão ele continua a contagem do ponto onde estava parado.</p>
	
<p>Para reiniciar a contagem o usuário deve manter o botão de reiniciar pressionado por pelo menos um (1) segundo. Após soltar o botão o Timer volta a contagem para o inicio (valor inicial que estava definido no código).</p>

# Makefile

<p>Um makefile é um arquivo que por padrão é chamado de "Makefile". Nele contém um conjunto de diretivas usadas pela ferramenta de automação de compilação make para gerar um alvo/meta(instalar, desinstalar, remover alguns arquivos e outros). Um makefile contém essencialmente atribuições de variáveis, comentários e regras (“targets”). Comentários são iniciados com o carácter "#".</p>

<p>O texto contido em um Makefile é usado para a compilação, ligação(linking), montagem de arquivos de projeto entre outras tarefas como limpeza de arquivos temporários, execução de comandos, etc. Vantagens do uso do Makefile:</p>

*   Evita a compilação de arquivos desnecessários. Por exemplo, se seu programa utiliza 120 bibliotecas e você altera apenas uma, o make descobre (comparando as datas de alteração dos arquivos fontes com as dos arquivos anteriormente compilados) qual arquivo foi alterado e compila apenas a biblioteca necessária.
*   Automatiza tarefas rotineiras como limpeza de vários arquivos criados temporariamente na compilação.
*   Pode ser usado como linguagem geral de script embora seja mais usado para compilação.

<p>O objetivo de Makefile é definir regras de compilação para projetos de software. O programa make interpreta o conteúdo do Makefile e executa as regras lá definidas.</p>

# Ambiente de Desenvolvimento e Testes

A o código Assembly foi desenvolvido utilizando de editor de texto GNU Nano (https://www.nano-editor.org/) acessado diretamente via terminal de comando da Orange Pi. Também utilizamos o Sublime Text (https://www.sublimetext.com/) presente nos computadores do laboratório. Mas poderiam ser usados qualquer outro editor de texto ou IDE.

Para testes foi utilizado o GDB debug (https://www.sourceware.org/gdb/). Foi utilizado um Multímetro para verificar a continuidade da alguns contatos e confirmar informações do mapeamento dos pino GPIO da Orange Pi conectados aos demais componentes eletrônicos do protótipo. Também é possível usar um Osciloscópio para capturar algum sinal dentro do protótipo.

# Arquitetura ARM

ARM significa Advanced RISC Machines, ou Máquinas RISC Avançadas. RISC é acrônimo de Reduced Instruction Set Computer, ou Computador com um conjunto reduzido de instruções. O que mostra que a arquitetura ARM foi inspirado no RISC, onde o objetivo era desenvolver um hardware simples e também um conjunto pequeno de instruções que garanta tamanho reduzido, velocidade e eficiência no consumo de potência.

# Orange Pi PC Plus

<div>
	<img src="/images/Orange Pi PC Plus - Copia.png" alt="img" style="height: 50%; width: 50%;" align="right">
	<p>Orange Pi PC Plus é um SBC Single-Board Card computer, ou, Computador de Cartão de Placa Única. Tem código aberto e usa arquitetura ARM. Suporta alguns Sistemas Operacionais como Android, Debian, Lubuntu, Ubuntu. Orange Pi PC Plus usa Allwinner H3 como CPU.</p>
	<p>A Orange Pi PC Plus pode ser usada para construir um servidor de rede sem fio, jogos, Reprodutor de música e video, entre outros fins. Ela foi projetada para quem deseja usar a tecnologia para criar e inovar.</p>
	<p>O sistema operacional da Orange Pi que utilizamos no laboratório é o Ubuntu Armbian 22.08.8 Jammy. Seu Kernel é Linux 5.15.74-sunxi. Acessamos a placa utilizando um terminal de comandos utilizando protocolo SSH. Para mais informações sobre a Orange Pi, consultar site oficial (http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-PC-Plus.html) </p>
</div>

# SSH

<img src="/images/SSH.png" alt="img" align="center">

<p>SSH é a sigla para Secure Socket Shell. Em tradução livre, significa “Concha de Segurança”, mas pode ser adaptado para o termo “Bloqueio de Segurança”. Sendo um dos protocolos específicos de segurança de troca de arquivos entre cliente e servidor de internet, usando criptografia. O objetivo do SSH é permitir que desenvolvedores ou outros usuários realizem alterações em sites e servidores utilizando uma conexão simples e segura.</p>
<p>Para para abrir conexões desse tipo utilizado o protocolo SSH, o sistema operacional deve ter um clienteSSH de forma nativa ou pode ser instalado. No Linux bastar abrir o Terminal e digitar comando SSH que consiste em 3 partes distintas:</p>

	ssh {user}@{host}
	
<p>O comando da tecla SSH instrui o sistema que deseja abrir uma Conexão de Shell segura criptografada. O {User} representa a conta à qual você deseja acessar. Por exemplo, você pode querer acessar o usuário raiz, que é basicamente sinônimo, para o administrador do sistema, com direitos completos para modificar qualquer coisa no sistema. O {host} refere-se ao computador ao qual você deseja acessar. Este pode ser um endereço IP (por exemplo, 244.235.23.19) ou, um nome de domínio (por exemplo, www.xyzdomain.com).</p>
<p>Quando você pressionar enter, você será solicitado a inserir a senha da conta solicitada. Quando você digitou, nada aparecerá na tela, mas sua senha é, de fato, transmitida. Depois de terminar de digitar, pressione enter mais uma vez. Se sua senha estiver correta, você será saudado com uma janela de terminal remota como na imagem abaixo: </p>

<img src="/images/TERMINAL.png" alt="img" align="center">

## Principais comandos utilizados no terminal

	- ssh {user}@{host}
	- sudo {senha}
	- cd {nome pasta}
	- cd .. (volta para pasta anterior)
	- cat {nomeArquivo}
	- nano {nomeArquivo}
	- mkdir {nome pasta}
	- rm {nomeArquivo}
	- echo > {nomeArquivo}
	- && (para executar dois comandos como por exemplo mkdir novaPasta && cd novaPasta
	- ls
	- cat {nomeArquivo} (apenas ver o conteudo do arquivo)
	- nano {nomeArquivo}
	- nano (atalhos) CTRL + O (salvar) CTRL + X (fechar editor)
	- gpio readall
	- make {senha}
	- gcc
	- gcc t.c && ./t.out
	- gcc c.c -o c && chmod +x c && ./c

<p> </p>


# Processador ARM

<div>
	<img src="/images/allwinnerH3.jpg" alt="img" style="height: 20%; width: 20%;" align="left"> 

    Alguns detalhes e características do processador Allwinner H3:
    - Quad-core Cortex-A7
    - 1.6 GHz
    - arquitetura ARM v7
    - Representação em 32 bits
    - 16 registradores:
           - r0 até r12: são de uso geral
           - r13: Stack Pointer (SP)
           - r14: Link Register (LR)
           - r15: Program Counter (PC)	
</div>    

# GPIO

<div>
	<img src="/images/Pinos GPIO da Orange PI PC plus.jpg" alt="img" style="height: 50%; width: 50%;" align="left">
	<p>GPIO significa General-Purpose Input/Output, ou, Entrada e Saída de Uso Geral. Uma interface de E/S em placas de circuito.</p>
	<p>GPIO é diferente dos padrões de porta comuns (como VGA, HDMI, VDI ou USB). Esses cabos, cada pino conectado dentro da conexão tem uma finalidade definida, que é determinada pelo órgão regulador que criou o padrão.</p>
	<p>A interface GPIO refere-se a um conjunto de pinos. Eles não possui uma função específica, por isso que são chamados de uso geral. Os pino GPIO podem enviar ou receber sinais elétricos que são determinados pelo projetista.</p>
	<p>Embora a maioria dos pinos de uma porta ou interface tenha uma finalidade específica, como enviar um sinal para um determinado componente, a função de um pino GPIO é personalizável e pode ser controlada por software. O GPIO coloca você no comando do que cada pino realmente faz. Existam diferentes tipos de pinos na matriz GPIO.</p>

*   Pinos de finalidade especial, que variam de acordo com o GPIO específico em questão.
*   Pinos GPIO, que podem ser configurados para enviar ou receber sinais elétricos.
*   Pinos de aterramento que não fornecem energia, mas são necessários para completar alguns circuitos.
*   Pinos que fornecem energia em tensões típicas, como 3,3 V ou 5 V (para alimentar dispositivos conectados que não possuem fonte de alimentação própria, como um simples LED.

<p>GPIO São usados por circuitos de sistema em chip (SOC), que incluem um processador, memória e interfaces externas em um único chip. Os pinos GPIO permitem que esses chips sejam configurados para diferentes finalidades e funcionem com diversos tipos de componentes.</p>

<p>As interfaces GPIO são geralmente usadas em conjunto com uma placa de prototipação (Protoboard). Protoboards são um tipo de placa de circuito temporária. Você pode prototipar circuitos adicionando, removendo ou movendo componentes eletrônicos. Muitos projetos que envolvem dispositivos como um Orange Pi fazem com que você monte seu dispositivo em uma placa de ensaio e, em seguida, conecte-o aos pinos GPIO usando fios.</p>

<p>Um dispositivo popular que faz uso de pinos GPIO é o Orange Pi. Esses pinos atuam como interruptores que produzem 3,3 volts quando definidos como ALTO e sem tensão quando definidos como BAIXO. Você pode conectar um dispositivo a pinos GPIO específicos e controlá-lo com um programa de software. Por exemplo, você pode conectar um LED a um GPIO e um pino de aterramento em um Orange Pi. Se um programa de software disser ao pino GPIO para ligar, o LED acenderá.</p>
</div>

# Comando "gpio readall"

<div>
	<p>Para visualizar a flexibilidade de configuração dos pinos GPIO, abaixo segue um print da configuração padrão, quando a Orange Pi acabou de se ligada e o seu sistema operacional iniciado. Apenas digitamos o comando 'gpio readall' no terminal e vemos a saída abaixo:</p>
	<br>
	<img src="/images/Comando gpio readall DefaultSetting.png" alt="img">
	<br>
	<br>
	<p>Observe que a maior parte dos pinos está em modo 'OFF'. No entanto, depois que os pinos GPIO são configurados em linguagem Assembly, executamos novamente no terminal o comando 'gpio readall' e os pinos GPIO são configurados como segue o print abaixo:</p>
	<br>
	<img src="/images/Comando gpio readall PersonalSetting.png" alt="img">
	<br>
	<br>
	<p> É necessário destacar que os pinos GPIO que estão conectados a botões são definidos como 'IN' (entrada) e os pinos GPIO que estão conectados aos LEDs e também ao display LCD estão definidos como 'OUT' (saída).</p>
</div>

# Diagrama de Pinagem do Orange Pi PC Plus v1.2

<div>
<!-- 	<img src="/images/orangePI PC PLUS pinout diagram.png" alt="img" style="height: 20%; width: 20%;" align="left"> -->
	<img src="/images/orangePI PC PLUS pinout diagram.png" alt="img" >
</div>

# Corte detalhado da interface GPIO com os demais componentes

<div>
	<img src="/images/placa de extensão GPIO.jpg" alt="img" >
	<p>Utilizamos uma placa de prototipação (protoboard) para reunir todos os componentes eletrônicos do projeto. A Orange PI e sua porta GPIO é conectada usando uma Placa de Extenção que pode ser vista em destaque na imagem acima. Esta placa de Extenção é de uma Raspberry PI, no entanto, sua interface tem a mesma quantidade de pinos da Orange Pi. Por isso, vamos desconsiderar os nomes inscritos originalmente na Placa de Extenção e vamos adotar a nomenclatura oficial do Diagrama de Pinagem da Orange Pi.</p>
</div>

# Mapeamento dos pinos GPIO

<div>
	<img src="/images/mapeamentoGPIO.jpg" alt="img" >
	<p>Esta seção apresenta o mapeamento dos pinos GPIO com as conexões do display (LCD 16x2), botões (push buttons) e LEDs (Vermelho e Azul) utilizados no projeto. O mapeamento é essencial para garantir a correta comunicação entre o Orange PI e os demais componentes, possibilitando funcionamento das interfaces de usuário.</p>
</div>

# Interface GPIO com o Display LCD 16x2

<div>
	<img src="/images/GPIOtoLCD subtitles.jpg" alt="img" >
	<p>O mapeamento entre a GPIO e o display LCD 16x2 no modo 4 bits é feito por meio da conexão de 7 pinos da porta GPIO da Orange Pi com outros 7 pinos do microcontrolador display (LCD 16x2). Esses 7 pinos são divididos em 4 bits de dados e 3 bits de controle.</p>
	<p>Os 4 bits de dados (DB4 a DB7) são responsáveis por enviar as informações que serão exibidas no display. Já os 3 bits de controle (RS, Enable e RW) são responsáveis por indicar ao display qual informação está sendo enviada (dados ou instruções), quando uma nova informação deve ser lida (sinal de enable) e se a operação será de escrita ou leitura (neste caso, o bit RW é configurado como leitura ou escrita).Neste contexto, o bit referente ao RW é sempre setado como escrita.</p>
	<p>Para o mapeamento, são utilizados os pinos GPIO do microcontrolador, que são configurados como saídas e conectados aos pinos correspondentes no display.</p>
</div>

# Interface GPIO com o Botões e LEDs

<div>
	<img src="/images/GPIOtoLEDSandBUTTONS subtitles.jpg" alt="img" >
	<p>Temos também o mapeamento entre a GPIO e os pinos que se conectam aos LEDs (vermelhor e azul) e botões (push buttons) que pode ser visto em detalhes na imagem acima. Os pinos GPIO conectados aos LEDs são configurados como pinos de Saída e os que estão conectados aos botões são configurados como Entrada. Os botões quando pressionados Iniciam, Pausam, e Reinicial a contagem no Display LCD 16x2. Quando a contagem é iniciada, o LED vermelho está desligado. Permanece desligado até o fim da contagem. Nesse momento é ligado durante apenas um segundo e depois é desligado. O LED azul é ligado quando a contagem começa e desliga quando a contagem termina. </p>	
</div>

# Datasheets

<p> Datasheet significa ficha ou folha de dados. Normalmente são criadas pelo fabricante do produto ou componente eletrônico. Basicamente é um documento que fornece as especificações de desempenho e outras características. O Datasheet forncesse detalhes suficientes que permitem entender o que é o produto ou componente assim como entender a função do componente no sistema geral. Dependendo da finalidade específica, uma folha de dados pode oferecer um valor médio , um valor típico, uma faixa típica, tolerâncias de engenharia ou um valor nominal . O tipo e a fonte dos dados geralmente são declarados na folha de dados. Uma folha de dados é geralmente usada para comunicação comercial, comunicação técnica para descrever as características de um item ou produto, ou para ajudar a usar os produto.</p>

<p>Datasheets podem ser encontrados no site do fabricante ou em qualquer buscador na internet. Para isso basta digitar "datasheet" + "nome do componente" ou "código do componente". Também existem vários sites que reúnem e compartilham milhares de Datasheets funcionando como verdadeiros repositórios para este tipo de informação. Alguns exemplos são: www.alldatasheet.com OU www.datasheetcatalog.com</p>

</p> Neste projeto vamos utilizar dois Datasheets. Um do processador Allwinner H3 (usado pela Orange Pi) e outro que mostra como usar e configurar o Display LCD 16x2. Uma cópia deles pode ser encontrada aqui mesmo neste projeto acessando a pasta "Datasheets" ou clicando direto nesse link: https://github.com/vini-insight/Assembly1/tree/main/Datasheets </p>


## Allwinner H3

<p> O Datasheet do processador forncesse informações do Mapeamento de Memória, do Controle de Portas de Entrada e Saída, além de como se devem configurar os registradores que fazem a gerenciamento do pinos que esta sendo usados na Porta GPIO. Lembrando que a representação é de 32 bits. Lá são detalhados as posições de cada bit e seus respectivos valores para determinadas funções. Basicamente precisamos destas 4 informações abaixo:<p>

	Identificação do Pino
	valor	offset do registrador de função do pino
	valor	menor bit da sequencia de 3 bits (o que gera 8 possibilidades de configurações do pino)
	valor	bits 21:0 (bit correspondente entre 21 e 0) OU bits 13:0 (bit correspondente entre 13 e 0)
	valor	offset do registrador de dados

</p>
</p>
</p>
</p>

## Display LCD 16x2 

</p>
</p>
</p>
</p>
</p>
</p>




# Assembly

<div>
    <p>
        É uma linguagem de programação composta por mnemônicos simples. Ela usa as instruções da arquitetura (ou processador) que estiver sendo usado. Exemplos da linguagem utilizando algumas instruções do conjunto de instruções da arquitetura ARMv7 podem ser vistos nos arquivos de final '.s' neste projeto.
    </p>
</div>


# Lista das instruções Assembly utilizadas no projeto   
    
    
    - ADD                   - CMP                   - SVC                   - AND                   - ORR
    - MOV                   - B                     - PUSH                  - LSL                   - BEQ
    - LDR                   - BL                    - POP                   - LSR                   - BLT
    - STR                   - BGT                   - SUB                   - BIC                   - BX
    

## Descrição das instruções

### ADD

ADD é uma instrução que executa a soma de valores que estão em registradores ou denifidos de forma imediata. A sintaxe é:

    ADD Rdestino, Rtermo1, Rtermo2
    ou
    ADD Rdestino, Rtermo1, #valorImediato

Onde, Rdestino é o registrador de destino. Rtermo1 é o registrador que contém o primeiro operando. Rtermo2 é um segundo operando e #valorImediato é qualquer valor no intervalo 0-4095.

### MOV

A instrução MOV copia o valor de Operand2 em Rd. A sintaxe é:

    MOV Rd, Operand2
    ou
    MOV Rd, #valorImediato
    
Onde, Rd é o registrador de destino. Operand2 é um segundo operando e #valorImediato é qualquer valor no intervalo 0-65535.

### LDR

A instrução LDR carrega um registrador com um valor da memória. A sintaxe é:

    LDR Rd, [Rn, Rm]
    
Onde, Rd especifica o registro a ser carregado. Rn especifica o registro no qual o endereço de memória é baseado. Rm especifica o registro que contém um valor a ser usado como deslocamento


### STR

A instrução STR armazenam um valor de registro na memória. A sintaxe é:

    LDR Rd, [Rn, Rm]
    
Onde, Rd especifica o registro a ser armazenado. Rn especifica o registro no qual o endereço de memória é baseado. Rm especifica o registro que contém um valor a ser usado como deslocamento


### CMP

A instrução CMP comparam o valor em um registrador. A sintaxe é:
    
    CMP{cond} Rn, Operand2
    ou
    CMP{cond} Rn, #valorImediato

Onde, cond é um código de condição opcional. Rn é o registrador ARM contendo o primeiro operando. Operand2 é um segundo registrador. #valorImediato é qualquer valor no intervalo 0-255.

### B

A instrução B causa um desvio incondicional para o rótulo criado. A sintaxe é:

     B label
     
Onde, label é um rótulo criado para marcar onde o programa continuará a execução depois do desvio.


### BL

A instrução BL faz com que um desvio incondicional seja rotulado e copia o endereço da próxima instrução em LR (R14, o registrador de link). A sintaxe é:

     BL label
     
Onde, label é um rótulo criado para marcar onde o programa continuará a execução depois do desvio.


### BGT

A instrução BGT causa um desvio condicional para o rótulo criado. A sintaxe é:

     B{cond} label
     
Onde, label é um rótulo criado para marcar onde o programa continuará a execução depois do desvio. GT (greater than) significa maior que. Desvia se o vaor do primeiro registrador for maior do que o valor do segundo registrador.


### SVC

A instrução SVC (Supervisor Call) é uma instrução usada em sistemas operacionais para fazer chamadas do sistema. A sintaxe é:

    SVC #valorImediato

Onde, #valorImediato é um valor imediato que identifica o serviço do sistema a ser chamado. A instrução SVC interrompe a execução do programa e transfere o controle para o sistema operacional, que então lida com a chamada do sistema


### POP

A instrução POP é usada para retirar valores da pilha. A sintaxe é:

    POP {RlistaReg}

Onde, RlistaReg é uma lista separada por vírgulas de registradores a serem retirados da pilha. A instrução POP é útil para restaurar o estado dos registradores após um salvamento de estado usando a instrução PUSH.


### PUSH

A instrução PUSH é usada para colocar valores na pilha. A sintaxe é:

    PUSH {RlistaReg}

Onde, RlistaReg é uma lista separada por vírgulas de registradores a serem colocados na pilha. A instrução PUSH é útil para salvar o estado dos registradores antes de fazer uma chamada do sistema ou uma operação que possa modificar o estado dos registradores


### SUB

SUB é uma instrução que executa a subtração de valores que estão em registradores ou denifidos de forma imediata. A sintaxe é:

    SUB Rdestino, Rtermo1, Rtermo2

Onde, Rdestino é o registrador de destino. Rtermo1 é o registrador que contém o primeiro operando e Rtermo2 é um segundo operando.

A instrução SUB subtrai o valor do registrador Rtermo2 ou o valor imediato do valor no registrador Rtermo1 e armazena o resultado no registrador de destino Rdestino. O resultado pode ser positivo, negativo ou zero. Caso o resultado seja negativo, a flag N (negativo) é ativada. Caso o resultado seja zero, a flag Z (zero) é ativada.


### AND

AND é uma instrução lógica que faz a operação AND bit a bit entre dois registradores e armazena o resultado em um registrador de destino. A sintaxe é:

    AND Rdestino, Rtermo1, Rtermo2

Onde, Rdestino é o registrador de destino. Rtermo1 e Rtermo2 são os registradores que contém os operandos para a operação AND.

A instrução AND executa uma operação AND bit a bit entre os valores dos registradores Rtermo1 e Rtermo2 e armazena o resultado no registrador de destino Rdestino. O resultado final contém um bit '1' em cada posição em que ambos os operandos tenham um bit '1'.


### LSL

LSL é uma instrução de deslocamento lógico à esquerda (Logical Shift Left) que desloca os bits de um valor de um registrador em uma determinada quantidade de posições para a esquerda. A sintaxe é:

    LSL Rdestino, Rfonte, #quantidade

Onde, Rdestino é o registrador de destino. Rfonte é o registrador que contém o valor a ser deslocado. #quantidade é a quantidade de posições que o valor deve ser deslocado.

A instrução LSL desloca o valor do registrador Rfonte em #quantidade de posições para a esquerda e armazena o resultado no registrador de destino Rdestino. Os bits que saem pela esquerda são perdidos, e os bits que entram na direita são preenchidos com zeros.


### LSR

LSR é uma instrução de deslocamento lógico à direita (Logical Shift Right) que desloca os bits de um valor de um registrador em uma determinada quantidade de posições para a direita. A sintaxe é:

    LSR Rdestino, Rfonte, #quantidade

Onde, Rdestino é o registrador de destino. Rfonte é o registrador que contém o valor a ser deslocado. #quantidade é a quantidade de posições que o valor deve ser deslocado.

A instrução LSR desloca o valor do registrador Rfonte em #quantidade de posições para a direita e armazena o resultado no registrador de destino Rdestino. Os bits que saem pela direita são perdidos, e os bits que entram pela esquerda são preenchidos com zeros.


### BIC

BIC é uma instrução lógica que executa uma operação bit a bit de "bit clear" (limpar bit). Ela limpa os bits de um registrador que correspondem a um segundo registrador (que age como máscara), armazenando o resultado em um terceiro registrador. A sintaxe é:

    BIC Rdestino, Rfonte, Rmascara

Onde, Rdestino é o registrador de destino. Rfonte é o registrador que contém o valor a ser limpo. Rmascara é o registrador que contém a máscara.

A instrução BIC executa uma operação bit a bit de "bit clear" entre os valores dos registradores Rfonte e Rmascara e armazena o resultado no registrador de destino Rdestino. Os bits no Rdestino são os mesmos que no Rfont


### ORR

ORR é uma instrução lógica que executa uma operação bit a bit de "bitwise OR" (ou bit a bit) entre dois registradores e armazena o resultado em um terceiro registrador. A sintaxe é:

    ORR Rdestino, Rtermo1, Rtermo2

Onde, Rdestino é o registrador de destino. Rtermo1 e Rtermo2 são os registradores que contém os operandos para a operação OR.

A instrução ORR executa uma operação bit a bit de "bitwise OR" entre os valores dos registradores Rtermo1 e Rtermo2 e armazena o resultado no registrador de destino Rdestino. O resultado final contém um bit '1' em cada posição em que pelo menos um dos operandos tenha um bit '1'.


### BEQ

BEQ é uma instrução de salto condicional (branch equal) que salta para um endereço de memória especificado se a última comparação (normalmente com a instrução CMP) indicar que dois valores são iguais. A sintaxe é:

    BEQ label

Onde, label é o rótulo da instrução para a qual o salto deve ser feito se a comparação for verdadeira.

A instrução BEQ salta para a instrução rotulada pelo label somente se a última comparação (normalmente com a instrução CMP) indicar que dois valores são iguais. Caso contrário, a execução continua com a próxima instrução após a instrução BEQ.


### BLT

BLT é uma instrução de salto condicional (branch less than) que salta para um endereço de memória especificado se a última comparação (normalmente com a instrução CMP) indicar que o primeiro valor é menor que o segundo. A sintaxe é:

    BLT label

Onde, label é o rótulo da instrução para a qual o salto deve ser feito se a comparação for verdadeira.

A instrução BLT salta para a instrução rotulada pelo label somente se a última comparação (normalmente com a instrução CMP) indicar que o primeiro valor é menor que o segundo. Caso contrário, a execução continua com a próxima instrução após a instrução BLT.


### BX

BX é uma instrução de salto que alterna o processador para executar código em um endereço de memória especificado. A sintaxe é:

    BX Rfonte

Onde, Rfonte é o registrador que contém o endereço de memória para o qual o processador deve saltar.

A instrução BX alterna o processador para executar código em um endereço de memória especificado pelo valor do registrador Rfonte. Isso é útil para implementar saltos para funções em código de assembly.


# Desenvolvedores

| [<img src="https://avatars.githubusercontent.com/u/58979991?v=4" width=115><br><sub>Gabriel Carvalho</sub>](https://github.com/GabCarvaS) | [<img src="https://avatars.githubusercontent.com/u/7541966?v=4" width=115><br><sub>Vinicius Vieira</sub>](https://github.com/vini-insight) | [<img src="https://avatars.githubusercontent.com/u/37885125?v=4" width=115><br><sub>Everton Bruno Silva dos Santos</sub>](https://github.com/evertonbrunosds) |
| :---------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------: |


# Referências

https://embarcados.com.br/introducao-ao-makefile/
http://orion.lcg.ufrj.br/compgraf1/downloads/MakefileTut.pdf
https://terminalroot.com.br/2019/12/como-criar-um-makefile.html#:~:text=Um%20makefile%20%C3%A9%20um%20arquivo,remover%20alguns%20arquivos%20e%20outros).
https://pt.wikibooks.org/wiki/Programar_em_C/Makefiles
https://resultadosdigitais.com.br/marketing/ssh/#:~:text=SSH%20%C3%A9%20a%20sigla%20para,uma%20conex%C3%A3o%20simples%20e%20segura.


<!-- ========================================================


## Tópicos

:small_blue_diamond: [Descrição do Projeto](#descrição-do-projeto-e-requisitos)

:small_blue_diamond: [Ambiente de Desenvolvimento](#ambiente-de-desenvolvimento)

:small_blue_diamond: [Ambiente de Execução](#instalação-configuração-de-ambiente-e-execução)

:small_blue_diamond: [Funcionamento](#funcionamento)

:small_blue_diamond: [Testes e Resultados](#testes-e-resultados)

:small_blue_diamond: [Desenvolvedores](#desenvolvedores)

## Conteúdo

:heavy_check_mark: Códigos detalhadamente comentados;

:heavy_check_mark: Script de compilação tipo Makefile para geração do código executável;

:heavy_check_mark: Detalhamento dos software usados no trabalho, incluindo softwares básicos;

:heavy_check_mark: Arquitetura do computador usado nos testes.



### Arquitetura do computador

Os computadores utilizados para desenvolvimento e testes foram os presentes no LEDS.

## Instalação, configuração de ambiente e execução

<>

## Execução e Testes

Para testar o sistema, basta compilar o código e executá-lo na Orange Pi. É possível usar um osciloscópio ou multímetro para verificar o funcionamento correto dos botões e da contagem de tempo.


<!-- Este projeto consiste em uma solução desenvolvida em Assembly para a Orange Pi PC Plus. -->

<!-- O objetivo é desenvolver um aplicativo de temporização (timer) que apresente a contagem num display LCD 16x2. O tempo inicial deverá ser configurado diretamente no código. Além disso, deverão ser usados 2 botões de controle: 1 para iniciar/parar a contagem e outro para reiniciar a partir do tempo definido.

Com o objetivo de desenvolver uma biblioteca para uso futuro em conjunto com um programa em linguagem C, a função para enviar mensagem para o display deve estar separada como uma biblioteca (.o), e permitir no mínimo as seguinte operações: Limpar display; Escrever caractere; Posicionar cursor (linha e coluna).

O código deve ser escrito em Assembly, permitindo configurar o tempo de contagem e usando botões para controlar início/parada e reinício do temporizador. -->

<!-- ## Funcionamento

O funcionamento do sistema consiste em: o usuário inicia a contagem pressionando o botão. Durante a contagem, o usuário pode pausar ou reiniciar o temporizador pressionando os botões correspondentes.

### Arquitetura

O sistema foi desenvolvido para a Orange Pi PC Plus, utilizando a arquitetura ARM v7. Para compilar o código, é necessário usar o utilitário Makefile, que está incluído no projeto. -->


<!-- ======================================================== -->


<!-- ### Mapeamento de Pinos

Esta seção apresenta o mapeamento dos pinos de entrada/saída (GPIO) com as conexões do display utilizado no projeto. O mapeamento é essencial para garantir a correta comunicação entre o microcontrolador da GPIO e o display, possibilitando o correto funcionamento da interface de usuário.


#### Mapeamento dos Pinos da GPIO para o DISPLAY

O mapeamento entre a GPIO e o display LCD 16x2 no modo 4 bits é feito por meio da conexão de 7 pinos do microcontrolador com 7 pinos do display. Esses 7 pinos são divididos em 4 bits de dados e 3 bits de controle.

Os 4 bits de dados (D4 a D7) são responsáveis por enviar as informações que serão exibidas no display. Já os 3 bits de controle (RS, E e RW) são responsáveis por indicar ao display qual informação está sendo enviada (dados ou instruções), quando uma nova informação deve ser lida (sinal de enable) e se a operação será de escrita ou leitura (neste caso, o bit RW é configurado como leitura ou escrita).Neste contexto, o bit referente ao RW é sempre setado como escrita.

Para o mapeamento, são utilizados os pinos GPIO do microcontrolador, que são configurados como saídas e conectados aos pinos correspondentes no display.

O mapeamento apresentado na tabela abaixo é realizado por meio da identificação dos pinos do microcontrolador que serão utilizados e a correspondência com os pinos do display.

        | GPIO | DISPLAY |
        |------|---------|
        | 40   | D7      |
        | 38   | D6      |
        | 36   | D5      |
        | 32   | D4      |
        | 28   | E       |
        | 22   | RS      |
        | 20   | GND(RW) |

Os pinos do microcontrolador estão conectados aos pinos correspondentes do display para que seja possível exibir as informações corretamente. -->


<!-- ## Testes e Resultados

<>
 -->
<!-- # Assembly1
Assembly1


Produto
códigos detalhadamente comentados;
Script de compilação tipo Makefile para geração do código executável;
Detalhamento dos software usados no trabalho, incluindo softwares básicos;
Arquitetura do computador usado nos testes;

## PBL





Descrição de instalação, configuração de ambiente e execução;
Descrição dos testes de funcionamento do sistema, bem como, análise dos resultados alcançados.



Documentação:
Documentação técnica considerando qualidade da redação (ortografia e gramática), organização dos tópicos, definição do problema, descrição da solução, explicação dos experimentos, análise dos resultados, detalhando os itens não atendidos, se for o caso. -->
