scriptencoding utf-8

let s:suite = themis#suite('magicchar-t emmet-like behavior:')

let s:scope = themis#helper('scope')
let s:t = s:scope.funcs('autoload/sandwich/magicchar/t.vim')


function! s:suite.add() abort
  " #1
  call setline(1, 'foo')
  execute "normal 1Gsaiwtp\<CR>"
  call g:assert.equals(getline(1), '<p>foo</p>', 'failed at #1')

  " #2
  call setline(1, 'foo')
  execute "normal 1GsaiwTp\<CR>"
  call g:assert.equals(getline(1), '<p>foo</p>', 'failed at #2')
endfunction


function! s:suite.delete() abort
  " #1
  call setline(1, '<p>foo</p>')
  normal 1Gsdt
  call g:assert.equals(getline(1), 'foo', 'failed at #1')

  " #2
  call setline(1, '<p>foo</p>')
  normal 1GsdT
  call g:assert.equals(getline(1), 'foo', 'failed at #2')
endfunction


function! s:suite.replace() abort
  " #1
  call setline(1, '<p>foo</p>')
  execute "normal 1Gffsrttdiv\<CR>"
  call g:assert.equals(getline(1), '<div>foo</div>', 'failed at #1')

  " #2
  call setline(1, '<p>foo</p>')
  execute "normal 1GffsrTTdiv\<CR>"
  call g:assert.equals(getline(1), '<div>foo</div>', 'failed at #2')

  " #3
  call setline(1, '<div title="foo">foo</div>')
  execute "normal 1Gffsrttp\<CR>"
  call g:assert.equals(getline(1), '<p title="foo">foo</p>', 'failed at #3')

  " #4
  call setline(1, '<div title="foo">foo</div>')
  execute "normal 1GffsrTTp\<CR>"
  call g:assert.equals(getline(1), '<p>foo</p>', 'failed at #4')
endfunction


function! s:suite.add_selection_exclusive() abort
  set selection=exclusive
  call s:suite.add()
  set selection=inclusive
endfunction


function! s:suite.delete_selection_exclusive() abort
  set selection=exclusive
  call s:suite.delete()
  set selection=inclusive
endfunction


function! s:suite.replace_selection_exclusive() abort
  set selection=exclusive
  call s:suite.replace()
  set selection=inclusive
endfunction
