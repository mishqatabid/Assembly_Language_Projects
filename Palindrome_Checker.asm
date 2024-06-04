INCLUDE Irvine32.inc

.data
	inputBuffer BYTE 256 DUP(0) ; Buffer for user input
	msgPrompt BYTE "Enter a sentence: ", 0
	msgPalindrome BYTE "The input is a palindrome.", 0
	msgNotPalindrome BYTE "The input is not a palindrome.", 0

.code

main PROC
	mov edx, OFFSET msgPrompt
	call WriteString

	mov edx, OFFSET inputBuffer
	mov ecx, SIZEOF inputBuffer
	call ReadString			; Prompt the user for input

	
	mov esi, OFFSET inputBuffer
	call IsPalindrome		; Display palindrome check result

	test al, al
	jz not_palindrome

	mov edx, OFFSET msgPalindrome
	call WriteString

	jmp end_main

	not_palindrome:
		mov edx, OFFSET msgNotPalindrome
		call WriteString

	end_main:
		call Crlf
	INVOKE ExitProcess, 0   ; Exit the process
main ENDP

;--------------------------------------------------------------------

IsPalindrome PROC
	; Input: ESI points to the beginning of the string
	; Output: AL = 1 if palindrome, AL = 0 if not palindrome

	
	call GetStringLength			; Get the length of the string
	cmp eax, 1						; If length is 0 or 1, it's a palindrome
	jbe is_palindrome

	mov edi, esi					; Store the beginning of the string
	add esi, eax					; Point ESI to the end of the string (null terminator)
	dec esi							; Move back to the last character

	check_palindrome:
		call SkipNonAlphanumericStart	; Skip non-alphanumeric characters from the start
		call SkipNonAlphanumericEnd		; Skip non-alphanumeric characters from the end

	
	cmp esi, edi					; Check if pointers have crossed
	jbe is_palindrome				; If pointers have crossed, it's a palindrome

	mov al, [edi]
	call ToLowerCase

	mov dl, al
	mov al, [esi]
	call ToLowerCase

	cmp al, dl						; Compare characters
	jne not_palindrome_check		; If not equal, it's not a palindrome

	inc edi							; Move start pointer forward
	dec esi							; Move end pointer backward
	jmp check_palindrome			; Repeat the loop

	is_palindrome:
		mov al, 1					; Set AL to 1 (indicating a palindrome)
	ret

	not_palindrome_check:
		xor al, al					; Clear AL (indicating not a palindrome)
	
	ret
IsPalindrome ENDP

;--------------------------------------------------------------------

GetStringLength PROC
	; Input: ESI points to the beginning of the string
	; Output: EAX contains the length of the string excluding null terminator

	mov ecx, 0						; Initialize counter to 0

	count_length:
		mov al, [esi + ecx]			; Load the current character
		cmp al, 0					; Check for null terminator
		je end_count				; If null terminator found, end counting

		inc ecx						; Increment counter
		jmp count_length			; Repeat until null terminator is found

	end_count:
		mov eax, ecx				; Move counter value to EAX (length of string)

	ret
GetStringLength ENDP

;--------------------------------------------------------------------

SkipNonAlphanumericStart PROC
	; Input: EDI points to the current character in the string
	; Output: EDI points to the next alphanumeric character from the start

	skip_start:
		mov al, [edi]
		call IsAlphanumeric
	
		test al, al
		jnz skip_done_start
	
		inc edi
		jmp skip_start

	skip_done_start:
	
	ret
SkipNonAlphanumericStart ENDP

;--------------------------------------------------------------------

SkipNonAlphanumericEnd PROC
	; Input: ESI points to the current character in the string
	; Output: ESI points to the next alphanumeric character from the end

	skip_end:
		mov al, [esi]
		call IsAlphanumeric

		test al, al
		jnz skip_done_end

		dec esi
		jmp skip_end

	skip_done_end:

	ret
SkipNonAlphanumericEnd ENDP

;--------------------------------------------------------------------

IsAlphanumeric PROC
	; Input: AL contains the character to be checked
	; Output: AL = 1 if alphanumeric, AL = 0 if not

	; Check if the character is a letter or digit
	
	cmp al, 'A'
	jb not_alphanumeric
	
	cmp al, 'Z'
	jbe alphanumeric
	
	cmp al, 'a'
	jb not_alphanumeric
	
	cmp al, 'z'
	jbe alphanumeric
	
	cmp al, '0'
	jb not_alphanumeric
	
	cmp al, '9'
	jbe alphanumeric

	not_alphanumeric:
		xor al, al
		ret

	alphanumeric:
		mov al, 1
	ret
IsAlphanumeric ENDP

;--------------------------------------------------------------------

ToLowerCase PROC
	; Input: AL contains the character to be converted
	; Output: AL contains the lowercase character

	cmp al, 'A'
	jb done

	cmp al, 'Z'
	ja done

	add al, 32

	done:

	ret
ToLowerCase ENDP

;--------------------------------------------------------------------

END main
