# Assembly1
Assembly1


Produto
códigos detalhadamente comentados;
Script de compilação tipo Makefile para geração do código executável;
Detalhamento dos software usados no trabalho, incluindo softwares básicos;
Arquitetura do computador usado nos testes;

### Descrição dos tipos de instruções utilizadas;

    add
    mov    
    ldr
    str    
    cmp    
    b
    bl
    bgt
    svc
    pop
    push
    sub    
    

## ADD

ADD é uma instrução que executa a soma de valores que estão em registradores ou denifidos de forma imediata. A sintaxe é:

    ADD Rdestino, Rtermo1, Rtermo2
    ou
    ADD Rdestino, Rtermo1, #valorImediato

Onde, Rdestino é o registrador de destino. Rtermo1 é o registrador que contém o primeiro operando. Rtermo2 é um segundo operando e #valorImediato é qualquer valor no intervalo 0-4095.

## MOV

A instrução MOV copia o valor de Operand2 em Rd. A sintaxe é:

    MOV Rd, Operand2
    ou
    MOV Rd, #valorImediato
    
Onde, Rd é o registrador de destino. Operand2 é um segundo operando e #valorImediato é qualquer valor no intervalo 0-65535.

## LDR

A instrução LDR carrega um registrador com um valor da memória. A sintaxe é:

    LDR Rd, [Rn, Rm]
    
Onde, Rd especifica o registro a ser carregado. Rn especifica o registro no qual o endereço de memória é baseado. Rm especifica o registro que contém um valor a ser usado como deslocamento


## STR

A instrução STR armazenam um valor de registro na memória. A sintaxe é:

    LDR Rd, [Rn, Rm]
    
Onde, Rd especifica o registro a ser armazenado. Rn especifica o registro no qual o endereço de memória é baseado. Rm especifica o registro que contém um valor a ser usado como deslocamento


## CMP

A instrução CMP comparam o valor em um registrador. A sintaxe é:
    
    CMP{cond} Rn, Operand2
    ou
    CMP{cond} Rn, #valorImediato

Onde, cond é um código de condição opcional. Rn é o registrador ARM contendo o primeiro operando. Operand2 é um segundo registrador. #valorImediato é qualquer valor no intervalo 0-255.






## PBL





Descrição de instalação, configuração de ambiente e execução;
Descrição dos testes de funcionamento do sistema, bem como, análise dos resultados alcançados.



Documentação:
Documentação técnica considerando qualidade da redação (ortografia e gramática), organização dos tópicos, definição do problema, descrição da solução, explicação dos experimentos, análise dos resultados, detalhando os itens não atendidos, se for o caso.
