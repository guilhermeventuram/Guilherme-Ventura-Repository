# helloworld.s
#
# Print out "Hello World"
#
# Copyright (c) 2013, James R. Larus.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# Neither the name of the James R. Larus nor the names of its contributors may be
# used to endorse or promote products derived from this software without specific
# prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

        .data
msg:   .asciiz "Digite um numero inteiro"  #Preparando as mensagens
msg1:  .asciiz "Sucessores: "
msg2:  .asciiz " "
msg3:  .asciiz "FIM! "
numero: .word 1 # Para a leitura de um inteiro
	.extern foobar 4

        .text
        .globl main
main:   li $v0, 4       # Printando na tela
        la $a0, msg     # Passando a mensagem por refencia (string)
        syscall         # Chamando a operação de saída
		
        lw $t1, foobar
		li $v0, 5    #Preparando para a leitura de um inteiro
		syscall      # Chamando a operação de entrada
		
		addi $t0, $v0, 0  #Passando o valor de entrada para o registrador temporario 0
		addi $t1, $t0, 10 #Passando o valor de entrada + 10 para o registrador temporario 1
		addi $t3, $t0, 0 #Passando o valor de entrada para o registrador temporario 3, para que o mesmo sirva de variavel auxiliar
		li $v0, 4       # Chamando a operação de saída
        la $a0, msg1     # Passando a mensagem por refencia (string)
        syscall         # Chamando a operação de saída
		
loop:	slt $t2, $t3, $t1 #Iniciando um loop para printar os proximos 10 sucessores, comparando se o T3<T1 (que possui a entrada + 10)
		beq $t2, $zero, fim # Caso for menor, o codigo continua, caso contrario pula para o fim
		
		addi $t3, $t3, 1 #Adicionando 1 ao t3 para printar na tela e comparar
		li $v0, 1   # Preparando para imprimir um inteiro
		move $a0, $t3 #Movendo valores
		syscall    # Chamando a operação de saída
		
		li $v0, 4        # Printando na tela
        la $a0, msg2     # Passando a mensagem por refencia (string)
        syscall  # Chamando a operação de saída
		
		j loop  #Voltando para o topo do loop (comparação)
		
		
fim:    li $v0, 4       # Printando na tela
        la $a0, msg3     # Passando dessa vez a mensagem final
        syscall   # Chamando a operação de saída
        
        jr $ra          # Fim do codigo
