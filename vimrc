colorscheme molokai
syntax enable
set termguicolors
set relativenumber
set shiftwidth=4
set expandtab
set tabstop=4
set number

command! RunCpp w !g++ -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! RunC w !gcc -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! InstallPlug call InstallPlug()

function! InstallPlug()
    call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
endfunction

nnoremap <silent><S-CR> :normal! o <CR>
nnoremap <silent><C-S-CR> :normal! O <CR>
nnoremap <silent><C-Space> :NERDTreeToggle<CR>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

call plug#begin('~/.vim/VIM/')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-commentary'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'

call plug#end()

