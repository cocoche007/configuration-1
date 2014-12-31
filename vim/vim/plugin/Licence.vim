" check if plugin loaded
if exists('loaded_Licence') || &cp
    finish
endif
let loaded_Licence=1

command PutGPL call Licence#PutGPL()
command PutWTFPL call Licence#PutWTFPL()
