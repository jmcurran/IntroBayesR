cleanTables = function(rng = 1:20, root, dummyRun = FALSE, promptChange = TRUE){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fullName, f$path, dummyRun)
    
     changed = FALSE
    
    tblLoc = cbind(grep("^.*\\\\begin\\{tabular\\*\\}", Lines) ,grep("^.*\\\\end\\{tabular\\*\\}", Lines))
    
    nTables = nrow(tblLoc)
    
    for(tbl in 1:nTables){
      start = tblLoc[tbl, 1] + 1 ## the headers have been manually corrected
      end = tblLoc[tbl, 2] -1
      
      tblLines = Lines[start:end]
      newtbl = paste(tblLines, collapse = " ")
      newtbl = gsub("(\\\\\\\\[ ]*(\\\\hline)*)", "\\1 \n", newtbl)
      
      response = if(promptChange){
        readline("Replace (y/n)?")
      }else{
        'Y'
      }

      if(grepl("[Yy]", response)){
        Lines[start:end] = ""
        Lines[start] = newtbl
        changed = TRUE
      }
    }
    
    if(changed)
      Lines = Lines[!grepl("^$", Lines)]
    
    if(changed & !dummyRun){
      writeLines(Lines, f$fullName)
    }
  }
}