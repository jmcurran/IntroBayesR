checkEnum = function(root, rng = c(1:20, LETTERS[1:4], "S")){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    
    ## find enum
    if(any(grepl("\\\\begin\\{enumerate\\}", Lines))){
      idx = grep("^\\\\begin\\{enumerate\\}$", Lines)
      
      ## find Exercises
      
      if(any(grepl("\\\\section[*]\\{Exercises\\}", Lines))){
        i2 = grep("\\\\section[*]\\{Exercises\\}", Lines)[1]
        
        if(any(idx < i2)){
          cat(paste0(idx, ": ", Lines[idx], "\n"))
          cat(paste0(i2, ": ", Lines[i2], "\n"))
        }
      }
    }
  }
}
    