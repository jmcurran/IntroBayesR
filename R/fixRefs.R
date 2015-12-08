secEqnRefs = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    m = grep("(Chapter|Equation|Section|Example|Exercise)[ ]+[0-9]", Lines)
    cat(paste0(m, ": ", Lines[m], "\n"))
  }
}