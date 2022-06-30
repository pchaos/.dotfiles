function! myspacevim#before() abort
    set timeoutlen=10
    let g:python_host_prog = expand('~/software/python3rd/anaconda/envs/py27/bin/python')
    " let g:python3_host_prog = expand('~/software/python3rd/anaconda/bin/python3')
    let g:python3_host_prog = expand('/usr/bin/python3')
    let g:plug_url_format="https://hub.fastgit.org/%s.git"
    let g:pydocstring_doq_path = '~/.local/bin/doq'
    set ma
    set listchars=tab:»-,trail:■
    set list
    " nnoremap <Leader>xy gg0vG$\Y<cr>
endfunction

function! myspacevim#after() abort
    " 编辑模式下面映射esc按键
    " inoremap zz <esc>
    " vnoremap zz <esc>
    " nnoremap zz <esc>
    " 因为mac的gui导致ctrl+[]有冲突修正翻页按键
    " 上一页/下一页
    " nnoremap K <pageup>
    " nnoremap J <pagedown>
    " 还是一次跳5行还是舒服点
    " nnoremap K :-5<cr>
    " nnoremap J :+5<cr>

    " 反撤销(备注: <c-y> 就是Ctrl+y)
    " nnoremap ru :redo<cr>
    " coc flutter jump to definded
    " nnoremap cgd :CocCommand flutter.gotoSuper<cr>
    " 编辑模式下 AS 保存文件
    " inoremap AS <esc>:w<cr>a
  " [mouse support] 鼠标支持
  " set selection=inclusive " 指定在选择文本时光标所在位置也属于被选中的范围
  set selectmode=mouse,key " 使鼠标和键盘都可以控制光标选择文本
  nnoremap <Leader>xy @g<cr>
endfunction
