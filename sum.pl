%Entry point: run this query to begin
start :-
	write('Enter a value for A : '), read(A),
	write('Enter a value for B : '), read(B),

	Sum is A + B,
	Diff is A - B,
	Quotient is A / B,
	Product is A * B,
	IntQuotient is A // B,
	Remainder is A mod B,
	Power is A ^ B,
	NegativeA is -A,
	AbsA is abs(A),
	SqrtA is sqrt(A),
	MaxAB is max(A, B),
	RoundedA is round(A), 

nl,write('Results :'),nl,
write('A + B = '),write(Sum), nl,
write('A - B = '),write(Diff), nl,
write('A / B = '),write(Quotient), nl,
write('A * B = '),write(Product), nl,
write('A // B = '),write(IntQuotient), nl,
write('A mod B = '),write(Remainder), nl,
write('A ^ B = '),write(Power), nl,
write('-A = '),write(NegativeA), nl,
write('abs(A) = '),write(AbsA), nl,
write('sqrt(A) = '),write(Sqrt), nl,
write('max(A, B) = '),write(MaxAB), nl,
write('round(A) = '),write(RoundedA), nl.



 
	