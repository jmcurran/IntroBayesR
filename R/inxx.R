inxx = function(rng = 1:20, dummyRun = FALSE, root = "D:/curran/Books/Bill/IntroBayes"){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
  
    Lines = readLines(f$fullName)
    lines = paste0(Lines, collapse = "\n")
    pat1 = '\\\\inxx\\{([^,]+),([^}]+)\\}'
    
    lines1 = gsub(pat1, "\\\\index{\\1!\\2}", lines, perl = TRUE)
    Lines1 = unlist(strsplit(lines1, "\n"))
    writeBackup(f$fullName, path, dummyRun)
    
    
    
    
    if(!is.logical(result) && !is.null(result$removeLines)){
      if(!dummyRun){
        with(result, {writeLines(Lines[-removeLines], fullName)})
      }
    }else{
      cat("No change\n")
    }
  }
}
