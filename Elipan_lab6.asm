%include "asm_io.inc"

section .data
    prompt1 dd "Enter a number to calculate its factorial: ", 0
    result dd "! = ", 0

section .bss
    num resd 1

section .text
    global asm_main

asm_main:
    enter 0, 0     ; Set up stack frame
    pusha          ; Save registers

    mov eax, prompt1    ; Load the prompt message address
    call print_string   ; Display the message
    call read_int       ; Read an integer from the user and store it in EAX
    mov [num], eax      ; Store the entered number in the 'num' variable

    call print_int      ; Display the entered number
    mov eax, result     ; Load the result message address
    call print_string   ; Display the string "! = "

    mov eax, [num]      ; Load the entered number into EAX
    mov ecx, [num]      ; Copy the entered number to ECX (used for decrementing)
    sub ecx, 1          ; Subtract 1 from ECX to prepare for factorial calculation

    cmp  eax, 1         ; If input is 1 return 1
    je   condition      
    cmp  eax, 0         ;if input is 0 return 1
    je   condition

    call factorial       ; Call the factorial function
    call print_int       ; Display the result
    call print_nl        ; Print a new line

condition:
    mov     eax, 1      ;print 1 output
    call    print_int
    call    print_nl


_exit:
    popa                 ; Restore registers
    mov eax, 0           ; Set return value
    leave                ; Clean up stack frame
    ret                  ; Return to the caller

factorial:
    imul eax, ecx         ; Multiply EAX by ECX, updating the factorial result
    loop factorial        ; Loop until ECX becomes 0, decrementing ECX in each iteration
    ret                   ; Return the result in EAX