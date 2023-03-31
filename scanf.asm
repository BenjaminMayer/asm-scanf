section .data
msg db 'Enter a string:',0

section .bss
buffer resb 256

section .text
global _start

_start:
    ; Affiche le message de saisie
    mov eax, 4       ; syscall pour afficher un message
    mov ebx, 1       ; stdout
    mov ecx, msg     ; pointeur vers le message
    mov edx, 14      ; longueur du message
    int 0x80         ; appelle le noyau


    ; Boucle d'attente pour les interruptions clavier
    wait_for_input:
        mov ah, 0    ; interruption 16h pour la gestion clavier
        int 0x16         ; appelle le noyau

        ; Si AH = 1C0Dh, alors entrée a été pressé
        cmp ax, 1C0Dh
        jne process_input

        ; Sinon sortir
        jmp end

    ; Gère la touche pressée
    process_input:
        mov ecx, ax      ; la touche pressée
        mov eax, 4       ; syscall pour afficher un message
        mov ebx, 1       ; stdout
        
        mov edx, 1       ; longueur du message
        int 0x80         ; appelle le noyau

        ; Attendre à nouveau
        jmp wait_for_input
    end:
        ret
