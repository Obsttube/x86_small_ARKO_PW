;============================================================================
; author:		Piotr Obst
; date:			10.12.2020
; description:	7h exercise
;				int excercise_7h(char *text);
;============================================================================

section	.text
global  excercise_7h

;============================================================================
excercise_7h:
; description: 
;	First two chars of a string are markers. Replace all chars before the last
;	occurence of the first marker and all chars after the first occurence of
;	the second marker to a '*' character. First three chars are replaced to space.
;	Example: "nh:wind on the hill" -> "   ******n th******"
; arguments:
;	char *text - pointer to an input string
; returns:
;	0 - no errors
;	1 - validation failed. String too short or the third char is not ':'

	push	ebp	;push ebp to the stack
	mov	ebp, esp
	mov	eax, DWORD [ebp+8]	;move the address of *text to eax
	push	ebx	;ebx is a callee-saved register, so we have to save it before use
	
;validate input
	cmp BYTE [eax], 0	;check if the first char is \0
	je illegal_input	;if true, return 1
	mov dl, BYTE [eax+1]	;dl - char we are trying to find (the second one)
	cmp dl, 0	;check if the second char is \0
	je illegal_input	;if true, return 1
	mov ecx, eax	;ecx is used to find the first occurence of *dl* char
	inc ecx	;ecx++
	inc ecx	;ecx++
	;ecx now points to the third char - ':'
	cmp BYTE [ecx], ':'	;check if the third char is ':'
	jne illegal_input	;jf not, return 1
find_2nd_char:
	inc ecx	;go to the next char (move right)
	cmp BYTE [ecx], 0	;check if end of string is reached
	je prepare_1st	;if so, exit the loop
	cmp BYTE [ecx], dl	;check if we found an occurence of *dl*
	jne find_2nd_char	;if not, continue
	inc ecx	;move to the right (start replacing from the next char - after the one we found)
prepare_1st:	;prepare dl and ebx. (also used to exit the loop)
	mov dl, BYTE [eax]	;dl - char we are trying to find (now the FIRST one)
	mov ebx, ecx	;ebx is used to find the last occurence of *dl* char
go_to_the_end:
	cmp BYTE [ebx], 0	;check if end of string is reached
	je find_1st_char	;if so, exit the loop
	inc ebx
	jmp	go_to_the_end
	;now ebx points at '\0'
find_1st_char:
	dec ebx	;go to the next char (moving to the left)
	cmp BYTE [ebx], ':'	;check if we reached the beginning
	je replace_right	;if so, exit the loop
	cmp BYTE [ebx], dl	;check if we found an occurence of *dl*
	jne find_1st_char	;if not, continue
	dec ebx	;move to the left (start replacing from next char - before the one we found)
replace_right:
	cmp BYTE [ecx], 0	;check if the end of string has been reached
	je replace_left	;if so, exit the loop
	mov BYTE [ecx], '*'	;otherwise replace the char
	inc ecx	;move to the right
	jmp replace_right	;continue
replace_left:
	cmp BYTE [ebx], ':'	;check if the beginning of string has been reached
	je replace_spaces	;if so, exit the loop
	mov BYTE [ebx], '*'	;otherwise replace the char
	dec ebx	;move to the left
	jmp replace_left	;continue
replace_spaces:
	mov BYTE[eax], ' '	;replace the first char with a space
	mov BYTE[eax+1], ' '	;replace the second char with a space
	
	mov	eax, 0	;return 0
exit:
	pop ebx	;restore the initial ebx value
	pop	ebp	;restore ebp from the stack
	ret
illegal_input:
	mov eax, 1	;return 1 (validation failed)
	jmp exit
