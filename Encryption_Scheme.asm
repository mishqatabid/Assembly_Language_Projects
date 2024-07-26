INCLUDE Irvine32.inc

 ;KEY = 239 ; any value between 1-255
 BUFMAX = 128 ; maximum buffer size

.data 
	sPrompt  BYTE "Enter the plain text:",0 
	sEncrypt BYTE "Cipher text: ",0 
	sDecrypt BYTE "Decrypted: ",0 
	buffer   BYTE BUFMAX+1 DUP(0) 
	bufSize  DWORD ?
	KEY BYTE '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', '{', '}', '[', ']', ':', ';', '"', '<', '>', ',', '.', '/', '?', '\', '|', '~', '`' ;key array
	alphabets BYTE 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'

.code 
main PROC 

	call InputTheString ; input the plain text 
	call TranslateBuffer ; encrypt the buffer 
	mov edx,OFFSET sEncrypt ; display encrypted message 
	call DisplayMessage 
	call TranslateBuffer2  ; decrypt the buffer 
	mov edx,OFFSET sDecrypt ; display decrypted message 
	call DisplayMessage 

exit
main ENDP 

InputTheString PROC 

	pushad ; save 32-bit registers 
	mov edx,OFFSET sPrompt ; display a prompt 
	call WriteString 
	mov ecx,BUFMAX ; maximum character count 
	mov edx,OFFSET buffer   ; point to the buffer 
	call ReadString         ; input the string 
	mov bufSize,eax        ; save the length 
	call Crlf
	popad 
	ret 
InputTheString ENDP 


DisplayMessage PROC 

	pushad 
	call WriteString 
	mov edx,OFFSET buffer ; display the buffer 
	call WriteString 
	call Crlf 
	call Crlf
	popad 
	ret 
DisplayMessage ENDP


TranslateBuffer PROC 

	pushad 
	mov ecx,bufSize ; loop counter 
	mov esi,0 ; index 0 in buffer 
	mov edi,0 ; index 0 for key

	L1:
	mov al, KEY[edi]
	mov bl, alphabets[edi]
	add buffer[esi], bl
	sub buffer[esi], al
	xor buffer[esi], al ; translate a byte 
	add buffer[esi], bl
	inc esi ; point to next byte 
	inc edi ; point to next byte
	cmp edi, 6	;if edi index gets to six, reset to zero
	jne cont	; if not equal to 6, skip restting code
	mov edi, 0	; reset edi/ key to beginning

	cont:
	loop L1 

	popad
	ret 
TranslateBuffer ENDP 


TranslateBuffer2 PROC 

	pushad 
	mov ecx,bufSize ; loop counter 
	mov esi,0 ; index 0 in buffer 
	mov edi,0 ; index 0 for key

	L1:
	mov bl, alphabets[edi]
	mov al, KEY[edi]
	sub buffer[esi], bl
	xor buffer[esi], al ; translate a byte
	add buffer[esi], al
	sub buffer[esi], bl
	inc esi ; point to next byte 
	inc edi ; point to next byte
	cmp edi, 6	;if edi index gets to six, reset to zero
	jne cont	; if not equal to 6, skip restting code
	mov edi, 0	; reset edi/ key to beginning

	cont:
	loop L1 

	popad
	ret 
TranslateBuffer2 ENDP 


END main
