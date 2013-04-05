set background=dark		"Dark theme
set syntax=on			"Kolorowanie skladni
set autoindent			"Automatyczne wciecia
set ruler			"Pozycja w pliku zawsze widoczna
set incsearch			"Wyszukiwanie przyrstowe

if has('mouse')			"Jesli jest myszka to mozna smyrac
	set mouse=a
endif

au BufRead,BufNewFile * start	"Po włączeniu od razu wskakuje w tryb edycji
