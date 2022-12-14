#lang scribble/manual
@require[scribble-math]
@require[scribble-math/dollar]
@require[racket/runtime-path]

@require["../../lib.rkt"]
@define-runtime-path[hw-file "hw2.rkt"]

@title[#:tag "hw2" #:style (with-html5 manual-doc-style)]{Homework 2}

@bold{Released:} @italic{Wednesday, January 18, 2023 at 6:00pm}

@bold{Due:} @italic{Wednesday, January 25, 2023 at 6:00pm}


@nested[#:style "boxed"]{
What to Download:

@url{https://github.com/logiccomp/s23-hw2/raw/main/hw2.rkt}
}

Please start with this file, filling in where appropriate, and submit your homework to the @tt{HW2} assignment on Gradescope. This page has additional information, and allows us to format things nicely.


@section{Problem 1}

Consider a binary tree, defined as follows:

@minted-file-part["racket" "p1-a" hw-file]


Trees are often used for fast lookup of sorted data, as if it is sorted, at each node we can continue 
searching down only one half of the tree. But in order to be fast, they have to be 
@italic{balanced}; a degenerate tree that only ever branches down one side will perform the same as a list. 

A (height) balanced binary tree has a difference in height of the 
left and right subtrees of at most 1, where height is the longest path to a leaf. Importantly,
this property (or @italic{invariant}) must be mantained when inserting and removing elements
from the tree. This may not be easy: if you have a tree:

@minted-file-part["racket" "p1-b" hw-file]

And you want to add 1, while mantaining the fact that the tree is sorted (or else, you won't be able to 
use it to quickly look up data), you would want to insert it @italic{before} 2 in the tree. The easiest 
thing would be to replace the leaf 2 with a node with 1 and 2:

@minted-file-part["racket" "p1-c" hw-file]

This is still sorted, but it is no longer balanced, as now the left side of the top-level node has height 3, 
but the right side has height 1, which is a difference of 2. Instead, you might have to "rotate" the 3 to the 
other side to rebalance and get the following tree:

@minted-file-part["racket" "p1-d" hw-file]


There are many different ways of doing this, with different names (AVL trees, Red Black trees, etc), and 
our goal is @italic{not} to implement insertion, rebalancing, deletion, etc. What we do want to do is capture 
the @italic{invariant} of being balanced. 

Your task: define @code{balanced-prop} as a predicate. You should test your property on several example 
trees using @code{check-property}. 

@section{Problem 2}
A compiler is a program that translates expressions or programs written in one language into those written 
in another. We'll come back to this idea later in the semester, but for this exercise, we are going to just 
consider simple arithmetic expressions (so simple, in fact, they only have addition!). 

First, consider the following data definition:

@minted-file-part["racket" "p2-a" hw-file]

This definition allows us to define arithmetic expressions with numbers and just + (so "Add Expressions").
 We don't 
have a direct way of writing "1 + 2 + 3", but we can write the two equivalent expressions "(1 + 2) + 3" and 
"1 + (2 + 3)":

@minted-file-part["racket" "p2-b" hw-file]


Now, consider this second data definition: 

@minted-file-part["racket" "p2-c" hw-file]

This second definition forms instructions for a stack-based calculator: each instruction operates on 
the stack of numbers, either pushing a new number or adding the top two (and pushing the result).

We can define an evaluator for a series of stack instructions as:

@minted-file-part["racket" "p2-d" hw-file]

Now, your task is to define a function @code{compile} with signature @code{AddExpression -> [List-of Instr]},
and to give it a good specification, @code{compile-prop}. Be sure to test your property on several examples using @code{check-property}.
You might want to define a helper function on @code{AddExpressions} 
to help you write @code{compile-prop}. 