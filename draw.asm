;Program rysujący poruszający się wielokąt
.386
.model tiny
.stack 100h
.code
start:
	mov al,13h
	mov ah,00h
	mov es,ax
	int 10h
	mov ax,0A000h		;segment ES będzie teraz wskazywał segment pamięci 
	mov es,ax			;karty graficznej
	rep stosb
	mov ah,00h			;-czekamy na naciśnięcie dowolnego klawisza
	int 16h			;/
	mov ah,00h			;
	mov al,03h			; >przechodzimy do trybu tekstowego
	int 10h			;/
	mov ah,00h			;
	mov ah,4ch			;
	int 21h		

end start
