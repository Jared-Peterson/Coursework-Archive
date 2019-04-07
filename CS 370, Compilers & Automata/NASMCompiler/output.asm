%include "io64.inc"

common	a	8
common	b	8
common	c	8
common	x	32

section .data

_L0:	db	"testing read",0	;global string
_L1:	db	"you entered",0	;global string
_L2:	db	"testing write",0	;global string
_L6:	db	"a:",0	;global string
_L7:	db	"b:",0	;global string
_L8:	db	"c:",0	;global string
_L9:	db	"testing expressions",0	;global string
_L10:	db	"a + b = ",0	;global string
_L12:	db	"c - b = ",0	;global string
_L14:	db	"b * c = ",0	;global string
_L16:	db	"c / a = ",0	;global string
_L18:	db	"testing while",0	;global string
_L24:	db	"testing operators with if",0	;global string
_L45:	db	"testing else",0	;global string
_L52:	db	"testing arrays",0	;global string
_L57:	db	"should print 1",0	;global string
_L51:	db	"in nested if",0	;global string
_L47:	db	"a is equal to b",0	;global string
_L48:	db	"a is not equal to b",0	;global string
_L44:	db	"a is not equal to b",0	;global string
_L42:	db	"a is equal to b",0	;global string
_L40:	db	"b is greater than or equal to a",0	;global string
_L38:	db	"a is greater than or equal to b",0	;global string
_L36:	db	"b is less than or equal to a",0	;global string
_L34:	db	"a is less than or equal to b",0	;global string
_L32:	db	"b is greater than a",0	;global string
_L30:	db	"a is greater than b",0	;global string
_L28:	db	"b is less than a",0	;global string
_L26:	db	"a is less than b",0	;global string
_L21:	db	"d:",0	;global string

section .text

	global main

main:		;Start of Function
	mov	rbp, rsp	;For main only
	mov	r8, rsp	;FUNC header RSP has to be at most RBP
	add	r8, -240	;adjust Stack Pointer for Activation record
	mov	[r8], rbp	;FUNC header store old BP
	mov	[r8+8], rsp	;FUNC header store old SP
	mov	rsp, r8	;FUNC header new SP
	PRINT_STRING	_L0	;standard write value
	NEWLINE		;standard newline

	mov	rax, 24 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	GET_DEC	8, [rax]	;readstmt
	PRINT_STRING	_L1	;standard write value
	NEWLINE		;standard newline

	mov	rax, 24 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	mov	rsi, [rax]	;load immediate value
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L2	;standard write value
	NEWLINE		;standard newline
	mov	rax, 1 	;get identifier offset
	mov	[rsp+32], rax	;store rhs

	mov	rax, a	;put address into rax
	mov	rbx, [rsp+32]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	mov	rax, 2 	;get identifier offset
	mov	[rsp+40], rax	;store rhs

	mov	rax, b	;put address into rax
	mov	rbx, [rsp+40]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	mov	rax, 3 	;get identifier offset
	mov	[rsp+48], rax	;store rhs

	mov	rax, c	;put address into rax
	mov	rbx, [rsp+48]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	PRINT_STRING	_L6	;standard write value
	NEWLINE		;standard newline

	mov	rax, a	;put address into rax
	mov	rsi, [rax]	;load immediate value
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L7	;standard write value
	NEWLINE		;standard newline

	mov	rax, b	;put address into rax
	mov	rsi, [rax]	;load immediate value
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L8	;standard write value
	NEWLINE		;standard newline

	mov	rax, c	;put address into rax
	mov	rsi, [rax]	;load immediate value
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L9	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L10	;standard write value
	NEWLINE		;standard newline

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+56], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+56]	;store rsp + offset into rax
	add	rax, rbx	;EXPR ADD
	mov	[rsp+56], rax	;store rax
	mov	rsi, [rsp+56]	;load expr value from expr mem
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L12	;standard write value
	NEWLINE		;standard newline

	mov	rax, c	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+64], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+64]	;store rsp + offset into rax
	sub	rax, rbx	;EXPR SUB
	mov	[rsp+64], rax	;store rax
	mov	rsi, [rsp+64]	;load expr value from expr mem
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L14	;standard write value
	NEWLINE		;standard newline

	mov	rax, b	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+72], rax	;store rax

	mov	rax, c	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+72]	;store rsp + offset into rax
	imul	rax, rbx	;EXPR TIMES
	mov	[rsp+72], rax	;store rax
	mov	rsi, [rsp+72]	;load expr value from expr mem
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L16	;standard write value
	NEWLINE		;standard newline

	mov	rax, c	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+80], rax	;store rax

	mov	rax, a	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+80]	;store rsp + offset into rax
	xor	rdx, rdx	;EXPR XOR
	idiv	rbx	;EXPR DIV
	mov	[rsp+80], rax	;store rax
	mov	rsi, [rsp+80]	;load expr value from expr mem
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	PRINT_STRING	_L18	;standard write value
	NEWLINE		;standard newline
	mov	rax, 0 	;get identifier offset
	mov	[rsp+88], rax	;store rhs

	mov	rax, 16 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	mov	rbx, [rsp+88]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax

