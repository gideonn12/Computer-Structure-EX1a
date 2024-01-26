/* 329924567 Gideon Neeman */
.extern rand
.extern printf
.extern scanf

.section .data
user_seed:
    .long

.section .rodata
user_greet_fmt:
    .string "Enter configuration seed: "
scanf_fmt:
    .string "%d"
result_fmt:
    .string "the seed: %d\n"
guess_fmt:
    .string "What is your guess? "

.section .text
.globl main
.type   main, @function
main:
    # Enter
    pushq %rbp
    movq %rsp, %rbp

    # Print prompt
    movq $user_greet_fmt, %rdi
    xorq %rax, %rax
    call printf

    # Read the seed
    movq $scanf_fmt, %rdi
    movq $user_seed, %rsi
    xorq %rax, %rax
    call scanf

    # send seed to srand
    # movq $user_seed, %rdi
    # xorq %rax, %rax
    # call srand

    # i=1 to 5 for loop
    movq $1, %r12
    movq $5, %r13
    jmp loop_five


loop_five:
    cmp %r12,%r13
    jl exit

    movq  $guess_fmt, %rdi
    xorq  %rax, %rax
    call printf
    inc %r12
    jmp loop_five

exit:
    # Exit
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
