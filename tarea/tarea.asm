 global    start
          section   .text
start:
          mov       rdx, output             ; rdx holds address of next byte to write
          mov       r8, 1                   ; initial line length
          mov       r9, 0                   ; number of stars written on line so far
          mov       r10, maxlines
          mov       rcx, output2
line:
          mov       byte [rdx], '*'         ; write single star
          inc       rdx                     ; advance pointer to next cell to write
          inc       r9                      ; "count" number so far on line
          cmp       r9, r8                  ; did we reach the number of stars for this line?
          jne       line                    ; not yet, keep writing on this line
lineDone:
          mov       byte [rdx], 10          ; write a new line char
          inc       edx                     ; and move pointer to where next char goes
          inc       r8                      ; next line will be one char longer
          mov       r9, 0                   ; reset count of stars written on this line
          cmp       r8, maxlines            ; wait, did we already finish the last line?
          jng       line                    ; if not, begin writing this line
          
iline:     
          mov       byte [rcx], '*'         ; write single star
          inc       rcx                     ; advance pointer to next cell to write
          inc       r9                      ; "count" number so far on line
          cmp       r9, r10                  ; did we reach the number of stars for this line?
          jne       iline                    ; not yet, keep writing on this line
          
ilineDone:
          mov       byte [rcx], 10          ; write a new line char
          inc       rcx                     ; and move pointer to where next char goes
          dec       r10                      ; next line will be one char longer
          mov       r9, 0                   ; reset count of stars written on this line
          cmp       r10, 0            ; wait, did we already finish the last line?
          jg        iline                    ; if not, begin writing this line 
done:
          ;syscall
          mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, output             ; address of string to output
          mov       rdx, dataSize           ; number of bytes
          syscall 
          mov       rax, 1
          mov       rdi, 1
          mov       rsi, output2
          mov       rcx, dataSize
          syscall
          mov       rax, 60               ; system call for exit
          xor       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit
          
          
          section   .bss
maxlines  equ       8
dataSize  equ       44
output:   resb      dataSize
output2:  resb     dataSize

