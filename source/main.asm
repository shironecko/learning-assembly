.386
.model flat, stdcall
.stack 4096

STD_OUTPUT_HANDLE EQU -11

GetStdHandle PROTO NEAR32 stdcall, nStdHandle:DWORD

WriteFile PROTO NEAR32 stdcall, 
    hFile:DWORD, lpBuffer:NEAR32, nNumberOfBytesToWrite:DWORD, 
    lpNumberOfBytesWritten:NEAR32, lpOverlapped:NEAR32

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

.data
  unsortedArray BYTE 5, 6, 0, 3, 2, 9, 1
  unsortedArrayLen DWORD LENGTHOF unsortedArray
  message BYTE "Hello, assembly!", 0Dh, 0Ah, 0
  written WORD 0
  hStdOut DWORD 0
  numStr BYTE 24 DUP(0FFh)
.data?
  conOut BYTE LENGTHOF unsortedArray + 1 DUP(?)

.code
main PROC
  push  STD_OUTPUT_HANDLE
  call  GetStdHandle
  mov hStdOut, eax

  mov   eax,  128
  mov   edi,  OFFSET numStr
  mov   ecx,  LENGTHOF numStr
  call  uintToString
  mov   numStr[eax], 0

  push  0                   ; Overlapped mode
  push  0                   ; Bytes written
  push  eax                 ; Length of string
  push  OFFSET numStr       ; Address of string
  push  hStdOut             ; File handle for screen
  call  WriteFile

  mov eax, 0
  ret
main ENDP

;-----------------------------------------------------------
; uintToString
; Receives:
;   eax - unsigned integer
;   edi - out string
;   ecx - out string length
; Returns
;   eax - number of characters written
;-----------------------------------------------------------
uintToString PROC USES ebx ecx edx esi
    mov   ebx,  10
    mov   esi,  0

L1: xor   edx,  edx
    div   ebx
    add   edx,  '0'
    push  edx
    inc   esi
    test  eax,  eax
    jnz   L1

    mov   ecx, esi
    xor   esi, esi
L2: pop   eax
    mov   [edi + esi], al
    inc   esi
    loop  L2
    
    mov   eax,  esi
    ret
uintToString ENDP

;-----------------------------------------------------------
; arrayToString
; Receives:
;   esi - DWORD array
;   ecx - array length
;   edi - out string array
;-----------------------------------------------------------
arrayToString PROC
arrayToString ENDP

END main
