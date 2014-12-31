" Check if plugin loaded
if exists('loaded_Licence_auto') || &cp
    finish
endif
let loaded_licences_auto=1

function Licence#PutGPL()
    silent normal! o''
    let space = printf('%*s', indent('.'), '')
    silent call setline('.', space . b:ECcommentOpen . " This program is free software: you can redistribute it and/or modify " . b:ECcommentClose)
    silent call  append('.', space . b:ECcommentOpen . " it under the terms of the GNU General Public License as published by " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " the Free Software Foundation, either version 3 of the License, or " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " (at your option) any later version. " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " This program is distributed in the hope that it will be useful, " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " but WITHOUT ANY WARRANTY; without even the implied warranty of " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " GNU General Public License for more details. " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " You should have received a copy of the GNU General Public License " . b:ECcommentClose)
    silent normal! j
    silent call  append('.', space . b:ECcommentOpen . " along with this program.  If not, see <http://www.gnu.org/licenses/>. " . b:ECcommentClose)
    silent normal! j
    silent %s/\s\+$//
endfunction

function Licence#PutWTFPL()
    silent normal! o''
    let space = printf('%*s', indent('.'), '')
    silent call setline('.', space . b:ECcommentOpen . " This program is free software. It comes without any warranty, to " . b:ECcommentClose)
    silent call append('.', space . b:ECcommentOpen . " the extent permitted by applicable law. You can redistribute it " . b:ECcommentClose)
    silent normal! j
    silent call append('.', space . b:ECcommentOpen . " and/or modify it under the terms of the Do What The Fuck You Want " . b:ECcommentClose)
    silent normal! j
    silent call append('.', space . b:ECcommentOpen . " To Public License, Version 2, as published by Sam Hocevar. See " . b:ECcommentClose)
    silent normal! j
    silent call append('.', space . b:ECcommentOpen . " http://www.wtfpl.net/about for more details. " . b:ECcommentClose)
    silent normal! j
    silent %s/\s\+$//
endfunction


