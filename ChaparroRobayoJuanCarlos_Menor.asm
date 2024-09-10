
    syscall
    move $t3, $v0            # guardar el número leído en $t3

    # Comparar el número leído con el mínimo actual
    blt $t3, $t2, update_min # si $t3 < $t2, actualizar el mínimo
    j increment_index        # de lo contrario, ir a incrementar el índice

update_min:
    move $t2, $t3            # actualizar el mínimo con $t3

increment_index:
    addi $t1, $t1, 1         # incrementar el índice
    j read_numbers           # leer el siguiente número

find_min:
    # Mostrar el número menor encontrado
    li $v0, 4                # syscall para imprimir cadena
    la $a0, result_msg       # cargar dirección del mensaje
    syscall

    li $v0, 1                # syscall para imprimir entero
    move $a0, $t2            # cargar el mínimo en $a0
    syscall

end_program:
    li $v0, 10               # syscall para terminar programa
    syscall