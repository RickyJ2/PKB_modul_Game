domains
	kolom, baris = integer
	ox = char
facts - listKotak
	kotak(baris, kolom, ox)
predicates
	nondeterm opponent(ox, ox)
	nondeterm go
	nondeterm initKotak
	nondeterm tampilPapan(baris, kolom)
	nondeterm start(ox)
	nondeterm readMove(ox)
	nondeterm move(baris, kolom, ox)
	nondeterm validMove(baris, kolom)
	nondeterm anyValidMove
	nondeterm win(ox)
	nondeterm vertical(ox)
	nondeterm horizontal(ox)
	nondeterm diagonal(ox)
clauses
	%fakta
	opponent('O', 'X'). %Lawan dari O adalah X
	opponent('X', 'O'). %Lawan dari X adalah 0
	%rule
	go:- 
		initKotak,
		start('O'). %giliran pertama dimulai dari O
		
	initKotak:- %menginisialisasi posisi awal papan Tic Tac Toe
		assertz(kotak(1,1,' '), listKotak), assertz(kotak(1,2,' '), listKotak),	assertz(kotak(1,3,' '), listKotak), 
		assertz(kotak(2,1,' '), listKotak), assertz(kotak(2,2,' '), listKotak),	assertz(kotak(2,3,' '), listKotak),
		assertz(kotak(3,1,' '), listKotak), assertz(kotak(3,2,' '), listKotak),	assertz(kotak(3,3,' '), listKotak).
		
	tampilPapan(Baris,Kolom):-
		Baris <= 3,
		Kolom < 3,
		kotak(Baris, Kolom, OX),
		write(" ", OX ," ", "|"),
		Kolom1 = Kolom + 1,
		tampilPapan(Baris, Kolom1),!;
		
		Baris < 3,
		Kolom = 3,
		kotak(Baris, Kolom, OX),
		write(" ", OX ," "), nl,
		Baris1 = Baris + 1, 
		tampilPapan(Baris1, 1),!;
		
		Baris = 3,
		Kolom = 3,
		kotak(Baris, Kolom, OX),
		write(" ", OX ," "), nl.
		
	start(OX):-
		opponent(OX, Player), %cek apakah lawan sudah menang
		win(Player), write(Player, " menang"), nl, tampilPapan(1,1),!;
		
		write("YOU: X"), nl,
		write("COM: O"), nl,
		tampilPapan(1,1),
		anyValidMove, %cek apakah ada gerakan yang memungkinkan, jika tidak berhenti disini dan seri
		readMove(OX),nl, %baca gerakan OX
		opponent(OX, Player), %cari lawan dari OX
		start(Player),!; %giliran lawan berikutnya
		
		write("Seri"), nl.
		
	anyValidMove:-
		kotak(_,_,' '). %selama ada yg kosong berarti masih bisa gerak
		
	readMove(OX):-
		write(OX, " move: "), nl,
		write("  Baris: "), readint(Baris),
		write("  Kolom: "), readint(Kolom),
		move(Baris, Kolom, OX).
		
	move(Baris, Kolom, OX):-		
		validMove(Baris, Kolom), %cek apakah kotaknya uda berisi, jika uda invalid
		retract(kotak(Baris, Kolom, _), listKotak),
		assertz(kotak(Baris, Kolom, OX), listKotak);
		
		write("Inputan tidak valid"),nl,
		readMove(OX).
	validMove(Baris, Kolom):-
		kotak(Baris,Kolom, ' '), %Posisinya harus kosong
		Baris >= 1, Baris <= 3, %baris dan kolom diantara 1 dan 3
		Kolom >= 1, Kolom <= 3.
	win(OX):-
		horizontal(OX),!; vertical(OX),!; diagonal(OX).
	vertical(OX):-
		kotak(1, Kolom, OX), kotak(2, Kolom, OX), kotak(3, Kolom, OX).
	horizontal(OX):-
		kotak(Baris, 1, OX), kotak(Baris, 2, OX), kotak(Baris, 3, OX).
	diagonal(OX):-
		kotak(1, 1, OX), kotak(2, 2, OX), kotak(3, 3, OX),!;
		kotak(1, 3, OX), kotak(2, 2, OX), kotak(3, 1, OX).
goal
	go.