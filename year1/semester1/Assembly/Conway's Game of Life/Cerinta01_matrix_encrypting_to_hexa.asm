.data
	#n,m <=18, dar cu o marginire se ajunge la 20x20 cu dim 4
	matrix: .space 1600
	matrixPrelucrare: .space 1600
	m: .space 4 #nr linii
	n: .space 4 #nr coloane
	opt: .long 8
	patru: .long 4
	doi: .long 2
	caractereHexa: .space 4
	cerinta: .space 30
	mesaj: .space 30
	cheie: .space 800
	nrElemCheie: .space 4
	cnt: .space 4
	hexa: .space 400
	binar: .space 400
	indexCheie: .space 4
	indexMesaj: .space 4
	ind: .space 4
	mesaj_decriptat: .space 800
	mesaj_criptat: .space 800
	mMarginit: .space 4
	nMarginit: .space 4
	p: .space 4 #nr celule vii
	k: .space 4 #nr intreg k evolutii
	valoare: .space 4
	nouaValoare: .space 4
	sumVecini: .space 4
	copiem: .space 4
	indexLinie: .space 4
	indexColoana: .space 4
	index: .space 4
	formatPereche: .asciz "%d %d"
	formatCitireVariabila: .asciz "%d"
	formatPrintf: .asciz "%d "
	newLine: .asciz "\n"
.text
	
.global main

main:
citire_varibile:
	pushl $n
	pushl $m
	pushl $formatPereche
	call scanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	movl n, %ebx
	addl $2, %ebx
	movl %ebx, nMarginit
	movl m, %ebx
	addl $2, %ebx
	movl %ebx, mMarginit
	
	pushl $p
	pushl $formatCitireVariabila
	call scanf
	popl %ebx
	popl %ebx
#creare matrice
movl $0, index
et_for_perechi:
	movl index, %ecx
	cmp %ecx, p
	je citire_evolutii
	
	pushl $indexColoana
	pushl $indexLinie
	pushl $formatPereche
	call scanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	#in matricea marginita, oricarei linii si coloane se adauga +1
	#populez matrixPrelucrare[indexLinie+1][indexColoana+1]=1
	#(indexLinie+1)*(n+1)+(indexColoana+1)
	
	movl indexLinie, %eax
	incl %eax
	movl $0, %edx
	movl nMarginit, %ebx
	mull %ebx
	addl indexColoana, %eax
	incl %eax
	
	lea matrixPrelucrare, %edi
	movl $1, (%edi, %eax,4)
	
	incl index
	jmp et_for_perechi
	
citire_evolutii:
	pushl $k
	pushl $formatCitireVariabila
	call scanf
	popl %ebx
	popl %ebx
citire_cerinta2:
	pushl $cerinta
	pushl $formatCitireVariabila
	call scanf
	popl %ebx
	popl %ebx
	
	#citire string
	
	movl $3, %eax
	movl $0, %ebx
	movl $mesaj, %ecx
	movl $30, %edx
	int $0x80
	
copiere_matrixPrelucrare_in_matrix:
	lea matrixPrelucrare, %esi
	lea matrix, %edi
	movl $0, indexLinie
	c_for_lines:
		movl indexLinie, %ecx
		cmp %ecx, mMarginit
		je check_k
		movl $0, indexColoana
		c_for_columns:
			movl indexColoana, %ecx
			cmp %ecx, nMarginit
			je increase_line
			
			movl indexLinie, %eax
			movl $0, %edx
			movl nMarginit, %ebx
			mull %ebx
			addl indexColoana, %eax
			
			movl (%esi, %eax, 4), %ebx
			movl %ebx, (%edi, %eax, 4)
			
			incl indexColoana
			jmp c_for_columns
	increase_line:
		incl indexLinie
		jmp c_for_lines
		
	# vecinii lui m[i][j]
	# m[i-1][j-1] = (indexLinii-1) * nMarginit + (indexColoana-1)
	# m[i-1][j] =   (indexLinii-1) * nMarginit + (indexColoana)
	# m[i-1][j+1] = (indexLinii-1) * nMarginit + (indexColoana+1)
	# m[i][j-1] =   (indexLinii) * nMarginit + (indexColoana-1)
	# m[i][j+1] = 	(indexLinii) * nMarginit + (indexColoana)
	# m[i+1][j-1] = (indexLinii+1) * nMarginit + (indexColoana-1)
	# m[i+1][j] = 	(indexLinii+1) * nMarginit + (indexColoana)
	# m[i+1][j+1] = (indexLinii+1) * nMarginit + (indexColoana+1)

