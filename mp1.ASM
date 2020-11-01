;формат выходного файла
format PE Console

;точка входа
entry start

include 'win32a.inc'

section '.data' data readable writable

        formatNum db '%d', 0

        strStart db 'Program has started.', 0
        strEnterNum db 'Enter [%d] number:', 0
        strTrue db 'Numbers are relatively simple.'
        strFalse db 'Numbers are not relatively simple.'

        mas rw 5
        first du 0
        second du 0
        del du 1
        relsimple dw 1

        temp1 dd ?
        temp2 dd ?

        inCycle dd 1
        ecxS dd ?
        espS dd ?
        relsimpleEspS dd ?
        inEspS dd ?

        NULL = 0

section '.code' code readable executable

        start:
                call inputMas
                call relsimpleTest

                cmp [relsimple], 0
                je finish


                trueFinish:
                        push strTrue
                        call [printf]

                finish:

                        call [getch]

                        push NULL
                        call [ExitProcess]

        inputMas:
                mov [espS], esp
                mov ebx, mas
                mov ecx, 5
                masLoop:
                        mov [temp1], ebx
                        mov [ecxS], ecx
                        mov eax, 5
                        sub eax, [ecxS]
                        mov [temp2], eax

                numberInput:
                push [temp2]
                push strEnterNum
                call [printf]

                push ebx
                push formatNum
                call [scanf]

        inputEnd:
                mov esp, [espS]
                ret

        relsimpleTest:

                mov [espS], esp

                mov ebx, mas
                mov [temp1], ebx


                mov ecx, 4
                mov [ecxS], ecx

                simpleTest:
                        mov ebx, [temp1]
                        mov dx, [ebx]
                        mov [first], dx
                        add ebx, 2
                        mov [temp1], ebx
                        mov [temp2], ebx
                        mov [ecxS], ecx

                        call inCycle

                        mov ecx, [ecxS]
                        loop simpleTest

                testFinish:

                          mov esp, [espS]
                          ret



section '.idata' import data readable writable

        library kernel, 'kernel32.dll',\
        msvcrt, 'msvcrt.dll',\
        user32, 'USER32.DLL'

include 'api\user32.inc'
include 'api\kernel32.inc'
    import kernel,\
           ExitProcess, 'ExitProcess',\
           HeapCreate,'HeapCreate',\
           HeapAlloc,'HeapAlloc'
  include 'api\kernel32.inc'
    import msvcrt,\
           printf, 'printf',\
           scanf, 'scanf',\
           getch, '_getch'