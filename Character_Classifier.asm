.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc			; Include the Irvine32 library for easy console I/O (if available)
INCLUDE macros.inc				; Include macros for easier console I/O handling

.data
	inputBuffer BYTE 256 DUP(0)			; Buffer for user input
	outputBuffer BYTE 256 DUP(0)		; Buffer for output message
	msgPrompt BYTE "Enter a sentence: ", 0
	msgLetter BYTE "Letter: ", 0
	msgDigit BYTE "Digit: ", 0
	msgWhitespace BYTE "Whitespace ", 0
	msgSpecial BYTE "Special or Punctuation: ", 0

.code
main PROC
	mov edx, OFFSET msgPrompt
	call WriteString

	mov edx, OFFSET inputBuffer
	mov ecx, SIZEOF inputBuffer
	call ReadString

	mov esi, OFFSET inputBuffer		; Initialize ESI to point to the input buffer

	iterate:
		mov al, [esi]			; Load the current character
		cmp al, 0				; Check if the end of the string (null terminator)
		je end_iteration		; If yes, exit the loop

; Check if the character is a letter (A-Z or a-z)
		cmp al, 'A'
		jl not_letter
		cmp al, 'Z'
		jle letter
		cmp al, 'a'
		jl not_letter
		cmp al, 'z'
		jle letter

; Check if the character is a digit (0-9)
	not_letter:
		cmp al, '0'
		jl not_digit
		cmp al, '9'
		jle digit

	not_digit:
		cmp al, ' '				; Check if the character is a whitespace (space, tab, newline)
		je whitespace
		cmp al, 9				; ASCII for tab
		je whitespace
		cmp al, 10				; ASCII for newline
		je whitespace
		jmp special				; If none of the above, it could be punctuation or special character

; Display letter
	letter:
		mov edx, OFFSET msgLetter
		call WriteString
		mov dl, al
		call WriteChar
		call Crlf
		jmp next_char

; Display digit
	digit:
		mov edx, OFFSET msgDigit
		call WriteString
		mov dl, al
		call WriteChar
		call Crlf
		jmp next_char

; Display whitespace
	whitespace:
		mov edx, OFFSET msgWhitespace
		call WriteString
		mov dl, al
		call WriteChar
		call Crlf
		jmp next_char

; Display special characters and punctuation
	special:
		mov edx, OFFSET msgSpecial
		call WriteString
		mov dl, al
		call WriteChar
		call Crlf

	next_char:
		inc esi						; Move to the next character
		jmp iterate					; Repeat the loop

	end_iteration:
	INVOKE ExitProcess, 0			; Exit the process

main ENDP
END main
