# setwd("D:/curran/Books/Bill/IntroBayes/SelectedAnswers/figures")
# 
# Files = list.files(patt = "^[Ee]x.*pdf$")
# 
# for(f1 in Files){
#   oldName = f1
#   newName = gsub("[Ee]x([0-9]{1,2})\\.([^.]+)\\.pdf$", "ex\\1-\\2.pdf", f1)
#   cmd = paste0("mv ", oldName, " ", newName)
#   cat(paste(cmd, "\n"))
#   system(cmd)
# }
# 
# Lines = readLines("../SelectedAnswers.tex")
# 
# ## remove eps
# incGraphics = grep("^\\\\includegraphics", Lines)
# Lines[incGraphics] = gsub("\\.eps", "", Lines[incGraphics])
# 
# chapter = "SelectedAnswers"
# 
# for(j in incGraphics){
#   picName = gsub("^\\\\includegraphics\\*\\[[^]]+\\]\\{([^}]+)\\}.*$", "\\1", Lines[j])
#   options = gsub("^\\\\includegraphics\\*\\[([^]]+)\\]\\{[^}]+\\}.*$", "\\1", Lines[j])
#   trailing = gsub("^\\\\includegraphics\\*\\[[^]]+\\]\\{[^}]+\\}(.*$)", "\\1", Lines[j])
#   picNewName = gsub("\\.", "-", picName)  
#   newLine = paste0("\\includegraphics*[", options, "]{", chapter, "/figures/", picNewName, "}")
#   if(nchar(trailing)>1)
#     newLine = paste0(newLine, trailing)
#   
#   cat(paste(newLine, "\n"))
#   Lines[j] = newLine
# }
# 
# writeLines(Lines, "../SelectedAnswers.tex")
