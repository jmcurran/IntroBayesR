# for(i in 1:20){
#   part = paste0(ifelse(i < 10, "0", ""), i)
#   fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
#   cat(fName, "\n")
#   
#   Lines = readLines(fName)
#   
#   idx = grep("\\\\(Var|E|Co(v|rr))\\\\left\\[(.*)\\\\right\\]", Lines)
#   
#   #idx = grep("(\\\\left\\\\\\[|\\\\right\\\\\\])", Lines)
#   
#   newLines = Lines[idx]
#   #newLines = gsub("\\\\left\\\\\\[", "\\\\left[",  newLines)
#   newLines = gsub("\\\\(Var|E|Cov|Corr)\\\\left\\[(.+)\\\\right\\]", "\\\\\\1[\\2]", newLines)
#   Lines[idx] = newLines
#   cat(paste(newLines, "\n"))
# 
#   writeLines(Lines, fName)
# }