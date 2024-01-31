/* 329924567 Gideon Neeman */
.extern rand
.extern printf
.extern scanf

.section .data
user_seed:
    .long
user_guess:
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
win_fmt:
    .string "Congratz! You Won!\n"
inco_fmt:
    .string "Incorrect.\n"
over_fmt:
    .string "Game over, you lost :(. The correct answer was %d\n"

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
    movq user_seed, %rdi
    xorq %rax, %rax
    call srand

    # call rand to get a number
    xorq %rax, %rax
    call rand
    movq %rax, %r15 
    # move the num to rax for division
    movq %r15, %rax
    xorq %rdx, %rdx
    # divide by 10
    mov $10, %rcx
    idiv %rcx
    # we need the modulu who's in rdx
    movq %rdx, %r15
    
    # i=1 to 5 for loop
    movq $1, %r14
    movq $5, %r13
    jmp loop_five

loop_five:
    cmp %r14, %r13
    jl game_over
    movq  $guess_fmt, %rdi
    xorq  %rax, %rax
    call printf
    # get guess from the user
    movq $scanf_fmt, %rdi
    movq $user_guess, %rsi
    xorq %rax, %rax
    call scanf
    # compare guess with real number
    cmp user_guess, %r15
    je congratz
    jmp incorrect


incorrect:
    # not guessed the right number
    xorq %rax, %rax
    movq $inco_fmt, %rdi
    call printf
    # incr counter
    inc %r14
    jmp loop_five

game_over:
    xorq %rax, %rax
    movq $over_fmt, %rdi
    movq %r15, %rsi
    call printf
    jmp exit

congratz:
    # print win and end program
    xorq %rax, %rax
    movq $win_fmt, %rdi
    call printf
    jmp exit

exit:
    # Exit
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
