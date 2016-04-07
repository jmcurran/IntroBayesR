findInd = function(pattern, rng = 1:20, root){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    
    line = paste(Lines, collapse = "\n")
    
    indAll = stringr::str_match_all(line, pattern)[[1]]
    indAllLoc = stringr::str_locate_all(line, pattern)[[1]]
    t2 = which(stringr::str_detect(indAll, ","))
    
    eols = stringr::str_locate_all(line, "\n")[[1]]
    
    for(start in indAllLoc[t2,1]){
      lineIdx = which(eols[,1] - start > 0)[1]
      cat(paste0 ("Line ", lineIdx, ":", Lines[lineIdx], "\n"))
    }
    cat(paste("\n\n"))
  }
}
    