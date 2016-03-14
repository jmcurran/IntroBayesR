stripQuotes = function(rng = 1:20, root, dummyRun = FALSE, promptChange = TRUE){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fullName, f$path, dummyRun)
    quotePairLines = grep("\`\`(.*)\'\'", Lines)
    changed = FALSE
    
    tblLoc = cbind(grep("^\\\\begin\\{tabular\\*\\}", Lines) ,grep("^\\\\end\\{tabular\\*\\}", Lines))
    
    inTable = function(i){
      any(apply(tblLoc, 1, function(row){i >= row[1] && i <= row[2]}))
    }
    
    for(line in quotePairLines){
      if(inTable(line)){
        newLine = gsub("\`\`(.*)\'\'", "\\1", Lines[line])
        cat(paste(line, ": ", Lines[line], "\n"))
        cat(paste(line, ": ", newLine, "\n"))
        
        response = if(promptChange){
          readline("Replace (y/n)?")
        }else{
          'Y'
        }
        
        if(grepl("[Yy]", response)){
          Lines[line] = newLine
          changed = TRUE
        }
      }
    }
    
    if(changed & !dummyRun){
      writeLines(Lines, f$fullName)
    }
  }
}