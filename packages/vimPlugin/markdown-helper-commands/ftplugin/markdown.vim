scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

command! FormatPandocMDGTable call pdmdtableformatter#FormatThisPandocMDGTable()

let &cpo = s:save_cpo
unlet s:save_cpo