_L59:	;while top target

	mov	rax, 16 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+96], rax	;store rax
	mov	rbx, 3 	;get identifier offset
	mov	rax, [rsp+96]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR LESSTHAN 
	setl	al	;EXPR LESSTHAN
	mov	rbx, 1	;set rbx to 1 to filter rax
	and	rax, rbx	;filter RAX
	mov	[rsp+96], rax	;store rax
	mov	rax, [rsp+96]	;while expression expr
	CMP	rax, 0	;while compare
	JE	_L60,	;while branch
	PRINT_STRING	_L21	;standard write value
	NEWLINE		;standard newline

	mov	rax, 16 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	mov	rsi, [rax]	;load immediate value
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline

	mov	rax, 16 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+104], rax	;store rax
	mov	rbx, 1 	;get identifier offset
	mov	rax, [rsp+104]	;store rsp + offset into rax
	add	rax, rbx	;EXPR ADD
	mov	[rsp+104], rax	;store rax
	mov	rax, [rsp+104]	;expressionstmt expr
	mov	[rsp+112], rax	;store rhs

	mov	rax, 16 	;get identifier offset
	add	rax, rsp	;Add the sp to have direct reference to memory
	mov	rbx, [rsp+112]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	JMP	_L59	;while jump back 

_L60:	;while end target
	PRINT_STRING	_L24	;standard write value
	NEWLINE		;standard newline

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+104], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+104]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR LESSTHAN 
	setl	al	;EXPR LESSTHAN
	mov	rbx, 1	;set rbx to 1 to filter rax
	and	rax, rbx	;filter RAX
	mov	[rsp+104], rax	;store rax
	mov	rax, [rsp+104]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L61, 	;if branch to else
	PRINT_STRING	_L26	;standard write value
	NEWLINE		;standard newline
	JMP	_L62	;If s1 end

_L61:	;else target

_L62:	;IF bottom target

	mov	rax, b	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+112], rax	;store rax

	mov	rax, a	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+112]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR LESSTHAN 
	setl	al	;EXPR LESSTHAN
	mov	rbx, 1	;set rbx to 1 to filter rax
	and	rax, rbx	;filter RAX
	mov	[rsp+112], rax	;store rax
	mov	rax, [rsp+112]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L63, 	;if branch to else
	PRINT_STRING	_L28	;standard write value
	NEWLINE		;standard newline
	JMP	_L64	;If s1 end

_L63:	;else target

_L64:	;IF bottom target

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+120], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+120]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR GREATERTHAN
	setg	al	;EXPR GREATERTHAN
	mov	rbx, 1	;set rbx to 1 to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+120], rax	;store rax
	mov	rax, [rsp+120]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L65, 	;if branch to else
	PRINT_STRING	_L30	;standard write value
	NEWLINE		;standard newline
	JMP	_L66	;If s1 end

_L65:	;else target

_L66:	;IF bottom target

	mov	rax, b	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+128], rax	;store rax

	mov	rax, a	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+128]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR GREATERTHAN
	setg	al	;EXPR GREATERTHAN
	mov	rbx, 1	;set rbx to 1 to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+128], rax	;store rax
	mov	rax, [rsp+128]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L67, 	;if branch to else
	PRINT_STRING	_L32	;standard write value
	NEWLINE		;standard newline
	JMP	_L68	;If s1 end

_L67:	;else target

_L68:	;IF bottom target

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+136], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+136]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR LESSTHANEQUAL
	setle	al	;EXPR LESSTHANEQUAL
	mov	rbx, 1	;Set rbx to 1 to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+136], rax	;store rax
	mov	rax, [rsp+136]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L69, 	;if branch to else
	PRINT_STRING	_L34	;standard write value
	NEWLINE		;standard newline
	JMP	_L70	;If s1 end

_L69:	;else target

_L70:	;IF bottom target

	mov	rax, b	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+144], rax	;store rax

	mov	rax, a	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+144]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR LESSTHANEQUAL
	setle	al	;EXPR LESSTHANEQUAL
	mov	rbx, 1	;Set rbx to 1 to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+144], rax	;store rax
	mov	rax, [rsp+144]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L71, 	;if branch to else
	PRINT_STRING	_L36	;standard write value
	NEWLINE		;standard newline
	JMP	_L72	;If s1 end

_L71:	;else target

_L72:	;IF bottom target

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+152], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+152]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR GREATERTHANEQUAL
	setge	al	;EXPRE GREATERTHANEQUAL
	mov	rbx, 1	;set rbx to one to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+152], rax	;store rax
	mov	rax, [rsp+152]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L73, 	;if branch to else
	PRINT_STRING	_L38	;standard write value
	NEWLINE		;standard newline
	JMP	_L74	;If s1 end

_L73:	;else target

_L74:	;IF bottom target

	mov	rax, b	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+160], rax	;store rax

	mov	rax, a	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+160]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR GREATERTHANEQUAL
	setge	al	;EXPRE GREATERTHANEQUAL
	mov	rbx, 1	;set rbx to one to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+160], rax	;store rax
	mov	rax, [rsp+160]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L75, 	;if branch to else
	PRINT_STRING	_L40	;standard write value
	NEWLINE		;standard newline
	JMP	_L76	;If s1 end

