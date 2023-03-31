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
        mov eax, 0x16    ; interruption 16h pour la gestion clavier
        int 0x80         ; appelle le noyau

        ; Si AH = 0, alors une touche a été pressée
        cmp ah, 0
        je process_input

        ; Sinon, attendre à nouveau
        jmp wait_for_input

    ; Gère la touche pressée
    process_input:
        mov eax, 4       ; syscall pour afficher un message
        mov ebx, 1       ; stdout
        mov ecx, ah      ; la touche pressée
        mov edx, 1       ; longueur du message
        int 0x80         ; appelle le noyau

        ; Attendre à nouveau
        jmp wait_for_input
