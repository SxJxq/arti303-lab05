% male(Person).
male(abraham).
male(herb).
male(homer).
male(bart).
male(clancy).

% female(Person).
female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).

% parent(Parent, Child).
parent(abraham, herb).
parent(abraham, homer).
parent(mona, homer).
parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).
parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).
parent(selma, ling).


% X is the father of Y
father(X, Y) :- parent(X, Y), male(X).

% X is the mother of Y
mother(X, Y) :- parent(X, Y), female(X).

% X is the son of Y
son(X, Y) :- parent(Y, X), male(X).

% X is the daughter of Y
daughter(X, Y) :- parent(Y, X), female(X).

% helper: X and Y share a parent and are not the same person
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

% X is the brother of Y
brother(X, Y) :- sibling(X, Y), male(X).

% X is the sister of Y
sister(X, Y) :- sibling(X, Y), female(X).

% X is the grandfather of Z
grandfather(X, Z) :- parent(X, Y), parent(Y, Z), male(X).

% X is the aunt of Y (X is a sister of one of Y's parents)
aunt(X, Y) :- parent(P, Y), sister(X, P).

% X is the uncle of Y (X is a brother of one of Y's parents)
uncle(X, Y) :- parent(P, Y), brother(X, P).

% X and Y are cousins (their parents are siblings)
cousin(X, Y) :- parent(P1, X), parent(P2, Y), sibling(P1, P2).

% X is an ancestor of Z (recursive rule)
ancestor(X, Z) :- parent(X, Z).
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST QUERIES AND ANSWERS
% (answers shown after pressing ; for more solutions)
% Note: some answers repeat because a child has two parents
% listed, so the shared-parent test succeeds once per parent.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- father ---
% ?- father(homer, bart).
% true.
% ?- father(X, lisa).
% X = homer.

% --- mother ---
% ?- mother(marge, lisa).
% true.
% ?- mother(X, homer).
% X = mona.

% --- son ---
% ?- son(bart, homer).
% true.
% ?- son(X, abraham).
% X = herb ;
% X = homer.

% --- daughter ---
% ?- daughter(lisa, marge).
% true.
% ?- daughter(X, clancy).
% X = marge ;
% X = patty ;
% X = selma.

% --- brother ---
% ?- brother(herb, homer).
% true.
% ?- brother(homer, X).
% X = herb.

% --- sister ---
% ?- sister(lisa, bart).
% true ;
% true.
% ?- sister(patty, X).
% X = marge ;
% X = selma ;
% X = marge ;
% X = selma.

% --- grandfather ---
% ?- grandfather(abraham, bart).
% true.
% ?- grandfather(clancy, X).
% X = bart ;
% X = lisa ;
% X = maggie ;
% X = ling.

% --- aunt ---
% ?- aunt(patty, bart).
% true ;
% true.
% ?- aunt(X, ling).
% X = marge ;
% X = patty ;
% X = marge ;
% X = patty.

% --- uncle ---
% ?- uncle(herb, bart).
% true.
% ?- uncle(X, lisa).
% X = herb.

% --- cousin ---
% ?- cousin(bart, ling).
% true ;
% true.
% ?- cousin(maggie, X).
% X = ling ;
% X = ling.

% --- ancestor ---
% ?- ancestor(abraham, maggie).
% true.
% ?- ancestor(X, ling).
% X = selma ;
% X = clancy ;
% X = jackie.
