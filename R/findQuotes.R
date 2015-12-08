correctContractions = function(rng){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    quoteLines = grep('"[^"]+"', Lines)
    contractionLines = grep("'t", Lines)
    
    Lines[contractionLines] = gsub("(are|ca|could|did|do|does|is|had|have|were|wo|would)n't", "\\1 not", Lines[contractionLines])
    writeLines(Lines, fName)
    contractionLines = grep("'t", Lines)
    idx = sort(unique(c(quoteLines, contractionLines)))
    
    ##Lines[quoteLines] = gsub('"([^"]+)"', "``\\1''", Lines[quoteLines])
    cat(paste(idx, ":", Lines[idx], "\n"))
  }
}

fixCannot = function(rng){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    fName = paste0("../Chapter", part, "/Chapter", part, ".tex")
    cat(fName, "\n")
    
    Lines = readLines(fName)
    contractionLines = grep("(ca|wo) not", Lines)
    
    if(length(contractionLines) > 0){
      Lines[contractionLines] = gsub("ca not", "cannot", Lines[contractionLines])
      Lines[contractionLines] = gsub("wo not", "will not", Lines[contractionLines])
      writeLines(Lines, fName)
      
      cat(paste(contractionLines, ":", Lines[contractionLines], "\n"))
    }
  }
}

findQuotesPairs = function(rng = 1:20, root, dummyRun = FALSE, promptChange = TRUE){
  for(i in rng){
    f = setFileNames(i, root)
    cat(f$fName, "\n")
    
    Lines = readLines(f$fullName)
    writeBackup(f$fullName, f$path, dummyRun)
    quotePairLines = grep('\"[^"]+\"', Lines)
    changed = FALSE
    
    for(line in quotePairLines){
      newLine = gsub('\"([^"]+)\"', "``\\1''", Lines[line])
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
    
    if(changed & !dummyRun)
      writeLines(f$fullName)
  }
}

findQuotes = function(rng = 1:20){
  for(i in rng){
    part = paste0(ifelse(i < 10, "0", ""), i)
    path = fName = paste0("../Chapter", part, "/")
    fName = paste0("Chapter", part, ".tex")
    fullName = paste0(path, fName)
    cat(fName, "\n")
    
    Lines = readLines(fullName)
    writeBackup(Lines, fName, path)
    
    #writeLines(Lines, paste0(fName, ".bak"))
    startQuoteLines = grep('[ ]+\"', Lines)
    endQuoteLines = grep('\"[ ]+', Lines)
    quoteLines = c(startQuoteLines, endQuoteLines)
    start = rep(c(TRUE,FALSE), c(length(startQuoteLines), length(endQuoteLines)))
    changed = FALSE
    j = 1
    
    for(line in quoteLines){
      newLine = Lines[line]
      if(start[j]){
        newLine = gsub('[ ]+\"', " ``", Lines[line])
      }else{
        newLine = gsub('\"[ ]+', "'' ", Lines[line])
      }
      
      cat(paste(line, ": ", Lines[line], "\n"))
      cat(paste(line, ": ", newLine, "\n"))
      response = readline("Replace (y/n)?")
      if(grepl("[YyqQ]", response)){
        if(grepl("[Qq]", response)){
          return(0)
        }else{
          Lines[line] = newLine
          changed = TRUE
        }
      }
      j = j + 1
    }
    
    if(changed)
      writeLines(Lines, fullName)
  }
}

