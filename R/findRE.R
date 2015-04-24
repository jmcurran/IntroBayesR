findRE = function(pattern, rng = 1:20, root = "D:/Curran/Books/Bill/IntroBayes"){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0(root, "/Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    i = grep(pattern, Lines, perl = TRUE)
    cat(paste0(fName, "\n"))
    cat(paste0(i, ": ", Lines[i], "\n"))
  }
}
    