_L75:	;else target

_L76:	;IF bottom target

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+168], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+168]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR EQUAL
	sete	al	;EXPR EQUAL
	mov	rbx, 1	;set rbx to one to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+168], rax	;store rax
	mov	rax, [rsp+168]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L77, 	;if branch to else
	PRINT_STRING	_L42	;standard write value
	NEWLINE		;standard newline
	JMP	_L78	;If s1 end

_L77:	;else target

_L78:	;IF bottom target

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+176], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+176]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR NOTEQUAL
	setne	al	;EXPR NOTEQUAL
	mov	rbx, 1	;Set rbx to 1 to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+176], rax	;store rax
	mov	rax, [rsp+176]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L79, 	;if branch to else
	PRINT_STRING	_L44	;standard write value
	NEWLINE		;standard newline
	JMP	_L80	;If s1 end

_L79:	;else target

_L80:	;IF bottom target
	PRINT_STRING	_L45	;standard write value
	NEWLINE		;standard newline

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+184], rax	;store rax

	mov	rax, b	;put address into rax
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+184]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR EQUAL
	sete	al	;EXPR EQUAL
	mov	rbx, 1	;set rbx to one to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+184], rax	;store rax
	mov	rax, [rsp+184]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L81, 	;if branch to else
	PRINT_STRING	_L47	;standard write value
	NEWLINE		;standard newline
	JMP	_L82	;If s1 end

_L81:	;else target
	PRINT_STRING	_L48	;standard write value
	NEWLINE		;standard newline

_L82:	;IF bottom target

	mov	rax, a	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+192], rax	;store rax
	mov	rbx, 1 	;get identifier offset
	mov	rax, [rsp+192]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR EQUAL
	sete	al	;EXPR EQUAL
	mov	rbx, 1	;set rbx to one to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+192], rax	;store rax
	mov	rax, [rsp+192]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L83, 	;if branch to else

	mov	rax, b	;put address into rax
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+200], rax	;store rax
	mov	rbx, 2 	;get identifier offset
	mov	rax, [rsp+200]	;store rsp + offset into rax
	cmp	rax, rbx	;EXPR EQUAL
	sete	al	;EXPR EQUAL
	mov	rbx, 1	;set rbx to one to filter rax
	and	rax, rbx	;filter rax
	mov	[rsp+200], rax	;store rax
	mov	rax, [rsp+200]	;if expression expr
	CMP	rax, 0	;if compare
	JE	_L85, 	;if branch to else
	PRINT_STRING	_L51	;standard write value
	NEWLINE		;standard newline
	JMP	_L86	;If s1 end

_L85:	;else target

_L86:	;IF bottom target
	JMP	_L84	;If s1 end

_L83:	;else target

_L84:	;IF bottom target
	PRINT_STRING	_L52	;standard write value
	NEWLINE		;standard newline
	mov	rax, 1 	;get identifier offset
	mov	[rsp+200], rax	;store rhs
	mov	rbx, 0 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rsp+200]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	mov	rax, 2 	;get identifier offset
	mov	[rsp+208], rax	;store rhs
	mov	rbx, 8 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rsp+208]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	mov	rax, 3 	;get identifier offset
	mov	[rsp+216], rax	;store rhs
	mov	rbx, 16 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rsp+216]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	mov	rax, 0 	;get identifier offset
	mov	[rsp+224], rax	;store rhs
	mov	rbx, 24 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rsp+224]	;fetch rhs of assign temporarily
	mov	[rax], rbx	;move rhs into rax
	PRINT_STRING	_L57	;standard write value
	NEWLINE		;standard newline
	mov	rbx, 8 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rax]	;move rax value to rbx
	shl	rbx, 3	;Array reference needs WSIZE differencing

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rax]	;move rax value to rbx
	shl	rbx, 3	;Array reference needs WSIZE differencing

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rax]	;move rax value to rbx
	shl	rbx, 3	;Array reference needs WSIZE differencing

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rsi, [rax]	;load immediate value
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	mov	rbx, 8 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rax, [rax]	;LHS expression is identifier
	mov	[rsp+232], rax	;store rax
	mov	rbx, 16 	;assign value to rbx

	mov	rax, x	;put address into rax
	add	rax, rbx	;add offset and stack pointer
	mov	rbx, [rax]	;RHS expression is identifier
	mov	rax, [rsp+232]	;store rsp + offset into rax
	imul	rax, rbx	;EXPR TIMES
	mov	[rsp+232], rax	;store rax
	mov	rsi, [rsp+232]	;load expr value from expr mem
	PRINT_DEC	8, rsi	;standard write value
	NEWLINE		;standard newline
	xor	rax, rax	;nothing to return

	mov	rbp, [rsp]	;FUNC end restore old BP
	mov	rsp, [rsp+8]	;FUNC end restore old SP
	mov	rsp, rbp	;stack and BP need to be same on exit for main
	ret
