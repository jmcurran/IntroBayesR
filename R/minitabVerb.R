minitabVerb = function(rng = 1:20,
                       root,
                       dummyRun = FALSE,
                       promptChange = TRUE) {
  for (i in rng) {
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fullName, f$path, dummyRun)
    
    changed = FALSE
    
    tblLoc = cbind(
      grep("^\\\\begin\\{tabular\\*\\}", Lines) ,
      grep("^\\\\end\\{tabular\\*\\}", Lines)
    )
    
    isHeader = function(line) {
      grepl("^Minitab.*$", line)
    }
    
    for (tbl in 1:nrow(tblLoc)) {
      start = tblLoc[tbl, 1] + 2
      end = tblLoc[tbl, 2] - 1
      
      newLines = gsub("(^.*(;|\\.))([ ]*)(& &.*$)", "\\\\verb|\\1|\\2 \\4", Lines[start:end])
      
      cat(paste(start, ": ", Lines[start:end], "\n"))
      cat(paste(start, ": ", newLines, "\n"))
      
      response = if (promptChange) {
        readline("Replace (y/n)?")
      } else{
        'Y'
      }
      
      if (grepl("[Yy]", response)) {
        Lines[start:end] = newLines
        changed = TRUE
      }
    }
    
    if (changed & !dummyRun) {
      writeLines(Lines, f$fullName)
    }
  }
}