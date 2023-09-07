%include "asm_io.inc"

section .data
    ; Description of the problem
    equation_msg db "Problem: When the smallest of three consecutive odd integers is added to four times the largest, it produces a result 729 more than four times the middle integer. Find the numbers and check your answer.", 0
    equation db "Answer:", 0
    first_odd_msg db "The first odd number is: ", 0
    middle_odd_msg db "The middle odd number is: ", 0
    largest_odd_msg db "The largest odd number is: ", 0

section .bss
    ; Reserve memory for the result
    result resd 1   ; Define result as a dword (4 bytes)

section .text
    global asm_main

asm_main:
    ; Print the problem statement
    mov eax, equation_msg
    call print_string
    call print_nl

    ; Display "Answer:" to prepare for the result
    mov eax, equation
    call print_string
    call print_nl
    call print_nl

    ; Calculate the result
    mov eax, 729     ; Store 729 into eax
    sub eax, 16      ; Subtract 16 from eax (729 - 16 = 713)
    mov ebx, 4       ; Store 4 into ebx
    mov ecx, 2       ; Store 2 into ecx
    imul ebx, ecx    ; Multiply ebx by ecx (4 * 2 = 8)
    add eax, ebx     ; Add ebx to eax (713 + 8 = 721)

    ; Store the result in the 'result' variable
    mov [result], eax

    ; Output the value of the result
    mov eax, first_odd_msg
    call print_string
    mov eax, [result]
    call print_int
    call print_nl

    ; Calculate the middle odd integer (result + 2)
    mov eax, [result]
    add eax, 2  ; Store result + 2
    mov ebx, eax
    mov eax, middle_odd_msg
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; Calculate the largest odd integer (result + 4)
    mov eax, [result]
    add eax, 4  ; Store result + 4
    mov ebx, eax
    mov eax, largest_odd_msg
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

exit_program:
    ; Exit the program
    mov eax, 0       ; Return 0 as the exit status
    ret
