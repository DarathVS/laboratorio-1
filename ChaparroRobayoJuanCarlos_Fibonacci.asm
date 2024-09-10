.data
# Mensajes para el usuario
prompt_fib_count: .asciiz "¿Cuántos números de la serie Fibonacci desea generar? "
result_msg:       .asciiz "Los números de la serie Fibonacci son: "
sum_msg:          .asciiz "\nLa suma de los números es: "

.text
main:
    # Solicitar cuántos números de Fibonacci generar
    li $v0, 4                  # syscall para imprimir cadena
    la $a0, prompt_fib_count    # cargar dirección del mensaje
    syscall

    # Leer el número de elementos de Fibonacci desde el usuario
    li $v0, 5                  # syscall para leer entero
    syscall
    move $t0, $v0              # Guardar el número de elementos en $t0

    # Inicializar los primeros dos números de Fibonacci y otras variables
    li $t1, 0                  # f(0) = 0
    li $t2, 1                  # f(1) = 1
    li $t3, 0                  # contador de iteraciones
    li $t4, 0                  # suma total

    # Mostrar el mensaje de los números de Fibonacci
    li $v0, 4                  # syscall para imprimir cadena
    la $a0, result_msg          # cargar dirección del mensaje
    syscall

fibonacci_loop:
    beq $t3, $t0, print_sum     # Si ya hemos generado suficientes números, ir a imprimir suma

    # Imprimir el número de Fibonacci actual
    li $v0, 1                  # syscall para imprimir entero
    move $a0, $t1              # cargar el número actual en $a0
    syscall

    # Sumar el número de Fibonacci actual a la suma total
    add $t4, $t4, $t1

    # Calcular el siguiente número de Fibonacci
    add $t5, $t1, $t2          # t5 = t1 + t2
    move $t1, $t2              # t1 = t2 (mover el siguiente a actual)
    move $t2, $t5              # t2 = t5 (mover el nuevo siguiente)

    # Incrementar el contador
    addi $t3, $t3, 1
    j fibonacci_loop            # Repetir el ciclo

print_sum:
    # Mostrar la suma de los números de la serie Fibonacci
    li $v0, 4                  # syscall para imprimir cadena
    la $a0, sum_msg            # cargar dirección del mensaje
    syscall

    # Imprimir la suma total
    li $v0, 1                  # syscall para imprimir entero
    move $a0, $t4              # cargar la suma total en $a0
    syscall

    # Terminar el programa
    li $v0, 10                 # syscall para salir
    syscall