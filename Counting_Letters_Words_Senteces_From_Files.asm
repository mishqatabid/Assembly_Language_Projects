INCLUDE Irvine32.inc

.data
    fileName BYTE 512 DUP(?)
    sprompt BYTE "Enter the path of the file: ", 0
    lettering BYTE "                    Letters: ", 0
    wording BYTE "                    Words: ", 0
    sentences BYTE "                    Sentences: ", 0

    inputBuffer BYTE 10000 DUP(?)

    wordCount DWORD ?
    sentenceCount DWORD ?
    letterCount DWORD ?
    fileHandle DWORD ?
    bytesRead DWORD ?

    heading1 BYTE "                                    .oooooo.                                         .", 0
    heading2 BYTE "                                   d8P'  `Y8b                                      .o8", 0
    heading3 BYTE "                                   888           .ooooo.  oooo  oooo  ooo. .oo.   .o888oo  .ooooo.  oooo d8b", 0
    heading4 BYTE "                                   888          d88' `88b `888  `888  `888P""Y88b    888   d88' `88b `888""8P", 0
    heading5 BYTE "                                   888          888   888  888   888   888   888    888   888ooo888  888", 0
    heading6 BYTE "                                   `88b    ooo  888   888  888   888   888   888    888 . 888    .o  888", 0
    heading7 BYTE "                                    `Y8bood8P'  `Y8bod8P'  `V88V""V8P' o888o o888o   ""888"" `Y8bod8P' d888b", 0
    heading8 BYTE "                                                                                                   ", 0

    lilhead1 BYTE " __ __     ___ __    ___ ", 0
    lilhead2 BYTE "/  /  \|\ | | |_ |\ | |  ", 0
    lilhead3 BYTE "\__\__/| \| | |__| \| |  ", 0

    space BYTE "                            ", 0

    lilheading1 BYTE " __  __ __      ___ ", 0
    lilheading2 BYTE "|__)|_ (_ /  \|  |  ", 0
    lilheading3 BYTE "| \ |____)\__/|__|  ", 0

.code
main PROC
    
    call Crlf
    mov edx, OFFSET heading1
    call WriteString
    call Crlf

    mov edx, OFFSET heading2
    call WriteString
    call Crlf

    mov edx, OFFSET heading3
    call WriteString
    call Crlf

    mov edx, OFFSET heading4
    call WriteString
    call Crlf

    mov edx, OFFSET heading5
    call WriteString
    call Crlf

    mov edx, OFFSET heading6
    call WriteString
    call Crlf

    mov edx, OFFSET heading7
    call WriteString
    call Crlf

    mov edx, OFFSET heading8
    call WriteString
    call Crlf

    mov edx, OFFSET heading8
    call WriteString
    call Crlf

    mov edx, OFFSET heading8
    call WriteString
    call Crlf

    mov edx, OFFSET sprompt
    call WriteString

    mov edx, OFFSET fileName
    mov ecx, 512
    call ReadString

    mov edx, OFFSET fileName
    call OpenInputFile
    mov fileHandle, eax

    mov edx, OFFSET inputBuffer
    mov ecx, SIZEOF inputBuffer
    mov ebx, fileHandle
    call ReadFromFile
    mov bytesRead, eax
    
    mov esi, OFFSET inputBuffer
    mov ecx, bytesRead
    mov edx, 0
    mov ebx, 0

countLoop:
    mov al, [esi]
    cmp al, 0
    je endCount
    cmp al, ' '
    je spaceDetected
    cmp al, '.'
    je fullstop
    inc esi
    inc letterCount 
    jmp countLoop

spaceDetected:
    mov al, [esi + 1]
    cmp al, ' '
    je spaceDetected
    inc ebx
    inc esi
    inc letterCount 
    jmp countLoop

fullstop:
    mov al, [esi + 1]
    cmp al, '.'
    je fullstop
    inc edx
    inc esi
    inc letterCount 
    jmp countLoop

endCount:
    inc ebx
    mov wordCount, ebx
    mov sentenceCount, edx

mov edx, OFFSET lilhead1
    call WriteString
    call Crlf
    
    mov edx, OFFSET lilhead2
    call WriteString
    call Crlf

    mov edx, OFFSET lilhead3
    call WriteString
    call Crlf

    mov edx, OFFSET space
    call WriteString

    mov edx, OFFSET inputBuffer
    call WriteString
    call Crlf

    call Crlf
    call Crlf
    call Crlf

    mov edx, OFFSET lilheading1
    call WriteString
    call Crlf

    mov edx, OFFSET lilheading2
    call WriteString
    call Crlf

    mov edx, OFFSET lilheading3
    call WriteString
    call Crlf
    call Crlf

    mov edx, OFFSET lettering
    call WriteString
    mov eax, letterCount
    call WriteDec
    call Crlf

    mov edx, OFFSET wording
    call WriteString
    mov eax, wordCount
    call WriteDec
    call Crlf

    mov edx, OFFSET sentences
    call WriteString
    mov eax, sentenceCount
    call WriteDec
    call Crlf

    call CloseFile
    exit
main ENDP

END main
