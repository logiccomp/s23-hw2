#lang isl-spec

;; Problem 1:
;;
;; A (height) balanced binary tree has a difference in height of the 
;; left and right subtrees of at most 1, where height is the longest path to a leaf. Importantly,
;; this property (or _invariant_) must be mantained when inserting and removing elements
;; from the tree.
;;
;; Your task: define `balanced-prop` as a predicate. 
;; You should test your property on several example trees using `check-property`, 
;; being sure to include both balanced and unbalanced trees.
;; You're welcome to use the example trees we provide as some of your tests, but 
;; you should also define some of your own.


;; part p1-a
(define-struct leaf [value])
(define-struct node [left right])
; A [Tree-of X] is one of:
; - (make-leaf X)
; - (make-node [Tree-of X] [Tree-of X])
;; part p1-a

;; part p1-b
(define T1 (make-node (make-node (make-leaf 2) 
                                 (make-leaf 3)) 
                      (make-leaf 4)))
;; part p1-b

;; part p1-c
(define T2 (make-node (make-node (make-node (make-leaf 1)
                                            (make-leaf 2))
                                 (make-leaf 3)) 
                      (make-leaf 4)))
;; part p1-c

;; part p1-d
(define T3 (make-node (make-node (make-leaf 1) 
                                 (make-leaf 2)) 
                      (make-node (make-leaf 3)
                                 (make-leaf 4))))
;; part p1-d


;; balanced-prop : (X) [Tree-of X] -> Boolean
(define (balanced-prop ...) ...)

(check-property ...)
;; ...


;; Problem 2:
;;
;; A compiler is a program that translates expressions or programs written in one 
;; language into those written in another.
;; Your task is to define a function `compile` with signature `AddExpression -> [List-of Instr]`,
;; and to give it a good specification, `compile-prop`, with plenty of tests. 
;; You might want to define a helper function on `AddExpressions`
;; to help you write `compile-prop`.

;; part p2-a
(define-struct addexpr [left right])
; An AddExpression is one of:
; - Number
; - (make-addexpr Expression Expression)

(define A0 10)
(define A1 (make-addexpr 10 5))
(define A2 (make-addexpr (make-addexpr 3 4) 1))
;; part p2-a

;; part p2-b
(define A3 (make-addexpr (make-addexpr 1 2) 3))
(define A4 (make-addexpr 1 (make-addexpr 2 3)))
;; part p2-b

;; part p2-c
(define-struct push [num])
; An Instr is one of:
; - 'add
; - (make-push Number)
(define I0 (list (make-push 1)))
(define I1 (list (make-push 1) (make-push 1) 'add))
(define I2 (list (make-push 1) (make-push 1) 'add (make-push 2) 'add))
;; part p2-c

;; part p2-d
; eval : [List-of Number] [List-of Instr] -> [List-of Number]
; takes an initial stack and list of instructions and runs them, producing a final stack
; if the instructions are malformed, returns an empty stack; else result will be a stack
; with a single number
(define (eval stk instrs)
  (local [; eval-instr : Instr [List-of Number] [List-of Instr] -> [List-of Number]
          ; evaluates a single instruction, given a stack and rest of instructions
          (define (eval-instr i stk instrs)
            (cond [(symbol? i)
                  (if (>= (length stk) 2)
                      (eval (cons (+ (first stk) (second stk))
                                  (rest (rest stk)))
                            instrs)
                      (list))]
                  [(push? i) (eval (cons (push-num i) stk) instrs)]))]
    (cond [(empty? instrs) stk]
          [(cons? instrs) (eval-instr (first instrs) stk (rest instrs))])))
(check-expect (eval (list) I0) (list 1))
(check-expect (eval (list) I1) (list 2))
(check-expect (eval (list) I2) (list 4))
(check-expect (eval (list) (list (make-push 10) 'add)) (list))
;; part p2-d

;; AddExpression -> [List-of Instr]
;; compiles an AddExpression into a list of instructions that, when run, will produce the same result
(define (compile ...) ...)
(check-expect (compile ...) ...)
;; ...

(define (compile-prop ...) ...)
(check-property ...)
;; ...