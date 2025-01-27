colorscheme molokai
syntax enable
set relativenumber
set guicursor=n-v-c-sm:block
set termguicolors
set shiftwidth=4
set expandtab
set tabstop=4
set number

command! RunCpp w !g++ -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! RunC w !gcc -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! InstallPlug call InstallPlug()

nnoremap <silent><S-CR> :normal! o <CR>
nnoremap <silent><C-S-CR> :normal! O <CR>
nnoremap <silent><C-n> :Telescope find_files <CR>
nnoremap <silent><C-Space> :NERDTreeToggle<CR>
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


function! InstallPlug()
    call system('curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endfunction

call plug#begin('~/.vim/NVIM/')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-commentary'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'puremourning/vimspector'

call plug#end()

