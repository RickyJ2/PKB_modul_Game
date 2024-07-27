domains
	kolom, baris = integer
	pion = char
	movement = integer
facts - papan
	titik(baris, kolom, pion)
predicates
	nondeterm opponent(pion, pion)
	nondeterm go
	nondeterm initPapan
	nondeterm tampilPapan(baris, kolom)
	nondeterm start(pion)
	nondeterm readMovementMove(pion)
	nondeterm doMovement(baris, kolom, pion, movement)
	nondeterm showListMove(pion)
	nondeterm chooseMovement(baris, kolom, pion)
	nondeterm cekMove(baris, kolom, pion)
	nondeterm validMovement(baris, kolom)
	nondeterm validMove(baris,kolom)
	nondeterm win(pion)
	nondeterm vertical(pion)
	nondeterm horizontal(pion)
	nondeterm diagonal(pion)
clauses
	%fakta
	opponent('B', 'W').
	opponent('W', 'B').
	
	%rule
	go:-
		initPapan,
		start('B').
	initPapan:-
		assertz(titik(1,1,'B'), papan), assertz(titik(1,2,' '), papan),	assertz(titik(1,3,'W'), papan), 
		assertz(titik(2,1,'B'), papan), assertz(titik(2,2,' '), papan),	assertz(titik(2,3,'W'), papan),
		assertz(titik(3,1,'B'), papan), assertz(titik(3,2,' '), papan),	assertz(titik(3,3,'W'), papan).
	tampilPapan(Baris, Kolom):-
		Baris <= 3,
		Kolom < 3,
		titik(Baris, Kolom, Pion),
		write(" ", Pion ," ", "--"),
		Kolom1 = Kolom + 1,
		tampilPapan(Baris, Kolom1),!;
		
		Baris < 3,
		Kolom = 3,
		titik(Baris, Kolom, Pion),
		write(" ", Pion ," "), nl,
		write(" |    |    | "), nl,
		Baris1 = Baris + 1, 
		tampilPapan(Baris1, 1),!;
		
		Baris = 3,
		Kolom = 3,
		titik(Baris, Kolom, Pion),
		write(" ", Pion ," "), nl.
	start(Pion):-
		opponent(Pion, Player), %cek apakah lawan sudah menang
		win(Player), write(Player, " menang"), nl, tampilPapan(1,1),!;

		tampilPapan(1,1),
		readMovementMove(Pion),nl,
		opponent(Pion, Player), %cari lawan dari Pion
		start(Player).
	readMovementMove(Pion):-
		write(Pion, " move: "), nl,
		write("==========DAFTAR PION========"), nl,
		showListMove(Pion),
		write("============================="), nl,
		write("Pilih Pion ingin digerakan: "), nl,
		write("  Baris: "), readint(Baris),
		write("  Kolom: "), readint(Kolom),
		cekMove(Baris, Kolom, Pion),
		validMovement(Baris, Kolom),
		chooseMovement(Baris, Kolom, Pion),!;
		
		write("Inputan tidak valid"), nl,
		readMovementMove(Pion).
		
	chooseMovement(Baris, Kolom, Pion):-
		write("Pilih gerakan untuk Pion ini "),nl,
		write("  1. Atas"),nl,
		write("  2. Bawah"),nl,
		write("  3, Kiri"),nl,
		write("  4. Kanan"),nl,
		write("  5. Diagonal Kiri Atas"), nl,
		write("  6. Diagonal Kiri Bawah"), nl,
		write("  7. Diagonal Kanan Atas"), nl,
		write("  8. Diagonal Kanan Bawah"), nl,
		write(" >>> "), readint(Movement),
		doMovement(Baris, Kolom, Pion, Movement),!;
		
		write("Inputan tidak valid"), nl,
		chooseMovement(Baris, Kolom, Pion).
		
	cekMove(Baris, Kolom, Pion):-
		titik(Baris, Kolom, Pion).
	showListMove(Pion):-
		titik(Baris, Kolom, Pion),
		validMovement(Baris, Kolom),
		write("Baris : ", Baris, " Kolom: ", Kolom),nl,
		1=2,!; 1=1.
	doMovement(Baris, Kolom, Pion, Movement):-
		Movement = 1, %atas
		Baris1 = Baris - 1,
		validMove(Baris1, Kolom),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris1, Kolom, _), papan), %isi titik baru
		assertz(titik(Baris1, Kolom, Pion), papan), !;
		
		Movement = 2, %Bawah
		Baris1 = Baris + 1,
		validMove(Baris1, Kolom),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris1, Kolom, _), papan), %isi titik baru
		assertz(titik(Baris1, Kolom, Pion), papan), !;
		
		Movement = 3, %Kiri
		Kolom1 = Kolom - 1,
		validMove(Baris, Kolom1),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris, Kolom1, _), papan), %isi titik baru
		assertz(titik(Baris, Kolom1, Pion), papan), !;
		
		Movement = 4, % Kanan
		Kolom1 = Kolom + 1,
		validMove(Baris, Kolom1),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris, Kolom1, _), papan), %isi titik baru
		assertz(titik(Baris, Kolom1, Pion), papan),!;
		
		Movement = 5, %Kiri Atas
		Baris1 = Baris - 1,
		Kolom1 = Kolom - 1,
		validMove(Baris1, Kolom1),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris1, Kolom1, _), papan), %isi titik baru
		assertz(titik(Baris1, Kolom1, Pion), papan), !;
		
		Movement = 6, %Kiri Bawah
		Baris1 = Baris + 1,
		Kolom1 = Kolom - 1,
		validMove(Baris1, Kolom1),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris1, Kolom1, _), papan), %isi titik baru
		assertz(titik(Baris1, Kolom1, Pion), papan), !;
		
		Movement = 7, %Kanan Atas
		Baris1 = Baris - 1,
		Kolom1 = Kolom + 1,
		validMove(Baris1, Kolom1),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris1, Kolom1, _), papan), %isi titik baru
		assertz(titik(Baris1, Kolom1, Pion), papan), !;
		
		Movement = 8, %Kanan Bawah
		Baris1 = Baris + 1,
		Kolom1 = Kolom + 1,
		validMove(Baris1, Kolom1),
		retract(titik(Baris, Kolom, Pion), papan), %kosongin titik skrng
		assertz(titik(Baris, Kolom, ' '), papan),
		retract(titik(Baris1, Kolom1, _), papan), %isi titik baru
		assertz(titik(Baris1, Kolom1, Pion), papan).
	validMovement(Baris, Kolom):-
		Baris1 = Baris - 1, validMove(Baris1, Kolom),!;
		Baris1 = Baris + 1, validMove(Baris1, Kolom),!;
		Kolom1 = Kolom - 1, validMove(Baris, Kolom1),!;
		Kolom1 = Kolom + 1, validMove(Baris, Kolom1),!;
		Baris1 = Baris - 1, Kolom1 = Kolom - 1, validMove(Baris1, Kolom1),!;
		Baris1 = Baris + 1, Kolom1 = Kolom - 1, validMove(Baris1, Kolom1),!;
		Baris1 = Baris - 1, Kolom1 = Kolom + 1, validMove(Baris1, Kolom1),!;
		Baris1 = Baris + 1, Kolom1 = Kolom + 1, validMove(Baris1, Kolom1).
	validMove(Baris, Kolom):-
		titik(Baris,Kolom, ' '), %Posisinya harus kosong
		Baris >= 1, Baris <= 3, %baris dan kolom diantara 1 dan 3
		Kolom >= 1, Kolom <= 3.
	win(Pion):-
		horizontal(Pion),!; vertical(Pion),!; diagonal(Pion).
	vertical(Pion):-
		Pion = 'B', 
		titik(1, Kolom, Pion), titik(2, Kolom, Pion), titik(3, Kolom, Pion), 
		Kolom <> 1,!;
		Pion = 'W', 
		titik(1, Kolom, Pion), titik(2, Kolom, Pion), titik(3, Kolom, Pion), 
		Kolom <> 3.
	horizontal(Pion):-
		titik(Baris, 1, Pion), titik(Baris, 2, Pion), titik(Baris, 3, Pion).
	diagonal(Pion):-
		titik(1, 1, Pion), titik(2, 2, Pion), titik(3, 3, Pion),!;
		titik(1, 3, Pion), titik(2, 2, Pion), titik(3, 1, Pion).
goal	
	go.