findRE = function(pattern, rng = 1:20, root){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    i = grep(pattern, Lines, perl = TRUE)
    cat(paste0(f$fName, "\n"))
    cat(paste0(i, ": ", Lines[i], "\n"))
  }
}
    