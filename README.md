# Assembly1
Assembly1


Produto
códigos detalhadamente comentados;
Script de compilação tipo Makefile para geração do código executável;
Detalhamento dos software usados no trabalho, incluindo softwares básicos;
Arquitetura do computador usado nos testes;

### Descrição dos tipos de instruções utilizadas;

    add
    push
    mov
    sub    
    str
    ldr
    cmp    
    b
    bl
    bgt
    pop
    svc

## ADD
ADD é uma instrução que executa a soma de valores que estão em registradores ou denifidos de forma imediata. Pode ser executada como:

    ADD Rdestino, Rtermo1, Rtermo2
    ou
    ADD Rdestino, Rtermo1, #valorImediato

Onde, Rdestino é o registrador de destino. Rtermo1 é o registrador que contém o primeiro operando. Rtermo2 é um segundo operando e #valorImediato é qualquer valor no intervalo 0-4095.

## MOV
A instrução MOV copia o valor de Operand2 em Rd.
    MOV Rd, Operand2
    ou
    MOV Rd, #valorImediato
Onde, Rd é o registrador de destino. Operand2 é um segundo operando e #valorImediato é qualquer valor no intervalo 0-65535.

    








Descrição de instalação, configuração de ambiente e execução;
Descrição dos testes de funcionamento do sistema, bem como, análise dos resultados alcançados.



Documentação:
Documentação técnica considerando qualidade da redação (ortografia e gramática), organização dos tópicos, definição do problema, descrição da solução, explicação dos experimentos, análise dos resultados, detalhando os itens não atendidos, se for o caso.
