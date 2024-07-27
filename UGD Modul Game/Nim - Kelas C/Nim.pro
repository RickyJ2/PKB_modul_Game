domains
	koin,id = integer
	player = symbol
facts - tumpukan
	heap(id, koin)
predicates
	nondeterm opponent(player, player)
	nondeterm go
	nondeterm init
	nondeterm tampilTumpukan(id)
	nondeterm start(player)
	nondeterm readMove(player)
	nondeterm move(player, id)
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
		assertz(heap(1,3),tumpukan),
		assertz(heap(2,4),tumpukan),
		assertz(heap(3,5),tumpukan).
	tampilTumpukan(Id):-
		Id <= 3,
		Id1 = Id + 1,
		heap(Id, Coin),
		write("   Tumpukan ", Id, " ada ", Coin, " Koin"),nl,
		tampilTumpukan(Id1); 1=1.
	start(Player):-
		opponent(Player, Opponent),
		win, write(Opponent, " menang"), nl,!;
		
		readMove(Player),nl,
		opponent(Player, Opponent),
		start(Opponent).
	readMove(Player):-
		write("Giliran ", Player),nl,
		write("Pilih tumpukan yang ingin diambil"),nl,
		tampilTumpukan(1),
		write(" >>> "),readint(Pilihan),
		move(Player, Pilihan).
	move(Player, Id):-
		Id <> 1, Id <> 2, Id <> 3,
		write("Pilihan diantara tumpukan yang ada!"),nl,nl,
		readMove(Player),!;
		
		heap(Id,Coin),
		Coin = 0,
		write("Pilih tumpukan lainnya, ini kosong"),nl,nl,
		readMove(Player),!;
		
		heap(Id,Coin),
		write("Banyak koin ingin diambil: "), readint(Count),
		Count <= Coin,
		Coin1 = Coin - Count,
		retract(heap(Id, _), tumpukan),
		assertz(heap(Id, Coin1), tumpukan),!;
		
		write("Jumlah koin yg ingin diambil tidak boleh melebihi koin yg ada"),nl,
		move(Player, Id).
		
	win:-
		heap(1,0), heap(2,0), heap(3,0).
goal
	go.