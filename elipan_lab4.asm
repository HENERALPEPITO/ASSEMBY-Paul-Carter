;Carl Benedict L. Elipan

%include "asm_io.inc"

section .data
    prompt1 db "Enter a number: ", 0                        ;Display 
    prompt2 db "Enter the number of places to shift: ", 0
    prompt3 db " << ", 0                                    ;Display for shiflt left
    prompt4 db " >> ", 0                                    ;Display for shift right
    prompt5 db " is ", 0                                    ;Display after the shifting

section .bss
    input resd 1       ; input number
    shift resd 1       ; shifted number
    result resd 1      ; Variable to store the result

section .text
    global asm_main

asm_main:
    mov eax, prompt1            ;Load into eax the Enter number Display
    call print_string           ;Display

    call read_int               ;Read the input
    mov [input], eax            ;Load the input nummber in eax

    mov eax, prompt2            ; Load the Enter number places of shift to eax
    call print_string           ;Display the Enter number places of shift

    call read_int               ;Read the input
    mov [shift], eax            ;Load the number of shift input into eax

    mov eax, [input]    ;Load with eax with the number of input
    mov ecx, [shift]   ; Load the shift count from the 'shift' variable into ecx
    shl eax, cl        ; Shift left by the count in cl

    mov [result], eax   ;Load the result of shift left in result variable 

    mov eax, [input]    ;Load with eax with the number of input
    call print_int      ;Display the input

    mov eax, prompt3    ;Load the << shift left symbol in eax
    call print_string   ;Display <<

    mov eax, [shift]    ;Load eax with number of shift
    call print_int      ;Display shift number

    mov eax, prompt5    ;Load the "is" in eax
    call print_string   ;Display is

    mov eax, [result]   ;Load the result in eax
    call print_int      ;Display result


    xor eax, eax    ;Clear the data for less memory consumption
    xor ecx, ecx
    
    call print_nl   ;New Line
    
    mov eax, [input]    ;Load the input again in eax
    mov ecx, [shift]   ; Load the shift count from the 'shift' variable into ecx
    shr eax, cl        ; Shift right by the count in cl
    

    mov [result], eax   ;Load the result in eax
    mov eax, [input]    ;Load eax with the input again
    call print_int      ;Display the eax

    mov eax, prompt4    ;Load the >> shift right symbol in eax
    call print_string   ;Display >>

    mov eax, [shift]    ;Load the shift input in eax
    call print_int      ;Display the shifted number

    mov eax, prompt5    ;Load  "is" in eax  
    call print_string   ;Display is

    mov eax, [result]   ;Load result in eax
    call print_int      ;Display result

    call print_nl       ;New Line

exit_program:
    mov eax, 0          ;Clear the memory
    ret                 ;return from a function
