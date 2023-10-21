%include "asm_io.inc"

section .data
    prompt1 db "Enter the first integer: ", 0  ; Prompt for the first integer
    prompt2 db "Enter the second integer: ", 0 ; Prompt for the second integer
    outOp1 db " & ", 0                         ; Symbol for bitwise AND operation
    outOp2 db " | ", 0                         ; Symbol for bitwise OR operation
    outOp3 db " ^ ", 0                         ; Symbol for bitwise XOR operation
    outmsg1 db " is ", 0                      ; Text "is"

section .bss
    num1 resd 1      ; First input integer
    num2 resd 1      ; Second input integer

section .text
    global asm_main

asm_main:
    enter 0, 0   ; Set up the stack frame
    pusha        ; Save registers

    ; Get the first integer input
    mov eax, prompt1
    call print_string
    call read_int
    mov [num1], eax

    ; Get the second integer input
    mov eax, prompt2
    call print_string
    call read_int
    mov [num2], eax

    ; Print the result of the AND operation
    mov eax, [num1]
    call print_int
    mov eax, outOp1
    call print_string
    mov eax, [num2]
    call print_int
    mov eax, outmsg1
    call print_string

    ; Perform the AND operation
    mov eax, [num1]
    mov ebx, [num2]
    and eax, ebx
    call print_int
    call print_nl

    ; Print the result of the OR operation
    mov eax, [num1]
    call print_int
    mov eax, outOp2
    call print_string
    mov eax, [num2]
    call print_int
    mov eax, outmsg1
    call print_string

    ; Perform the OR operation
    mov eax, [num1]
    mov ebx, [num2]
    or eax, ebx
    call print_int
    call print_nl

    ; Print the result of the XOR operation
    mov eax, [num1]
    call print_int
    mov eax, outOp3
    call print_string
    mov eax, [num2]
    call print_int
    mov eax, outmsg1
    call print_string

    ; Perform the XOR operation
    mov eax, [num1]
    mov ebx, [num2]
    xor eax, ebx
    call print_int
    call print_nl

    popa         ; Restore registers
    mov eax, 0   ; Set exit code
    leave        ; Clean up the stack
    ret          ; Return from the function
