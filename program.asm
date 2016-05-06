.model small
.386          
.data
  napis DB "Podaj liczbe [0,4294967295]: ","$"
	wynik1 DB "n*k+1=","$"
	wynik2 DB "  n*n+1=","$"
	wynik3 DB "  k*k+1=","$"
.code
.stack 100h
program:	
  mov ax, @data
  mov ds,ax
	mov si,0
	mov di,1
	mov esi,0
	petla:
	
  ; wywolanie procedur
		inc si
		mov ebx, 0
		
		call info  
		call wczytaj
		kon:
		;cmp si,5
		;je iec
		
		;loop petla
		iec:
		call koniec


;-------------------------------- procedury ---------------------------------
info PROC
  push ax     
	lea dx, napis	
  mov ah,09h
  int 21h
  pop ax     
  ret
info ENDP

wczytaj PROC   ; tu wczytujemy n, wczytywanie trwa tak dlugo az wcisniemy enter
	mov ah,01h
	int 21h
	cmp al, 13
	jz wczytaj2
	mov cl, al
	sub cl, 30h
	mov eax, ebx
	mov ebx, 10
	mul ebx
	mov ebx, eax
	mov eax, 0
	mov al, cl
	add ebx, eax
	mov ebx, 0
	jmp wczytaj	
wczytaj ENDP

wczytaj2 PROC   ; tu wczytujemy k
	mov ah,01h
	int 21h
	cmp al, 13
	jz licz1
	mov cl, al
	sub cl, 30h
	mov eax, ebx
	mov ebx, 10
	mul ebx
	mov ebx, eax
	mov eax, 0
	mov al, cl
	mov edx, ebx
	add ebx, eax
	mov ecx,0
	jmp wczytaj2	
wczytaj2 ENDP

licz1 PROC	; n*k+1

	lea dx, wynik1      
  mov ah,09h
  int 21h
	add edx,1
	mov eax,edx
	mul ebx
	sub edx,1
	call wyszukaj
licz1 ENDP

wyszukaj PROC ; tu dzielimy otrzymana liczbe przez 10 i wrzucamy reszte z dzielenia na stos
	mov edx, 0
	mov ebp,10
	div ebp
	push edx
	inc cl
	cmp eax, 0
	jz wyswietl
	jmp wyszukaj
wyszukaj ENDP

wyswietl PROC	; wyswietlamy dane zdjete ze stosu
	cmp cl,0
	jz sprawdz
	dec cl
	mov edx, 0
	pop edx
	add dl,30h
	mov ah,02h
	int 21h
	jmp wyswietl	
wyswietl ENDP

sprawdz PROC	
	cmp di,2
	jb licz2
	ja licz3
	jmp kon
sprawdz ENDP

licz2 PROC	; n*(n+1)
	mov di,3
	lea dx, wynik2      
  mov ah,09h
  int 21h 
	mov eax,ebx
	inc ebx
	mul ebx
	mov ebx,eax
	call wyszukaj
licz2 ENDP

licz3 PROC
	mov di,2
	lea dx, wynik3
	mov ah,09h
	int 21h
	mov eax, ebp
	inc ebp
	mul ebp
	mov ebx,eax
	call wyszukaj
licz3 ENDP

koniec PROC 	; konczymy wykonywanie programu
  mov ah, 4CH 
  int 21H
koniec ENDP


;-------------------------------- procedury ---------------------------------
	
end program
