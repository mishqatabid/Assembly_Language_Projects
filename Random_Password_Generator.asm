INCLUDE Irvine32.inc 

.data
    password BYTE 50 DUP(?)                         ; Define a buffer to store the generated password
    passwordLength DWORD ?                          ; Store the desired length of the password
    passwordComplexity DWORD ?                      ; Store the complexity level chosen by the user
    uppercase BYTE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 
    lowercase BYTE 'abcdefghijklmnopqrstuvwxyz' 
    numbers BYTE '0123456789' 
    specialChars BYTE '!@#$%^&*()_+-={}:<>?' 
    allChars BYTE 0                                 ; Placeholder for storing all characters combined

    sprompt BYTE "Enter Desired Password Length:  ", 0 
    smenu BYTE "      ~~~~~~~~~~ MENU ~~~~~~~~~~", 0 
    smenu1 BYTE "1. UPPER CASE", 0 
    smenu2 BYTE "2. MIXED CASE (lowercase + uppercase)", 0 
    smenu3 BYTE "3. ALPHA NUMERIC (mixed case + numbers)", 0 
    smenu4 BYTE "4. ALPHA NUMERIC + SPECIAL CHARACTER", 0 
    soption BYTE "Choose Complexity (1-4): ", 0 
    spassword BYTE "PASSWORD GENERATED: ", 0 

.code
start PROC
    ; Display prompt message
    mov edx, OFFSET sprompt 
    call WriteString

    call ReadInt
    mov passwordLength, eax                 ; Store the input as password length

    ; Display menu title
    mov edx, OFFSET smenu 
    call WriteString 
    call Crlf 

    mov edx, OFFSET smenu1
    call WriteString
    call Crlf

    mov edx, OFFSET smenu2
    call WriteString
    call Crlf

    mov edx, OFFSET smenu3
    call WriteString
    call Crlf

    mov edx, OFFSET smenu4
    call WriteString
    call Crlf
    call Crlf

    ; Display complexity prompt
    mov edx, OFFSET soption                
    call WriteString 
    call Crlf 

    call ReadInt 
    mov passwordComplexity, eax             ; Store the input as password complexity

    mov esi, offset password                ; Set the address to start storing the password
    mov ecx, passwordLength                 ; Set the loop counter to the password length

    generatePassword:
        call GenerateRandomChar             ; Generate a random character according to complexity
        mov [esi], al                       ; Store the generated character
        inc esi                             ; Move to the next character in the buffer
        loop generatePassword               ; Repeat until the desired length is reached

        mov byte ptr [esi], 0               ; Null-terminate the string

        ; Display password message
        call Crlf          
        mov edx, OFFSET spassword
        call WriteString
        
        ; Display the generated password
        mov edx, offset password 
        call WriteString 
        call Crlf 

    invoke ExitProcess, 0 ; Exit the program
start ENDP

GenerateRandomChar PROC
    mov eax, passwordComplexity             ; Load complexity level
    cmp eax, 1                              ; Compare with level 1
    je uppercaseOnly                        ; If equal, jump to uppercaseOnly
    cmp eax, 2                              ; Compare with level 2
    je mixedCase                            ; If equal, jump to mixedCase
    cmp eax, 3                              ; Compare with level 3
    je mixedCaseNumbers                     ; If equal, jump to mixedCaseNumbers
    cmp eax, 4                              ; Compare with level 4
    je allCharacters                        ; If equal, jump to allCharacters
    jmp GenerateRandomChar                  ; If none of the above, repeat the process

    uppercaseOnly:
        mov eax, 26                         ; Set range for uppercase letters
        call RandomRange                    ; Generate a random number within the range
        add eax, offset uppercase           ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret 

    mixedCase:
        mov eax, 52                         ; Set range for mixed case (lowercase + uppercase)
        call RandomRange                    ; Generate a random number within the range
        cmp eax, 26                         ; Compare with 26 (number of uppercase letters)
        jl uppercaseOnlyProc                ; If less, jump to uppercaseOnlyProc
        sub eax, 26                         ; Subtract 26 to get index for lowercase letters
        add eax, offset lowercase           ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret 

    mixedCaseNumbers:
        mov eax, 62                         ; Set range for alphanumeric (mixed case + numbers)
        call RandomRange                    ; Generate a random number within the range
        cmp eax, 26                         ; Compare with 26 (number of uppercase letters)
        jl uppercaseOnlyProc                ; If less, jump to uppercaseOnlyProc
        cmp eax, 52                         ; Compare with 52 (number of lowercase letters)
        jl lowercaseOnlyProc                ; If less, jump to lowercaseOnlyProc
        sub eax, 52                         ; Subtract 52 to get index for numbers
        add eax, offset numbers             ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret

    allCharacters:
        mov eax, 94                         ; Set range for all characters
        call RandomRange                    ; Generate a random number within the range
        cmp eax, 26                         ; Compare with 26 (number of uppercase letters)
        jl uppercaseOnlyProc                ; If less, jump to uppercaseOnlyProc
        cmp eax, 52                         ; Compare with 52 (number of lowercase letters)
        jl lowercaseOnlyProc                ; If less, jump to lowercaseOnlyProc
        cmp eax, 62                         ; Compare with 62 (number of numbers)
        jl numbersOnlyProc                  ; If less, jump to numbersOnlyProc
        sub eax, 62                         ; Subtract 62 to get index for special characters
        add eax, offset specialChars        ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret

    uppercaseOnlyProc:
        mov eax, 26                         ; Set range for uppercase letters
        call RandomRange                    ; Generate a random number within the range
        add eax, offset uppercase           ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret

    lowercaseOnlyProc:
        mov eax, 26                         ; Set range for lowercase letters
        call RandomRange                    ; Generate a random number within the range
        add eax, offset lowercase           ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret 

    numbersOnlyProc:
        mov eax, 10                         ; Set range for numeric characters (0-9)
        call RandomRange                    ; Generate a random number within the range
        add eax, offset numbers             ; Add offset to get the actual character
        mov al, [eax]                       ; Move the character to AL register
        ret
GenerateRandomChar ENDP

END start

