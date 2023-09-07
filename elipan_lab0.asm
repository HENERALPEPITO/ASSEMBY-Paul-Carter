%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter value of foo: ", 0       ; display
prompt2 db    "Enter value of bar: ", 0
outmsg1 db    "The value of foo is: ", 0
outmsg2 db    "The value of bar is: ", 0
outmsg3 db    "====== After swapping =======", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resd 1

;
; code is put in the .text segment
;
segment .text
global  asm_main
asm_main:
    enter   0,0               ; setup routine
    pusha

    mov     eax, prompt1      ; print out prompt
    call    print_string

    call    read_int          ; read integer
    mov     [input1], eax     ; store into input1

    mov     eax, prompt2      ; print out prompt
    call    print_string

    call    read_int          ; read integer
    mov     [input2], eax     ; store into input2

    ; next print out result message as series of steps
    mov     eax, outmsg1
    call    print_string      ; print out first message
    mov     eax, [input1]     
    call    print_int         ; print out input1
    mov     eax, outmsg2
    call    print_nl          ; print new line
    call    print_string      ; print out second message
    mov     eax, [input2]
    call    print_int         ; print out input2
    call    print_nl          ; print new line

    mov     eax, outmsg3
    call    print_string      ; print out the swapping
    call    print_nl          ; print new line
    ; Swap the values of input1 and input2
    mov     eax, [input1]
    mov     ebx, [input2]
    mov     [input1], ebx
    mov     [input2], eax

    ; Print the swapped values
    mov     eax, outmsg1
    call    print_string      ; print out first message
    mov     eax, [input1]     
    call    print_int         ; print out input1
    mov     eax, outmsg2
    call    print_nl          ; print new line
    call    print_string      ; print out second message
    mov     eax, [input2]
    call    print_int         ; print out input2
    call    print_nl          ; print new line

    mov     eax, 0            ; return back to C
    leave
    ret