check_k:
	movl k, %ecx
	cmp $0, %ecx
	je matr_nemarginita
	decl k

prelucrare:
	movl $1, indexLinie
	
	for_lines_marginit:
		movl indexLinie, %ecx
		movl mMarginit, %ebx
		decl %ebx
		cmp %ecx, %ebx
		je copiere_matrixPrelucrare_in_matrix
		movl $1, indexColoana
		for_columns_marginit:
		lea matrix, %edi
		lea matrixPrelucrare, %esi
			movl $0, valoare
			movl $0, nouaValoare
			movl $0, sumVecini
			movl indexColoana, %ecx
			movl nMarginit, %ebx
			decl %ebx
			cmp %ecx, %ebx
			je increase_line1
			
			#inlocuire variabila
			movl indexLinie, %eax
			movl $0, %edx
			movl nMarginit, %ebx
			mull %ebx
			addl indexColoana, %eax
			movl (%edi, %eax, 4), %ebx
			movl %ebx, valoare
			
			#adunareVecini
			subl nMarginit, %eax	#i-1,j
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			incl %eax		#i-1,j+1
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			subl $2, %eax		#i-1,j-1
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			addl nMarginit, %eax	#i,j-1
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			addl nMarginit, %eax	#i+1,j-1
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			addl $1, %eax		#i+1,j
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			addl $1, %eax		#i+1,j+1
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			subl nMarginit, %eax	#i,j+1
			movl (%edi, %eax, 4), %ebx
			addl %ebx,sumVecini
			
			movl valoare, %ecx
			cmp $1, %ecx
			je vie
			jmp moarta
			vie:
				movl sumVecini, %ecx
				cmp $2, %ecx
				je vie_devine_vie
				movl sumVecini, %ecx
				cmp $3, %ecx
				je vie_devine_vie
				jmp vie_devine_moarta
				vie_devine_vie:
					movl $1, nouaValoare
					jmp paste_valoare
				vie_devine_moarta:
					movl $0, nouaValoare
					jmp paste_valoare
			moarta:
				movl sumVecini, %ecx
				cmp $3, %ecx
				je moarta_devine_vie
				jmp moarta_devine_moarta
				moarta_devine_vie:
					movl $1, nouaValoare
					jmp paste_valoare
				moarta_devine_moarta:
					movl $0, nouaValoare
					jmp paste_valoare
			paste_valoare:
			
			movl indexLinie, %eax
			movl $0, %edx
			movl nMarginit, %ebx
			mull %ebx
			addl indexColoana, %eax
			movl nouaValoare, %ebx
			movl %ebx, (%esi, %eax, 4)
			
			incl indexColoana
			jmp for_columns_marginit
			increase_line1:	
				incl indexLinie
				jmp for_lines_marginit

lea cheie, %esi

