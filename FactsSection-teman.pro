domains
	person = string
facts - daftarTeman
	teman(person, person)
predicates
	nondeterm go
	nondeterm init
	nondeterm cetakDaftarTeman
	nondeterm cariTeman(person)
	nondeterm filterTeman
clauses
	go:-	
		init, 
		cetakDaftarTeman, nl,
		cariTeman("Andi"),nl,
		filterTeman, nl.
	init:-
		assertz(teman("Andi", "Budi"), daftarTeman),
		assertz(teman("Andi", "Dudu"), daftarTeman),	
		assertz(teman("Budi", "Dodo"), daftarTeman),		
		assertz(teman("Dido", "Budi"), daftarTeman),
		assertz(teman("Andi", "Jodo"), daftarTeman).
	cetakDaftarTeman:-
		write("DAFTAR TEMAN"), nl,
		teman(Person, Person2),
		write(Person, " teman dari ", Person2), nl,
		1=2;
		1=1.
	cariTeman(Person):-
		write("DAFTAR TEMAN DARI ", Person), nl,
		teman(Person, Person2),
		write(Person2), nl,
		1=2;
		1=1.	
	filterTeman:-
		Filter = "Andi",
		write("DAFTAR TEMAN DARI ", Filter), nl,
		teman(Person, Person2),
		Person = Filter,
		write(Person2), nl,
		1=2;
		1=1.
		
goal
	go.