.data
	A: .word 400
	arrMes1: .asciiz "A["
	arrMes2: .asciiz "] = "
	message1: .asciiz "Masukkan nomor string: "
	message2: .asciiz "Masukkan nomor: "
  message3: .asciiz "Masuk dan sebarkan elemen:\n"
  message5: .asciiz "Tidak ada file tersisa setelah dihapus\n"
	space: .asciiz " "
	error: .asciiz "ERROR: Nomor harus berupa angka. Silakan masukkan lagi!\n"
  error2: .asciiz "ERROR: Jadi k bukan angka dan lebih kecil dari N. Silakan masukkan lagi!\n"
.text
EnterN:	li 	$v0, 4			#Pesan untuk memasukkan nomor bagian dari nomor A
  adalah $a0, message1
	syscall
	li	$v0, 5			#Masukkan N
	syscall
	blez	$v0, Error			# Jika N <= 0, laporkan kesalahan tersebut dan masukkan kembali N
	add	$s0, $zero, $v0		# s0 = N digit angka
  j Tidak
Error:	li 	$v0, 4			# Laporkan kesalahan
	la 	$a0, error
	syscall
	j	NhapN			# Quay lai nhap lai N
	
Nhapk:	li 	$v0, 4			# Thong bao nhap k
	la 	$a0, message2
	syscall
	li	$v0, 5			# Nhap k
	syscall
	blez	$v0, Error2			# Neu k <= 0 thi thong bao loi va nhap lai k
	sgt	$v1, $v0, $s0
	bne 	$v1, $0, Error2		# neu k>N thi nhap lai
	add	$s1, $zero, $v0		# s1 = k

	j	NhapMang
Error2:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error2
	syscall
	j	Nhapk			# Quay lai nhap lai N	

NhapMang:
	li	$t0, -1			# Khoi tao i cho vong For1
	# Thong bao nhap tung phan tu cua mang
	li 	$v0, 4
	la 	$a0, message3
	syscall
For1:	addi	$t0, $t0, 1			# i = i + 1
	bge	$t0, $s0, EndFor1		# Neu i = N thi ket thuc vong For1
	li	$v0, 5			# Nhap gia tri phan tu
	syscall
	la	$a0, A			# Ghi gia tri vua nhap vao phan tu A[i]
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	sw	$v0, 0($t1)
	j	For1			# Tiep tuc vong lap
EndFor1:					# a0 dang luu dia chi A

main: 
	addi 	$t0, $s1, -1	#Bat dau duyet tu A[k-1}
	sll 	$t1, $t0,2		
	add 	$t1, $a0, $t1	#Dia chi phan tu vi tri k: A[k-1]
	li 	$v0, 1
	beq 	$s0, $v0, mot_ptu	#Truong hop mang chi co 1 phan tu
loop:	#chay vong for tu vi tri k, bien chay i la $t0
	beq 	$t0,$s0, endloop
	lw 	$t3, 4($t1)		#A[i+1]
	sw 	$t3, 0($t1)		#A[i]=A[i+1]
	add	$t0,$t0,1		#i++
	sll 	$t1, $t0, 2		#$t1=4*$t0
	add 	$t1, $t1, $a0	# t1 chua dia chi A[i+1]
	j loop

endloop:	
	sw $0, -4($t1) 		#xoa phan tu cuoi
continue:
	li $v0, 4			# Thong bao ket qua
	la $a0, message4
	syscall
	la $t6, A			# Bien dia chi de in mang
	sll $t7,$s0,2		# $t7=4*N
	addi $t7, $t7,-4		# Do da xoa 1 phan tu		
	add $t7,$t7,$t6		#	
	j show_arr
Exit:
	li $v0,10
	syscall
mot_ptu:
	sw $0, 0($t1) 		#
	li $v0, 4
	la $a0,message5
	syscall
	j Exit
show_arr:
	li $v0,1
	lw $a0,0($t6)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $t6,$t6,4
	bne $t6,$t7,show_arr
	j Exit

# Author by hafizhhasyhari