matr_nemarginita:
	movl $0, indexLinie
	for_lines:
		movl indexLinie, %ecx
		movl mMarginit, %ebx
		cmp %ecx, %ebx
		je out
		movl $0, indexColoana
		for_columns:
			movl indexColoana, %ecx
			movl nMarginit, %ebx
			cmp %ecx, %ebx
			je cont
			
			movl indexLinie, %eax
			movl $0, %edx
			mull nMarginit
			addl indexColoana, %eax
			
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx
			movl indexCheie, %eax
			movl %ebx, (%esi, %eax, 4)
			
			incl indexCheie
			incl indexColoana
			jmp for_columns
	cont:
		incl indexLinie
		jmp for_lines
	out:
	movl %esi, cheie
	movl cerinta, %ecx
	lea mesaj, %edi
	lea mesaj_decriptat, %esi
	cmp $0, %ecx
	je cerinta0
	jmp cerinta1
	cerinta0:
	#nrElemCheie
	movl nMarginit ,%eax
	movl $0, %edx
	movl mMarginit, %ebx
	mull %ebx
	movl %eax, nrElemCheie
	
	movl $0, indexMesaj
	movl $0, index
	prelucrare_mesaj:
	
		movl index, %ebx
		mov (%edi, %ebx, 1), %al
		cmp $0, %al
		je fin2
		
		et_a:
			cmp $'a', %al
			jne et_b
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_b:
			cmp $'b', %al
			jne et_c
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_c:
			cmp $'c', %al
			jne et_d
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_d:
			cmp $'d', %al
			jne et_e
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_e:
			cmp $'e', %al
			jne et_f
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_f:
			cmp $'f', %al
			jne et_g
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_g:
			cmp $'g', %al
			jne et_h
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_h:
			cmp $'h', %al
			jne et_i
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_i:
			cmp $'i', %al
			jne et_j
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_j:
			cmp $'j', %al
			jne et_k
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_k:
			cmp $'k', %al
			jne et_l
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_l:
			cmp $'l', %al
			jne et_m
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_m:
			cmp $'m', %al
			jne et_n
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_n:
			cmp $'n', %al
			jne et_o
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_o:
			cmp $'o', %al
			jne et_p
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_p:
			cmp $'p', %al
			jne et_q
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_q:
			cmp $'q', %al
			jne et_r
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_r:
			cmp $'r', %al
			jne et_s
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_s:
			cmp $'s', %al
			jne et_t
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_t:
			cmp $'t', %al
			jne et_u
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_u:
			cmp $'u', %al
			jne et_v
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_v:
			cmp $'v', %al
			jne et_w
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_w:
			cmp $'w', %al
			jne et_x
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_x:
			cmp $'x', %al
			jne et_y
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_y:
			cmp $'y', %al
			jne et_z
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_z:
			cmp $'z', %al
			jne et_A
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_A:
			cmp $'A', %al
			jne et_B
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_B:
			cmp $'B', %al
			jne et_C
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_C:
			cmp $'C', %al
			jne et_D
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_D:
			cmp $'D', %al
			jne et_E
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_E:
			cmp $'E', %al
			jne et_F
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_F:
			cmp $'F', %al
			jne et_G
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_G:
			cmp $'G', %al
			jne et_H
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_H:
			cmp $'H', %al
			jne et_I
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_I:
			cmp $'I', %al
			jne et_J
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_J:
			cmp $'J', %al
			jne et_K
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_K:
			cmp $'K', %al
			jne et_L
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_L:
			cmp $'L', %al
			jne et_M
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_M:
			cmp $'M', %al
			jne et_N
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_N:
			cmp $'N', %al
			jne et_O
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_O:
			cmp $'O', %al
			jne et_P
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_P:
			cmp $'P', %al
			jne et_Q
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_Q:
			cmp $'Q', %al
			jne et_R
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_R:
			cmp $'R', %al
			jne et_S
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_S:
			cmp $'S', %al
			jne et_T
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_T:
			cmp $'T', %al
			jne et_U
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_U:
			cmp $'U', %al
			jne et_V
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_V:
			cmp $'V', %al
			jne et_W
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_W:
			cmp $'W', %al
			jne et_X
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_X:
			cmp $'X', %al
			jne et_Y
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_Y:
			cmp $'Y', %al
			jne et_Z
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1
		et_Z:
			cmp $'Z', %al
			jne fin1
			movl indexMesaj, %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl $1,(%esi, %ebx, 4)
			incl %ebx
			movl $0,(%esi, %ebx, 4)
			incl %ebx
			movl %ebx, indexMesaj
			jmp fin1

		fin1:
		incl index
		jmp prelucrare_mesaj
		
	fin2:
	movl cheie, %edi
	movl nrElemCheie, %ebx
	movl %ebx, cnt
	
	prel:
	movl cnt, %ecx
	cmp indexMesaj, %ecx
	jge pre_xorare
	
		movl $0, indexCheie
		for_loop:
			movl nrElemCheie, %ecx
			cmp indexCheie, %ecx
			je fin_loop
			movl indexCheie, %eax
			movl (%edi, %eax, 4), %ebx
			addl cnt, %eax
			movl %ebx, (%edi, %eax, 4)
			incl indexCheie
			jmp for_loop
	
	fin_loop:
	movl cnt, %ebx
	addl nrElemCheie, %ebx
	movl %ebx, cnt
	jmp prel
	pre_xorare:
	movl $0, indexCheie
	xorare:
		movl indexMesaj, %ecx
		cmp indexCheie, %ecx
		je xorat
		movl indexCheie, %eax
		movl (%esi, %eax, 4), %ebx
		movl (%edi, %eax, 4), %edx
		xorl %ebx, %edx
		movl %edx, (%edi, %eax, 4)
		incl indexCheie
		jmp xorare
	xorat:
	binary_to_hexa:
		movl $0, indexCheie
		lea hexa, %esi
		movl $0, index
		movl index, %ebx
		movb $'0', (%esi, %ebx, 1)
		incl index
		
		movl index, %ebx
		movb $'x', (%esi, %ebx, 1)
		incl index

		parcurgere_elem:
		movl indexCheie, %ecx
		cmp indexMesaj, %ecx
		jge end_loop
		movl $0, valoare
		
		movl $0, %edx
		movl indexCheie, %ebx
		movl (%edi, %ebx, 4), %eax
		mull opt
		incl indexCheie
		addl %eax,valoare
		
		movl indexCheie, %ebx
		movl (%edi, %ebx, 4), %eax
		mull patru
		incl indexCheie
		addl %eax, valoare
		
		movl indexCheie, %ebx
		movl (%edi, %ebx, 4), %eax
		mull doi
		incl indexCheie
		addl %eax, valoare
		
		movl indexCheie, %ebx
		movl (%edi, %ebx, 4), %eax
		incl indexCheie
		addl %eax, valoare
		
		movl valoare, %eax
		movl index, %ebx
		
		h0:
			cmp $0, %eax
			jne h1
			movb $'0', (%esi, %ebx,1)
			jmp gata
		h1:
			cmp $1, %eax
			jne h2
			movb $'1', (%esi, %ebx,1)
			jmp gata
		h2:
			cmp $2, %eax
			jne h3
			movb $'2', (%esi, %ebx,1)
			jmp gata
		h3:
			cmp $3, %eax
			jne h4
			movb $'3', (%esi, %ebx,1)
			jmp gata
		h4:
			cmp $4, %eax
			jne h5
			movb $'4', (%esi, %ebx,1)
			jmp gata
		h5:
			cmp $5, %eax
			jne h6
			movb $'5', (%esi, %ebx,1)
			jmp gata
		h6:
			cmp $6, %eax
			jne h7
			movb $'6', (%esi, %ebx,1)
			jmp gata
		h7:
			cmp $7, %eax
			jne h8
			movb $'7', (%esi, %ebx,1)
			jmp gata
		h8:
			cmp $8, %eax
			jne h9
			movb $'8', (%esi, %ebx,1)
			jmp gata
		h9:
			cmp $9, %eax
			jne h10
			movb $'9', (%esi, %ebx,1)
			jmp gata
		h10:
			cmp $10, %eax
			jne h11
			movb $'A', (%esi, %ebx,1)
			jmp gata
		h11:
			cmp $11, %eax
			jne h12
			movb $'B', (%esi, %ebx,1)
			jmp gata
		h12:
			cmp $12, %eax
			jne h13
			movb $'C', (%esi, %ebx,1)
			jmp gata
		h13:
			cmp $13, %eax
			jne h14
			movb $'D', (%esi, %ebx,1)
			jmp gata
		h14:
			cmp $14, %eax
			jne h15
			movb $'E', (%esi, %ebx,1)
			jmp gata
		h15:
			cmp $15, %eax
			jne h16
			movb $'F', (%esi, %ebx,1)
			jmp gata
		h16:
			cmp $16, %eax
			jne gata
			movb $'G', (%esi, %ebx,1)
			jmp gata
		
		
		
		gata:
		incl index
		jmp parcurgere_elem
	end_loop:
		movl indexMesaj, %eax
		divl patru
		movl %eax, caractereHexa
			
	pre_et:
	movl $0, indexCheie
	et:
		incl caractereHexa
		incl caractereHexa
		movl $4, %eax
		movl $1, %ebx
		movl %esi, %ecx
		movl caractereHexa, %edx
		int $0x80
		
		movl $4, %eax
		movl $1, %ebx
		movl $newLine, %ecx
		movl $2, %edx
		int $0x80
	jmp et_exit
	
	cerinta1:
	
		
et_exit:
	pushl $0
	call fflush
	popl %ebx
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
