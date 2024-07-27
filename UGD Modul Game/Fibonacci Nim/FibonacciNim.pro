domains
	koin = integer
	player = symbol
facts - tumpukan
	heap(koin)
	maks(koin)
predicates
	nondeterm opponent(player, player)
	nondeterm go
	nondeterm init
	nondeterm tampilTumpukan
	nondeterm start(player)
	nondeterm readMove(player)
	nondeterm validation(player, koin)
	nondeterm win
clauses
	%fakta
	opponent("Player1", "Player2").
	opponent("Player2", "Player1").
	%rule
	go:-
		init,
		start("Player1").
	init:-
		assertz(heap(21),tumpukan),
		assertz(maks(20), tumpukan).
	tampilTumpukan:-
		heap(Coin),
		write("   Tumpukan ada ", Coin, " Koin"),nl.
	start(Player):-
		opponent(Player, Opponent),
		win, write(Opponent, " menang"), nl,!;
		
		readMove(Player),nl,
		opponent(Player, Opponent),
		start(Opponent).
	readMove(Player):-
		write("Giliran ", Player),nl,
		tampilTumpukan,
		write("Banyak koin ingin diambil: "), readint(Count),
		Count <> 0,		
		validation(Player, Count),!;
		
		write("Minimal harus ambil 1"),nl, nl,
		readMove(Player).			
		
	validation(Player, Koin):-
		heap(Coin),maks(MaksCoin),
		Koin <= MaksCoin,
		Koin <= Coin,			
		Coin1 = Coin - Koin,
		MaksCoin1 = Koin*2,
		retract(heap(_), tumpukan),
		assertz(heap(Coin1), tumpukan),
		retract(maks(_), tumpukan),
		assertz(maks(MaksCoin1), tumpukan),!;
		
		maks(MaksCoin),
		Koin > MaksCoin,
		write("Maksimal Coin bisa diambil ", MaksCoin, " Koin"), nl,nl,
		readMove(Player),!;
		
		heap(Coin),
		Koin > Coin,
		write("Jumlah Koin diambil tidak boleh melebihi koin yang ada"), nl,nl,
		readMove(Player).
	win:- 
		heap(0).
goal
	go.
		
		
		