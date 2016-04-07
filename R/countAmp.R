countAmp = function(rng = 1:20, root){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)

    tblLoc = cbind(grep("^.*\\\\begin\\{tabular[*]*\\}", Lines) ,grep("^.*\\\\end\\{tabular[*]*\\}", Lines))
    
    nTables = nrow(tblLoc)
    
    for(tbl in 1:nTables){
      start = tblLoc[tbl, 1] + 1 ## the headers have been manually corrected
      end = tblLoc[tbl, 2] -1
      
      tblLines = Lines[start:end]
      tblLines = gsub("[^&]", "", tblLines)
      
      cat(paste0("Table ", tbl, " at line ", start - 1, "\n"))
      cat(paste(nchar(tblLines), "\n"))
      cat(paste("\n"))
    }
  }
}