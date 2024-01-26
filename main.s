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

    # Print sead
    movq $result_fmt, %rdi
    movq user_seed, %rsi
    xorq %rax, %rax
    call printf

    # Exit
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
