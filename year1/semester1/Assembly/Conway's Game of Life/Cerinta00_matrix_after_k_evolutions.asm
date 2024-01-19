.data
	#n,m <=18, dar cu o marginire se ajunge la 20x20 cu dim 4
	matrix: .space 1600
	matrixPrelucrare: .space 1600
	m: .space 4 #nr linii
	n: .space 4 #nr coloane
	mMarginit: .space 4
	nMarginit: .space 4
	p: .space 4 #nr celule vii
	k: .space 4 #nr intreg k evolutii
	valoare: .space
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
	je et_afis_matr_nemarginita
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
	
et_afis_matr_nemarginita:
	movl $1, indexLinie
	for_lines:
		movl indexLinie, %ecx
		movl mMarginit, %ebx
		decl %ebx
		cmp %ecx, %ebx
		je et_exit
		movl $1, indexColoana
		for_columns:
			movl indexColoana, %ecx
			movl nMarginit, %ebx
			decl %ebx
			cmp %ecx, %ebx
			je cont
			
			movl indexLinie, %eax
			movl $0, %edx
			mull nMarginit
			addl indexColoana, %eax
			
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx
			
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl indexColoana
			jmp for_columns
	cont:
		movl $4, %eax
		movl $1, %ebx
		movl $newLine, %ecx
		movl $2, %edx
		int $0x80
		
		incl indexLinie
		jmp for_lines
	
	
et_exit:
	pushl $0
	call fflush
	popl %ebx
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
