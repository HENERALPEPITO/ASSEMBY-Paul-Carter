;PSEUDOCODE
;input_string = ""
;max = 0 
;for i in input
;   if i = ' '
;        count i = 0
;        continue
;    else 
;        count i = 1
;    for j = i+1 in input
;        if i = j
;            match_found
;            j = ''
;           count i +=1
;            if count > max
;                max =  count
;        else 
;            pass
;        j++    

;for i in count_array
;    if i = max
;        print max_char

;exit:

%include "asm_io.inc"
%define MAX_LENGTH 100

%define SYS_EXIT 1
%define SYS_READ 3
%define STDIN 0
%define STDOUT 1

section .data
    
    ; Strings for output
    header db "FIND THE MAXIMUM OCCURRING CHARACTER IN A STRING", 0
    divider db "================================================", 0
    askstring db "Enter a string: ", 0
    outchar db "Character(s): ", 0
    frequency db "Frequency: ", 

section .bss
    ; Input string buffer
    string1 resb MAX_LENGTH
    ; Array to store character frequencies
    string2 resd MAX_LENGTH
    ; Variable to store string length
    lenstr1 resd 1

section .text
global asm_main

asm_main:
    enter 0, 0
    pusha
    
    ; Printing header messages
    mov eax, header
    call print_string
    call print_nl
    mov eax, divider
    call print_string
    call print_nl
    mov eax, askstring
    call print_string
    call print_nl
    
    ; Reading input string from user
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, string1
    mov edx, MAX_LENGTH
    int 0x80
    dec eax
    mov [lenstr1], eax
    
    ; Initializing registers
    xor eax, eax
    xor edi, edi
    xor ecx, ecx
    xor ebx, ebx 
    xor edx, edx
    
    ; Parsing input string to find character frequencies
    mov esi, string1
    mov di, 0
    
parse_loop:
    cmp ecx, [lenstr1]  ; Check if end of string reached
    je print_result     ; If yes, print the result
    
    push ecx
    mov dl, byte [esi]  ; Load a character from the string
    push esi
    inc esi
    
    mov bx, 0  ; Initializing character count
    
    cmp dl, ' '  ; Checking for space character
    je move_next  ; If space, move to the next character
    
    inc bx  ; Increment character count
    inc ecx  ; Increment string position
    
pass_check:
    cmp ecx, [lenstr1]  ; Check if end of string reached
    je next_iteration  ; If yes, move to the next iteration
    
    xor eax, eax
    mov al, byte [esi]  ; Load another character from the string
    
    cmp al, ' '  ; Check for space character
    je increment_pointers  ; If space, move to the next character
    
    cmp dl, al  ; Compare characters
    je found_match  ; If match found, handle it
    
increment_pointers:
    inc esi  ; Move to the next character
    inc ecx  ; Increment string position
    jmp pass_check  ; Continue checking
    
found_match:
    mov byte [esi], ' '  ; Replace matched character with a space
    inc bx  ; Increment character count for the match
    jmp increment_pointers  ; Move to the next character
    
next_iteration:
    cmp di, bx  ; Compare current count with the max count
    ja move_next  ; If less, move to the next character count
    mov di, bx  ; Update max count
    
move_next:
    pop esi  ; Restore esi
    inc esi  ; Move to the next character in the string
    pop ecx  ; Restore ecx
    
    mov [string2 + 4 * ecx], bx  ; Store the character count
    inc ecx  ; Increment character position
    jmp parse_loop  ; Continue parsing the string
    
print_result:
    xor ecx, ecx  ; Clear ecx for printing
    
    mov eax, outchar
    call print_string  ; Print message for characters
    
    mov esi, string1  ; Load string again for output
    
outchar_loop:
    cmp ecx, [lenstr1]  ; Check if end of string reached
    je outchar_exit  ; If yes, exit
    
    mov eax, [string2 + 4 * ecx]  ; Load character count
    cmp eax, edi  ; Compare with max count
    jne outchar_increment  ; If not equal, increment
    
    mov al, byte [esi]  ; Load character
    cmp al, ' '  ; Check for space character
    je outchar_increment  ; If space, increment
    
    call print_char  ; Print character
    mov al, ' '
    call print_char  ; Print space
    
outchar_increment:
    inc ecx  ; Move to the next character count
    inc esi  ; Move to the next character in the string
    jmp outchar_loop  ; Continue outputting
    
outchar_exit:
    call print_nl  ; Print new line
    mov eax, frequency  ; Load frequency message
    call print_string  ; Print frequency message
    
    mov eax, edi  ; Load max frequency count
    call print_int  ; Print max frequency
    
close:
    call print_nl  ; Print new line
    popa  ; Restore registers
    mov eax, 0  ; Return 0
    leave
    ret
