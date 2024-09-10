.data
# Mensajes para el usuario
prompt_count: .asciiz "¿Cuántos números desea comparar (entre 3 y 5)? "
prompt_input: .asciiz "Ingrese un número: "
result_msg:  .asciiz "El número mayor es: "

.text
main:
    # Solicitar al usuario cuántos números desea comparar
    li $v0, 4                # syscall para imprimir cadena
    la $a0, prompt_count     # cargar dirección del mensaje
    syscall

    # Leer el número de elementos desde la entrada
    li $v0, 5                # syscall para leer entero
    syscall
    move $t0, $v0            # guardar el número de elementos en $t0

    # Validar el número de elementos
    blt $t0, 3, end_program  # si < 3, terminar programa
    bgt $t0, 5, end_program  # si > 5, terminar programa

    # Inicializar el índice y el máximo
    li $t1, 0                # índice
    li $t2, -2147483648      # inicializar máximo a valor más bajo

read_numbers:
    beq $t1, $t0, find_max   # si hemos leído todos los números, ir a find_max

    # Solicitar un número al usuario
    li $v0, 4                # syscall para imprimir cadena
    la $a0, prompt_input     # cargar dirección del mensaje
    syscall

    # Leer el número desde la entrada
    li $v0, 5                # syscall para leer entero
    syscall
    move $t3, $v0            # guardar el número leído en $t3

    # Comparar el número leído con el máximo actual
    bgt $t3, $t2, update_max # si $t3 > $t2, actualizar el máximo
    j increment_index        # de lo contrario, ir a incrementar el índice

update_max:
    move $t2, $t3            # actualizar el máximo con $t3

increment_index:
    addi $t1, $t1, 1         # incrementar el índice
    j read_numbers           # leer el siguiente número

find_max:
    # Mostrar el número mayor encontrado
    li $v0, 4                # syscall para imprimir cadena
    la $a0, result_msg       # cargar dirección del mensaje
    syscall

    li $v0, 1                # syscall para imprimir entero
    move $a0, $t2            # cargar el máximo en $a0
    syscall

end_program:
    li $v0, 10               # syscall para terminar programa
    syscall