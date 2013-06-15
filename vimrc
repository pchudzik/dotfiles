set background=dark		"Dark theme
set syntax=on			"Kolorowanie skladni
set autoindent			"Automatyczne wciecia
set ruler				"Pozycja w pliku zawsze widoczna
set incsearch			"Wyszukiwanie przyrstowe
set tabstop=4			"Miniejszy tabulator

if has("syntax")        "automatyczne kolorowanie skladni
	syntax on
endif

au BufRead,BufNewFile * start	"Po włączeniu od razu wskakuje w tryb edycji
